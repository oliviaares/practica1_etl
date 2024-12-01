
-- PARTE 1. EXTRACCIÓN
-- CARGA INICIAL DE DATOS

-- Creación de las tablas
CREATE TABLE raw_titles (
    `index` INT, -- Índice numérico
    id VARCHAR(20), -- Identificador del título
    title VARCHAR(255), -- Título de la película o serie
    type VARCHAR(50), -- Tipo (SHOW/MOVIE)
    release_year INT, -- Año de lanzamiento
    age_certification VARCHAR(10), -- Clasificación por edad
    runtime INT, -- Duración en minutos
    genres VARCHAR(255), -- Géneros como texto
    production_countries VARCHAR(255),
    seasons DECIMAL(4,1), -- Número de temporadas
    imdb_id VARCHAR(20), -- ID de IMDb
    imdb_score DECIMAL(3,1), -- Puntuación en IMDb
    imdb_votes DECIMAL(10,1) -- Número de votos en IMDb
);


CREATE TABLE best_movies_netflix (
    `index` INT,
    TITLE VARCHAR(255),
    RELEASE_YEAR INT,
    SCORE DECIMAL(3, 1),
    NUMBER_OF_VOTES INT,
    DURATION INT,
    MAIN_GENRE VARCHAR(50),
    MAIN_PRODUCTION VARCHAR(2)
);


CREATE TABLE best_shows_netflix (
    `index` INT,
    TITLE VARCHAR(255),
    RELEASE_YEAR INT,
    SCORE DECIMAL(3, 1),
    NUMBER_OF_VOTES INT,
    DURATION INT,
    NUMBER_OF_SEASONS INT,
    MAIN_GENRE VARCHAR(50),
    MAIN_PRODUCTION VARCHAR(2)
);

-- Importamos los datos a las tablas creadas

-- Verificación de los datos cargados
-- Contar registros en cada tabla
SELECT COUNT(*) AS total_rows FROM raw_titles; -- nos devuelve que tiene 5.806 filas
SELECT COUNT(*) AS total_rows FROM best_movies_netflix; -- nos devuelve que tiene 387 filas
SELECT COUNT(*) AS total_rows FROM best_shows_netflix; -- nos devuelve que tiene 246 filas


-- Mostrar los primeros registros
SELECT * FROM raw_titles LIMIT 10;
SELECT * FROM best_movies_netflix LIMIT 10;
SELECT * FROM best_shows_netflix LIMIT 10;


-- Validacion de tipos de datos y formatos:
-- Verificar si los años de lanzamiento son enteros válidos
SELECT release_year
FROM raw_titles
WHERE release_year NOT REGEXP '^[0-9]{4}$'; -- confirmamos que el formado es correcto

-- Revisar si las puntuaciones están en el rango 0-10
SELECT imdb_score
FROM raw_titles
WHERE imdb_score < 0 OR imdb_score > 10; -- confirmamos que todos los valores están dentro del rango 0-10

-- Comprobar que la columna imdb_id sigue el formato 'tt' seguido de 7-8 dígitos
SELECT imdb_id
FROM raw_titles
WHERE imdb_id NOT REGEXP '^tt[0-9]{7,8}$'; -- confirmamos que toda la columna que tiene datos cumple con el formato correcto. No obstante hay algunas filas vacías, que tendremos que tratar más adelante


-- Detección de valores nulos en columnas
-- Contar valores nulos por columna en raw_titles
SELECT 
    COUNT(*) AS total_rows,
    SUM(CASE WHEN production_countries IS NULL THEN 1 ELSE 0 END) AS null_production_countries,
    SUM(CASE WHEN id IS NULL THEN 1 ELSE 0 END) AS null_id,
    SUM(CASE WHEN title IS NULL THEN 1 ELSE 0 END) AS null_title,
    SUM(CASE WHEN type IS NULL THEN 1 ELSE 0 END) AS null_type,
    SUM(CASE WHEN release_year IS NULL THEN 1 ELSE 0 END) AS null_release_year,
    SUM(CASE WHEN runtime IS NULL THEN 1 ELSE 0 END) AS null_main_runtime,
    SUM(CASE WHEN genres IS NULL THEN 1 ELSE 0 END) AS null_genres,
    SUM(CASE WHEN seasons IS NULL THEN 1 ELSE 0 END) AS null_seasons,
    SUM(CASE WHEN imdb_id IS NULL THEN 1 ELSE 0 END) AS null_imdb_id,
    SUM(CASE WHEN imdb_score IS NULL THEN 1 ELSE 0 END) AS null_imdb_socre,
    SUM(CASE WHEN imdb_votes IS NULL THEN 1 ELSE 0 END) AS null_imdb_votes
FROM raw_titles;
-- para este data set si que tenemos columnas con valores nulos, que serán tratados más adelante
   
