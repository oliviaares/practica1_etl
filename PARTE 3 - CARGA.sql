
-- Olivia Ares
-- Lucia Poyan
-- Claudia Gemeno

USE user066

-- PARTE 3. CARGA
 
-- 1. Verificamos la calidad de los datos transformados
SELECT title, COUNT(*)
FROM raw_titles
GROUP BY title
HAVING COUNT(*) > 1;

SELECT *
FROM raw_titles
WHERE title IN (
    SELECT title
    FROM raw_titles
    GROUP BY title
    HAVING COUNT(*) > 1
)
ORDER BY title;

SELECT title, type, COUNT(*)
FROM raw_titles
GROUP BY title, type
HAVING COUNT(*) > 1;

SELECT title, release_year, COUNT(*)
FROM raw_titles
GROUP BY title, release_year
HAVING COUNT(*) > 1;
-- Hemos visto que hay algunos registros duplicados que son correctos, ya que son peliculas 
-- que tienen un serie con el mismo nombre, pero hay algunos dupliados que se deben a errores
-- que vamos a eliminar:

-- Crear una tabla temporal con los registros únicos
CREATE TEMPORARY TABLE temp_raw_titles AS
SELECT MIN(id) AS id
FROM raw_titles
GROUP BY title, release_year, type;

-- Eliminar los duplicados en la tabla original
DELETE FROM raw_titles
WHERE id NOT IN (SELECT id FROM temp_raw_titles);

-- 2. Confirmar eliminación de duplicados y limpieza de datos
-- Verificar que no hay duplicados por título, año de lanzamiento y tipo
SELECT title, release_year, type, COUNT(*)
FROM raw_titles
GROUP BY title, release_year, type
HAVING COUNT(*) > 1;

-- Confirmar que no hay valores nulos en las columnas clave
SELECT
    COUNT(*) AS total_rows,
    COUNT(CASE WHEN title IS NULL THEN 1 END) AS null_titles,
    COUNT(CASE WHEN release_year IS NULL THEN 1 END) AS null_release_years,
    COUNT(CASE WHEN type IS NULL THEN 1 END) AS null_types
FROM raw_titles;


-- 3. Validar relaciones con los otros conjuntos de datos
-- Verificar que todos los títulos en best_movies_netflix están en raw_titles
SELECT bmn.title
FROM best_movies_netflix bmn
LEFT JOIN raw_titles rt ON bmn.title = rt.title
WHERE rt.title IS NULL;

-- Verificar que todos los títulos en best_shows_netflix están en raw_titles
SELECT bsn.title
FROM best_shows_netflix bsn
LEFT JOIN raw_titles rt ON bsn.title = rt.title
WHERE rt.title IS NULL;


-- 4. Preparar las dimensiones y la tabla de hechos
-- Crear tabla de dimensión para géneros
CREATE TABLE dim_genres (
    genre_id INT AUTO_INCREMENT PRIMARY KEY,
    genre_name VARCHAR(255) UNIQUE
);

-- Insertar géneros únicos
INSERT INTO dim_genres (genre_name)
SELECT DISTINCT TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(genres, ',', n.n), ',', -1)) AS genre_name
FROM raw_titles
CROSS JOIN (
    SELECT a.N + b.N * 10 + 1 AS n
    FROM (SELECT 0 AS N UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3) a,
         (SELECT 0 AS N UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3) b
    ) n
WHERE n.n <= LENGTH(genres) - LENGTH(REPLACE(genres, ',', '')) + 1
  AND TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(genres, ',', n.n), ',', -1)) != ''
  AND TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(genres, ',', n.n), ',', -1)) NOT IN (
      SELECT genre_name FROM dim_genres
  );



-- Crear tabla de dimensión para países de producción
CREATE TABLE dim_production_countries (
    production_country_id INT AUTO_INCREMENT PRIMARY KEY,
    production_country_name VARCHAR(255) UNIQUE
);

-- Insertar países únicos
INSERT INTO dim_production_countries (production_country_name)
SELECT DISTINCT TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(production_countries, ',', n.n), ',', -1)) AS production_country_name
FROM raw_titles
CROSS JOIN (
    SELECT a.N + b.N * 10 + 1 AS n
    FROM (SELECT 0 AS N UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3) a,
         (SELECT 0 AS N UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3) b
    ) n
WHERE n.n <= LENGTH(production_countries) - LENGTH(REPLACE(production_countries, ',', '')) + 1
  AND TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(production_countries, ',', n.n), ',', -1)) != ''
  AND TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(production_countries, ',', n.n), ',', -1)) NOT IN (
      SELECT production_country_name FROM dim_production_countries
  );



-- Crear tabla de dimensión para clasificaciones por edad
CREATE TABLE dim_age_certification (
    age_certification_id INT AUTO_INCREMENT PRIMARY KEY,
    age_certification_name VARCHAR(50) UNIQUE
);

-- Insertar certificaciones únicas
INSERT INTO dim_age_certification (age_certification_name)
SELECT DISTINCT age_certification
FROM raw_titles
WHERE age_certification IS NOT NULL;


-- Crear tabla de dimensión para tipos
CREATE TABLE dim_type (
    type_id INT AUTO_INCREMENT PRIMARY KEY,
    type_name VARCHAR(50) UNIQUE
);

-- Insertar tipos únicos
INSERT INTO dim_type (type_name)
SELECT DISTINCT type
FROM raw_titles;


-- Crear tabla de hechos
CREATE TABLE fact_titles (
    fact_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255),
    release_year INT,
    runtime INT,
    imdb_score DECIMAL(3, 1),
    imdb_votes INT,
    type_id INT,
    genre_id INT,
    production_country_id INT,
    age_certification_id INT,
    FOREIGN KEY (type_id) REFERENCES dim_type(type_id),
    FOREIGN KEY (genre_id) REFERENCES dim_genres(genre_id),
    FOREIGN KEY (production_country_id) REFERENCES dim_production_countries(production_country_id),
    FOREIGN KEY (age_certification_id) REFERENCES dim_age_certification(age_certification_id)
);


-- Insertar datos en la tabla de hechos
INSERT INTO fact_titles (
    title, release_year, runtime, imdb_score, imdb_votes, type_id, genre_id, production_country_id, age_certification_id
)
SELECT 
    rt.title,
    rt.release_year,
    rt.runtime,
    rt.imdb_score,
    rt.imdb_votes,
    dt.type_id,
    dg.genre_id,
    dpc.production_country_id,
    dac.age_certification_id
FROM raw_titles rt
LEFT JOIN dim_type dt ON rt.type = dt.type_name
LEFT JOIN dim_genres dg ON TRIM(SUBSTRING_INDEX(rt.genres, ',', 1)) = dg.genre_name
LEFT JOIN dim_production_countries dpc ON TRIM(SUBSTRING_INDEX(rt.production_countries, ',', 1)) = dpc.production_country_name
LEFT JOIN dim_age_certification dac ON rt.age_certification = dac.age_certification_name;


-- Verificar que la tabla de hechos tiene registros
SELECT * FROM fact_titles LIMIT 10;

-- Verificar que las dimensiones tienen registros
SELECT * FROM dim_genres LIMIT 10;
SELECT * FROM dim_production_countries LIMIT 10;
SELECT * FROM dim_age_certification LIMIT 10;
SELECT * FROM dim_type LIMIT 10;

-- Verificar relaciones entre hechos y dimensiones
SELECT ft.*, dt.type_name, dg.genre_name, dpc.production_country_name, dac.age_certification_name
FROM fact_titles ft
JOIN dim_type dt ON ft.type_id = dt.type_id
LEFT JOIN dim_genres dg ON ft.genre_id = dg.genre_id
LEFT JOIN dim_production_countries dpc ON ft.production_country_id = dpc.production_country_id
LEFT JOIN dim_age_certification dac ON ft.age_certification_id = dac.age_certification_id;

-- Validar las tablas de hechos y dimensiones
SELECT COUNT(*) AS registros_totales FROM fact_titles;

-- Vínculos entre tablas
SELECT COUNT(*) AS inconsistency_count
FROM fact_titles ft
LEFT JOIN dim_genres dg ON ft.genre_id = dg.genre_id
WHERE dg.genre_id IS NULL;

SELECT COUNT(*) AS inconsistency_count
FROM fact_titles ft
LEFT JOIN dim_production_countries dpc ON ft.production_country_id = dpc.production_country_id
WHERE dpc.production_country_id IS NULL;

SELECT COUNT(*) AS inconsistency_count
FROM fact_titles ft
LEFT JOIN dim_age_certification dac ON ft.age_certification_id = dac.age_certification_id
WHERE dac.age_certification_id IS NULL;

SELECT COUNT(*) AS inconsistency_count
FROM fact_titles ft
LEFT JOIN dim_type dt ON ft.type_id = dt.type_id
WHERE dt.type_id IS NULL;