-- Revisión para best_movies_netflix
SELECT 
    COUNT(*) AS total_rows,
    SUM(CASE WHEN title IS NULL THEN 1 ELSE 0 END) AS null_titles,
    SUM(CASE WHEN release_year IS NULL THEN 1 ELSE 0 END) AS null_release_year,
    SUM(CASE WHEN score IS NULL THEN 1 ELSE 0 END) AS null_score,
    SUM(CASE WHEN number_of_votes IS NULL THEN 1 ELSE 0 END) AS null_votes,
    SUM(CASE WHEN duration IS NULL THEN 1 ELSE 0 END) AS null_duration,
    SUM(CASE WHEN main_genre IS NULL THEN 1 ELSE 0 END) AS null_main_genre,
    SUM(CASE WHEN main_production IS NULL THEN 1 ELSE 0 END) AS null_main_production
FROM best_movies_netflix;
-- En este data set no tenemos valores nulos 

-- Revisión para best_shows_netflix
SELECT 
    COUNT(*) AS total_rows,
    COUNT(CASE WHEN TITLE IS NULL THEN 1 END) AS null_titles,
    COUNT(CASE WHEN RELEASE_YEAR IS NULL THEN 1 END) AS null_release_year,
    COUNT(CASE WHEN SCORE IS NULL THEN 1 END) AS null_scores,
    COUNT(CASE WHEN NUMBER_OF_SEASONS IS NULL THEN 1 END) AS null_seasons,
    COUNT(CASE WHEN NUMBER_OF_VOTES IS NULL THEN 1 END) AS null_number_of_votes,
    COUNT(CASE WHEN DURATION IS NULL THEN 1 END) AS null_duration,
    COUNT(CASE WHEN MAIN_GENRE IS NULL THEN 1 END) AS null_main_genre,
    COUNT(CASE WHEN MAIN_PRODUCTION IS NULL THEN 1 END) AS null_main_production
FROM best_shows_netflix;
-- En este data set no tenemos valores nulos 

-- Analizamos si hay duplicados en nuestros data sets
-- Buscar duplicados en todas las columnas de raw_titles
SELECT 
    COUNT(*) AS total_rows,
    COUNT(CASE WHEN id IN (SELECT id FROM raw_titles GROUP BY id HAVING COUNT(*) > 1) THEN 1 END) AS duplicated_id,
    COUNT(CASE WHEN title IN (SELECT title FROM raw_titles GROUP BY title HAVING COUNT(*) > 1) THEN 1 END) AS duplicated_title,
    COUNT(CASE WHEN type IN (SELECT type FROM raw_titles GROUP BY type HAVING COUNT(*) > 1) THEN 1 END) AS duplicated_type,
    COUNT(CASE WHEN release_year IN (SELECT release_year FROM raw_titles GROUP BY release_year HAVING COUNT(*) > 1) THEN 1 END) AS duplicated_release_year,
    COUNT(CASE WHEN age_certification IN (SELECT age_certification FROM raw_titles GROUP BY age_certification HAVING COUNT(*) > 1) THEN 1 END) AS duplicated_age_certification,
    COUNT(CASE WHEN runtime IN (SELECT runtime FROM raw_titles GROUP BY runtime HAVING COUNT(*) > 1) THEN 1 END) AS duplicated_runtime,
    COUNT(CASE WHEN genres IN (SELECT genres FROM raw_titles GROUP BY genres HAVING COUNT(*) > 1) THEN 1 END) AS duplicated_genres,
    COUNT(CASE WHEN production_countries IN (SELECT production_countries FROM raw_titles GROUP BY production_countries HAVING COUNT(*) > 1) THEN 1 END) AS duplicated_production_countries,
    COUNT(CASE WHEN seasons IN (SELECT seasons FROM raw_titles GROUP BY seasons HAVING COUNT(*) > 1) THEN 1 END) AS duplicated_seasons,
    COUNT(CASE WHEN imdb_id IN (SELECT imdb_id FROM raw_titles GROUP BY imdb_id HAVING COUNT(*) > 1) THEN 1 END) AS duplicated_imdb_id,
    COUNT(CASE WHEN imdb_score IN (SELECT imdb_score FROM raw_titles GROUP BY imdb_score HAVING COUNT(*) > 1) THEN 1 END) AS duplicated_imdb_score,
    COUNT(CASE WHEN imdb_votes IN (SELECT imdb_votes FROM raw_titles GROUP BY imdb_votes HAVING COUNT(*) > 1) THEN 1 END) AS duplicated_imdb_votes
FROM raw_titles;
-- podemos ver que si que hay duplicados, por lo que vamos a analizarlos

SELECT title, release_year, COUNT(*) AS count
FROM raw_titles
GROUP BY title, release_year
HAVING COUNT(*) > 1;

SELECT id, title, release_year, type, COUNT(*) AS count
FROM raw_titles
GROUP BY id, title, release_year, type, age_certification, runtime, genres, production_countries, seasons, imdb_id, imdb_score, imdb_votes
HAVING COUNT(*) > 1;
-- con esto concluimos que no vamos a eliminar los duplicados ya que no hay filas exactamente iguales, simplemente hay valores que se repiten

-- Buscar duplicados en todas las columnas de best_movies_netflix
SELECT 
    COUNT(*) AS total_rows,
    COUNT(CASE WHEN TITLE IN (SELECT TITLE FROM best_movies_netflix GROUP BY TITLE HAVING COUNT(*) > 1) THEN 1 END) AS duplicated_title,
    COUNT(CASE WHEN RELEASE_YEAR IN (SELECT RELEASE_YEAR FROM best_movies_netflix GROUP BY RELEASE_YEAR HAVING COUNT(*) > 1) THEN 1 END) AS duplicated_release_year,
    COUNT(CASE WHEN SCORE IN (SELECT SCORE FROM best_movies_netflix GROUP BY SCORE HAVING COUNT(*) > 1) THEN 1 END) AS duplicated_score,
    COUNT(CASE WHEN NUMBER_OF_VOTES IN (SELECT NUMBER_OF_VOTES FROM best_movies_netflix GROUP BY NUMBER_OF_VOTES HAVING COUNT(*) > 1) THEN 1 END) AS duplicated_number_of_votes,
    COUNT(CASE WHEN DURATION IN (SELECT DURATION FROM best_movies_netflix GROUP BY DURATION HAVING COUNT(*) > 1) THEN 1 END) AS duplicated_duration,
    COUNT(CASE WHEN MAIN_GENRE IN (SELECT MAIN_GENRE FROM best_movies_netflix GROUP BY MAIN_GENRE HAVING COUNT(*) > 1) THEN 1 END) AS duplicated_main_genre,
    COUNT(CASE WHEN MAIN_PRODUCTION IN (SELECT MAIN_PRODUCTION FROM best_movies_netflix GROUP BY MAIN_PRODUCTION HAVING COUNT(*) > 1) THEN 1 END) AS duplicated_main_production
FROM best_movies_netflix;

-- Análisis de combinaciones clave
SELECT title, release_year, COUNT(*) AS count
FROM best_movies_netflix
GROUP BY title, release_year
HAVING COUNT(*) > 1;

-- Verificar filas completamente duplicadas
SELECT title, release_year, score, number_of_votes, duration, main_genre, main_production, COUNT(*) AS count
FROM best_movies_netflix
GROUP BY title, release_year, score, number_of_votes, duration, main_genre, main_production
HAVING COUNT(*) > 1;
-- conservamos los duplicados ya que representan repeticiones válidas

-- Buscar duplicados en todas las columnas de best_shows_netflix
SELECT 
    COUNT(*) AS total_rows,
    COUNT(CASE WHEN TITLE IN (SELECT TITLE FROM best_shows_netflix GROUP BY TITLE HAVING COUNT(*) > 1) THEN 1 END) AS duplicated_title,
    COUNT(CASE WHEN RELEASE_YEAR IN (SELECT RELEASE_YEAR FROM best_shows_netflix GROUP BY RELEASE_YEAR HAVING COUNT(*) > 1) THEN 1 END) AS duplicated_release_year,
    COUNT(CASE WHEN SCORE IN (SELECT SCORE FROM best_shows_netflix GROUP BY SCORE HAVING COUNT(*) > 1) THEN 1 END) AS duplicated_score,
    COUNT(CASE WHEN NUMBER_OF_VOTES IN (SELECT NUMBER_OF_VOTES FROM best_shows_netflix GROUP BY NUMBER_OF_VOTES HAVING COUNT(*) > 1) THEN 1 END) AS duplicated_number_of_votes,
    COUNT(CASE WHEN DURATION IN (SELECT DURATION FROM best_shows_netflix GROUP BY DURATION HAVING COUNT(*) > 1) THEN 1 END) AS duplicated_duration,
    COUNT(CASE WHEN NUMBER_OF_SEASONS IN (SELECT NUMBER_OF_SEASONS FROM best_shows_netflix GROUP BY NUMBER_OF_SEASONS HAVING COUNT(*) > 1) THEN 1 END) AS duplicated_number_of_seasons,
    COUNT(CASE WHEN MAIN_GENRE IN (SELECT MAIN_GENRE FROM best_shows_netflix GROUP BY MAIN_GENRE HAVING COUNT(*) > 1) THEN 1 END) AS duplicated_main_genre,
    COUNT(CASE WHEN MAIN_PRODUCTION IN (SELECT MAIN_PRODUCTION FROM best_shows_netflix GROUP BY MAIN_PRODUCTION HAVING COUNT(*) > 1) THEN 1 END) AS duplicated_main_production
FROM best_shows_netflix;

-- Análisis de combinaciones clave
SELECT title, release_year, COUNT(*) AS count
FROM best_shows_netflix
GROUP BY title, release_year
HAVING COUNT(*) > 1;

-- Verificar filas completamente duplicadas
SELECT title, release_year, score, number_of_votes, duration, number_of_seasons, main_genre, main_production, COUNT(*) AS count
FROM best_shows_netflix
GROUP BY title, release_year, score, number_of_votes, duration, number_of_seasons, main_genre, main_production
HAVING COUNT(*) > 1;
-- conservamos los duplicados ya que representan repeticiones válidas