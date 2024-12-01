
-- Olivia Ares
-- Lucia Poyan
-- Claudia Gemeno

USE user066


-- PARTE 2. TRANSFORMACIÓN

-- 1. Métricas de calidad

-- Data set raw_title 
-- Creamos una tabla temporal para raw_title
CREATE TEMPORARY TABLE quality_metrics_raw_titles (
    column_name VARCHAR(255),
    metric_name VARCHAR(255),
    metric_value DECIMAL(5,2)
);

-- Métricas de calidad para la columna ID en raw_titles

INSERT INTO quality_metrics_raw_titles (column_name, metric_name, metric_value)
SELECT 'id' AS column_name, 
       'precision' AS metric_name, 
       (COUNT(CASE WHEN id REGEXP '^ts[0-9]+$' OR id REGEXP '^tm[0-9]+$' THEN 1 ELSE 0 END) * 100.0) / COUNT(*) AS metric_value
FROM raw_titles
UNION ALL
SELECT 'id', 
       'semantica' AS metric_name, 
       (COUNT(CASE WHEN id REGEXP '^ts[0-9]+$' OR id REGEXP '^tm[0-9]+$' THEN 1 ELSE 0 END) * 100.0) / COUNT(*) AS metric_value
FROM raw_titles
UNION ALL
SELECT 'id', 
       'estructura' AS metric_name, 
       (COUNT(CASE WHEN id REGEXP '^ts[0-9]+$' OR id REGEXP '^tm[0-9]+$' THEN 1 ELSE 0 END) * 100.0) / COUNT(*) AS metric_value
FROM raw_titles
UNION ALL
SELECT 'id', 
       'completitud' AS metric_name, 
       (COUNT(CASE WHEN id IS NOT NULL THEN 1 ELSE 0 END) * 100.0) / COUNT(*) AS metric_value
FROM raw_titles
UNION ALL
SELECT 'id', 
       'consistencia' AS metric_name, 
       (COUNT(DISTINCT id) * 100.0) / COUNT(*) AS metric_value
FROM raw_titles
UNION ALL
SELECT 'id', 
       'razonabilidad' AS metric_name, 
       (COUNT(CASE WHEN id REGEXP '^ts[0-9]+$' OR id REGEXP '^tm[0-9]+$' THEN 1 ELSE 0 END) * 100.0) / COUNT(*) AS metric_value
FROM raw_titles
UNION ALL
SELECT 'id', 
       'identificabilidad' AS metric_name, 
       (COUNT(DISTINCT id) * 100.0) / COUNT(*) AS metric_value
FROM raw_titles;

-- Métricas de calidad para la columna TITLE en raw_titles

INSERT INTO quality_metrics_raw_titles (column_name, metric_name, metric_value)
SELECT 'title' AS column_name, 
       'precision' AS metric_name, 
       (COUNT(CASE WHEN title REGEXP '^[A-Za-z0-9 :\-]+$' THEN 1 ELSE 0 END) * 100.0) / COUNT(*) AS metric_value
FROM raw_titles
UNION ALL
SELECT 'title', 
       'semantica' AS metric_name, 
       (COUNT(CASE WHEN title IS NOT NULL AND LENGTH(title) > 0 THEN 1 ELSE 0 END) * 100.0) / COUNT(*) AS metric_value
FROM raw_titles
UNION ALL
SELECT 'title', 
       'estructura' AS metric_name, 
       (COUNT(CASE WHEN LENGTH(title) BETWEEN 1 AND 255 THEN 1 ELSE 0 END) * 100.0) / COUNT(*) AS metric_value
FROM raw_titles
UNION ALL
SELECT 'title', 
       'completitud' AS metric_name, 
       (COUNT(CASE WHEN title IS NOT NULL THEN 1 ELSE 0 END) * 100.0) / COUNT(*) AS metric_value
FROM raw_titles
UNION ALL
SELECT 'title', 
       'consistencia' AS metric_name, 
       (COUNT(DISTINCT title) * 100.0) / COUNT(*) AS metric_value
FROM raw_titles
UNION ALL
SELECT 'title', 
       'razonabilidad' AS metric_name, 
       (COUNT(CASE WHEN LENGTH(title) BETWEEN 3 AND 100 THEN 1 ELSE 0 END) * 100.0) / COUNT(*) AS metric_value
FROM raw_titles
UNION ALL
SELECT 'title', 
       'identificabilidad' AS metric_name, 
       (COUNT(DISTINCT title) * 100.0) / COUNT(*) AS metric_value
FROM raw_titles;

-- Métricas de calidad para la columna RELEASE_YEAR en raw_titles

INSERT INTO quality_metrics_raw_titles (column_name, metric_name, metric_value)
SELECT 'release_year' AS column_name, 
       'precision' AS metric_name, 
       (COUNT(CASE WHEN release_year = FLOOR(release_year) THEN 1 ELSE 0 END) * 100.0) / COUNT(*) AS metric_value
FROM raw_titles
UNION ALL
SELECT 'release_year', 
       'semantica' AS metric_name, 
       (COUNT(CASE WHEN release_year BETWEEN 1900 AND YEAR(CURRENT_DATE) THEN 1 ELSE 0 END) * 100.0) / COUNT(*) AS metric_value
FROM raw_titles
UNION ALL
SELECT 'release_year', 
       'estructura' AS metric_name, 
       (COUNT(CASE WHEN release_year REGEXP '^[0-9]{4}$' THEN 1 ELSE 0 END) * 100.0) / COUNT(*) AS metric_value
FROM raw_titles
UNION ALL
SELECT 'release_year', 
       'completitud' AS metric_name, 
       (COUNT(CASE WHEN release_year IS NOT NULL THEN 1 ELSE 0 END) * 100.0) / COUNT(*) AS metric_value
FROM raw_titles
UNION ALL
SELECT 'release_year', 
       'consistencia' AS metric_name, 
       (COUNT(DISTINCT release_year) * 100.0) / COUNT(*) AS metric_value
FROM raw_titles
UNION ALL
SELECT 'release_year', 
       'razonabilidad' AS metric_name, 
       (COUNT(CASE WHEN release_year BETWEEN 1900 AND YEAR(CURRENT_DATE) THEN 1 ELSE 0 END) * 100.0) / COUNT(*) AS metric_value
FROM raw_titles
UNION ALL
SELECT 'release_year', 
       'identificabilidad' AS metric_name, 
       (COUNT(DISTINCT release_year) * 100.0) / COUNT(*) AS metric_value
FROM raw_titles;

-- Métricas de calidad para la columna TYPE en raw_titles

INSERT INTO quality_metrics_raw_titles (column_name, metric_name, metric_value)
SELECT 'type' AS column_name, 
       'precision' AS metric_name, 
       (COUNT(CASE WHEN type IN ('SHOW', 'MOVIE') THEN 1 ELSE 0 END) * 100.0) / COUNT(*) AS metric_value
FROM raw_titles
UNION ALL
SELECT 'type', 
       'semantica' AS metric_name, 
       (COUNT(CASE WHEN type IN ('SHOW', 'MOVIE') THEN 1 ELSE 0 END) * 100.0) / COUNT(*) AS metric_value
FROM raw_titles
UNION ALL
SELECT 'type', 
       'estructura' AS metric_name, 
       (COUNT(CASE WHEN type IN ('SHOW', 'MOVIE') THEN 1 ELSE 0 END) * 100.0) / COUNT(*) AS metric_value
FROM raw_titles
UNION ALL
SELECT 'type', 
       'completitud' AS metric_name, 
       (COUNT(CASE WHEN type IS NOT NULL THEN 1 ELSE 0 END) * 100.0) / COUNT(*) AS metric_value
FROM raw_titles
UNION ALL
SELECT 'type', 
       'consistencia' AS metric_name, 
       (COUNT(DISTINCT type) * 100.0) / COUNT(*) AS metric_value
FROM raw_titles
UNION ALL
SELECT 'type', 
       'razonabilidad' AS metric_name, 
       (COUNT(CASE WHEN type IN ('SHOW', 'MOVIE') THEN 1 ELSE 0 END) * 100.0) / COUNT(*) AS metric_value
FROM raw_titles
UNION ALL
SELECT 'type', 
       'identificabilidad' AS metric_name, 
       (COUNT(DISTINCT type) * 100.0) / COUNT(*) AS metric_value
FROM raw_titles;


-- Métricas de calidad para la columna AGE_CERTIFICATION en raw_titles

INSERT INTO quality_metrics_raw_titles (column_name, metric_name, metric_value)
SELECT 'age_certification' AS column_name, 
       'precision' AS metric_name, 
       (COUNT(CASE WHEN age_certification IN ('TV-MA', 'R', 'PG', 'TV-14', 'G', 'PG-13', 'TV-PG', 'TV-Y', 'TV-G', 'TV-Y7', 'NC-17') THEN 1 ELSE 0 END) * 100.0) / COUNT(*) AS metric_value
FROM raw_titles
UNION ALL
SELECT 'age_certification', 
       'semantica' AS metric_name, 
       (COUNT(CASE WHEN age_certification IN ('TV-MA', 'R', 'PG', 'TV-14', 'G', 'PG-13', 'TV-PG', 'TV-Y', 'TV-G', 'TV-Y7', 'NC-17') THEN 1 ELSE 0 END) * 100.0) / COUNT(*) AS metric_value
FROM raw_titles
UNION ALL
SELECT 'age_certification', 
       'estructura' AS metric_name, 
       (COUNT(CASE WHEN age_certification IN ('TV-MA', 'R', 'PG', 'TV-14', 'G', 'PG-13', 'TV-PG', 'TV-Y', 'TV-G', 'TV-Y7', 'NC-17') THEN 1 ELSE 0 END) * 100.0) / COUNT(*) AS metric_value
FROM raw_titles
UNION ALL
SELECT 'age_certification', 
       'completitud' AS metric_name, 
       (COUNT(CASE WHEN age_certification IS NOT NULL THEN 1 ELSE 0 END) * 100.0) / COUNT(*) AS metric_value
FROM raw_titles
UNION ALL
SELECT 'age_certification', 
       'consistencia' AS metric_name, 
       (COUNT(DISTINCT age_certification) * 100.0) / COUNT(*) AS metric_value
FROM raw_titles
UNION ALL
SELECT 'age_certification', 
       'razonabilidad' AS metric_name, 
       (COUNT(CASE WHEN age_certification IN ('TV-MA', 'R', 'PG', 'TV-14', 'G', 'PG-13', 'TV-PG', 'TV-Y', 'TV-G', 'TV-Y7', 'NC-17') THEN 1 ELSE 0 END) * 100.0) / COUNT(*) AS metric_value
FROM raw_titles
UNION ALL
SELECT 'age_certification', 
       'identificabilidad' AS metric_name, 
       (COUNT(DISTINCT age_certification) * 100.0) / COUNT(*) AS metric_value
FROM raw_titles;


-- Métricas de calidad para la columna RUNTIME en raw_titles

INSERT INTO quality_metrics_raw_titles (column_name, metric_name, metric_value)
SELECT 'runtime' AS column_name, 
       'precision' AS metric_name, 
       (COUNT(CASE WHEN runtime = FLOOR(runtime) THEN 1 ELSE 0 END) * 100.0) / COUNT(*) AS metric_value
FROM raw_titles
UNION ALL
SELECT 'runtime', 
       'semantica' AS metric_name, 
       (COUNT(CASE WHEN runtime BETWEEN 10 AND 300 THEN 1 ELSE 0 END) * 100.0) / COUNT(*) AS metric_value
FROM raw_titles
UNION ALL
SELECT 'runtime', 
       'estructura' AS metric_name, 
       (COUNT(CASE WHEN runtime REGEXP '^[0-9]+$' THEN 1 ELSE 0 END) * 100.0) / COUNT(*) AS metric_value
FROM raw_titles
UNION ALL
SELECT 'runtime', 
       'completitud' AS metric_name, 
       (COUNT(CASE WHEN runtime IS NOT NULL THEN 1 ELSE 0 END) * 100.0) / COUNT(*) AS metric_value
FROM raw_titles
UNION ALL
SELECT 'runtime', 
       'consistencia' AS metric_name, 
       (COUNT(DISTINCT runtime) * 100.0) / COUNT(*) AS metric_value
FROM raw_titles
UNION ALL
SELECT 'runtime', 
       'razonabilidad' AS metric_name, 
       (COUNT(CASE WHEN runtime BETWEEN 10 AND 300 THEN 1 ELSE 0 END) * 100.0) / COUNT(*) AS metric_value
FROM raw_titles
UNION ALL
SELECT 'runtime', 
       'identificabilidad' AS metric_name, 
       (COUNT(DISTINCT runtime) * 100.0) / COUNT(*) AS metric_value
FROM raw_titles;


-- Métricas de calidad para la columna GENRES en raw_titles

INSERT INTO quality_metrics_raw_titles (column_name, metric_name, metric_value)
SELECT 'genres' AS column_name, 
       'precision' AS metric_name, 
       (COUNT(CASE WHEN genres IN ('Drama', 'Comedy', 'Action', 'Horror', 'Thriller', 'Romance', 'Documentary', 'Scifi', 'Western', 'Crime', 'War', 'Fantasy', 'Musical', 'Animation', 'Sports', 'Reality', 'Music', 'History', 'European') THEN 1 END) * 100.0) / COUNT(genres) AS metric_value
FROM raw_titles
UNION ALL
SELECT 'genres', 
       'semantica' AS metric_name, 
       (COUNT(CASE WHEN genres IS NOT NULL AND genres != '' THEN 1 END) * 100.0) / COUNT(*) AS metric_value
FROM raw_titles
UNION ALL
SELECT 'genres', 
       'estructura' AS metric_name, 
       (COUNT(CASE WHEN genres REGEXP '^[a-zA-Z, ]+$' THEN 1 END) * 100.0) / COUNT(*) AS metric_value
FROM raw_titles
UNION ALL
SELECT 'genres', 
       'completitud' AS metric_name, 
       (COUNT(CASE WHEN genres IS NOT NULL THEN 1 END) * 100.0) / COUNT(*) AS metric_value
FROM raw_titles
UNION ALL
SELECT 'genres', 
       'consistencia' AS metric_name, 
       (COUNT(DISTINCT genres) * 100.0) / COUNT(*) AS metric_value
FROM raw_titles
UNION ALL
SELECT 'genres', 
       'razonabilidad' AS metric_name, 
       (COUNT(CASE WHEN genres IN ('Drama', 'Comedy', 'Action', 'Horror', 'Thriller', 'Romance', 'Documentary', 'Scifi', 'Western', 'Crime', 'War', 'Fantasy', 'Musical', 'Animation', 'Sports', 'Reality', 'Music', 'History', 'European') THEN 1 END) * 100.0) / COUNT(genres) AS metric_value
FROM raw_titles
UNION ALL
SELECT 'genres', 
       'identificabilidad' AS metric_name, 
       (COUNT(DISTINCT genres) * 100.0) / COUNT(*) AS metric_value
FROM raw_titles;


-- Métricas de calidad para la columna PRODUCTION_COUNTRIES en raw_titles

INSERT INTO quality_metrics_raw_titles (column_name, metric_name, metric_value)
SELECT 'production_countries' AS column_name, 
       'precision' AS metric_name, 
       (COUNT(CASE WHEN production_countries REGEXP '^[a-zA-Z, ]+$' THEN 1 END) * 100.0) / COUNT(production_countries) AS metric_value
FROM raw_titles
UNION ALL
SELECT 'production_countries', 
       'semantica' AS metric_name, 
       (COUNT(CASE WHEN production_countries IS NOT NULL AND production_countries != '' THEN 1 END) * 100.0) / COUNT(*) AS metric_value
FROM raw_titles
UNION ALL
SELECT 'production_countries', 
       'estructura' AS metric_name, 
       (COUNT(CASE WHEN production_countries REGEXP '^[a-zA-Z, ]+$' THEN 1 END) * 100.0) / COUNT(*) AS metric_value
FROM raw_titles
UNION ALL
SELECT 'production_countries', 
       'completitud' AS metric_name, 
       (COUNT(CASE WHEN production_countries IS NOT NULL THEN 1 END) * 100.0) / COUNT(*) AS metric_value
FROM raw_titles
UNION ALL
SELECT 'production_countries', 
       'consistencia' AS metric_name, 
       (COUNT(DISTINCT production_countries) * 100.0) / COUNT(*) AS metric_value
FROM raw_titles
UNION ALL
SELECT 'production_countries', 
       'razonabilidad' AS metric_name, 
       (COUNT(CASE WHEN production_countries REGEXP '^[a-zA-Z, ]+$' THEN 1 END) * 100.0) / COUNT(*) AS metric_value
FROM raw_titles
UNION ALL
SELECT 'production_countries', 
       'identificabilidad' AS metric_name, 
       (COUNT(DISTINCT production_countries) * 100.0) / COUNT(*) AS metric_value
FROM raw_titles;


-- Métricas de calidad para la columna SEASONS en raw_titles

INSERT INTO quality_metrics_raw_titles (column_name, metric_name, metric_value)
SELECT 'seasons' AS column_name, 
       'precision' AS metric_name, 
       (COUNT(CASE WHEN seasons BETWEEN 1 AND 50 THEN 1 END) * 100.0) / COUNT(seasons) AS metric_value
FROM raw_titles
UNION ALL
SELECT 'seasons', 
       'semantica' AS metric_name, 
       (COUNT(CASE WHEN seasons >= 0 THEN 1 END) * 100.0) / COUNT(*) AS metric_value
FROM raw_titles
UNION ALL
SELECT 'seasons', 
       'estructura' AS metric_name, 
       (COUNT(CASE WHEN seasons REGEXP '^[0-9]+$' THEN 1 END) * 100.0) / COUNT(*) AS metric_value
FROM raw_titles
UNION ALL
SELECT 'seasons', 
       'completitud' AS metric_name, 
       (COUNT(CASE WHEN seasons IS NOT NULL THEN 1 END) * 100.0) / COUNT(*) AS metric_value
FROM raw_titles
UNION ALL
SELECT 'seasons', 
       'consistencia' AS metric_name, 
       (COUNT(DISTINCT seasons) * 100.0) / COUNT(*) AS metric_value
FROM raw_titles
UNION ALL
SELECT 'seasons', 
       'razonabilidad' AS metric_name, 
       (COUNT(CASE WHEN seasons BETWEEN 1 AND 50 THEN 1 END) * 100.0) / COUNT(*) AS metric_value
FROM raw_titles
UNION ALL
SELECT 'seasons', 
       'identificabilidad' AS metric_name, 
       (COUNT(DISTINCT seasons) * 100.0) / COUNT(*) AS metric_value
FROM raw_titles;


-- Métricas de calidad para la columna IMDB_ID en raw_titles

INSERT INTO quality_metrics_raw_titles (column_name, metric_name, metric_value)
SELECT 'imdb_id' AS column_name, 
       'precision' AS metric_name, 
       (COUNT(CASE WHEN imdb_id REGEXP '^tt[0-9]{7,8}$' THEN 1 END) * 100.0) / COUNT(imdb_id) AS metric_value
FROM raw_titles
UNION ALL
SELECT 'imdb_id', 
       'semantica' AS metric_name, 
       (COUNT(CASE WHEN imdb_id IS NOT NULL AND imdb_id LIKE 'tt%' THEN 1 END) * 100.0) / COUNT(*) AS metric_value
FROM raw_titles
UNION ALL
SELECT 'imdb_id', 
       'estructura' AS metric_name, 
       (COUNT(CASE WHEN imdb_id REGEXP '^tt[0-9]{7,8}$' THEN 1 END) * 100.0) / COUNT(*) AS metric_value
FROM raw_titles
UNION ALL
SELECT 'imdb_id', 
       'completitud' AS metric_name, 
       (COUNT(CASE WHEN imdb_id IS NOT NULL THEN 1 END) * 100.0) / COUNT(*) AS metric_value
FROM raw_titles
UNION ALL
SELECT 'imdb_id', 
       'consistencia' AS metric_name, 
       (COUNT(DISTINCT imdb_id) * 100.0) / COUNT(*) AS metric_value
FROM raw_titles
UNION ALL
SELECT 'imdb_id', 
       'razonabilidad' AS metric_name, 
       (COUNT(CASE WHEN imdb_id REGEXP '^tt[0-9]{7,8}$' THEN 1 END) * 100.0) / COUNT(*) AS metric_value
FROM raw_titles
UNION ALL
SELECT 'imdb_id', 
       'identificabilidad' AS metric_name, 
       (COUNT(DISTINCT imdb_id) * 100.0) / COUNT(*) AS metric_value
FROM raw_titles;


-- Métricas de calidad para la columna IMDB_SCORE en raw_titles

INSERT INTO quality_metrics_raw_titles (column_name, metric_name, metric_value)
SELECT 'imdb_score' AS column_name, 
       'precision' AS metric_name, 
       (COUNT(CASE WHEN imdb_score BETWEEN 0 AND 10 THEN 1 END) * 100.0) / COUNT(imdb_score) AS metric_value
FROM raw_titles
UNION ALL
SELECT 'imdb_score', 
       'semantica' AS metric_name, 
       (COUNT(CASE WHEN imdb_score >= 0 AND imdb_score <= 10 THEN 1 END) * 100.0) / COUNT(*) AS metric_value
FROM raw_titles
UNION ALL
SELECT 'imdb_score', 
       'estructura' AS metric_name, 
       (COUNT(CASE WHEN imdb_score REGEXP '^[0-9]+(\.[0-9]*)?$' THEN 1 END) * 100.0) / COUNT(*) AS metric_value
FROM raw_titles
UNION ALL
SELECT 'imdb_score', 
       'completitud' AS metric_name, 
       (COUNT(CASE WHEN imdb_score IS NOT NULL THEN 1 END) * 100.0) / COUNT(*) AS metric_value
FROM raw_titles
UNION ALL
SELECT 'imdb_score', 
       'consistencia' AS metric_name, 
       (COUNT(DISTINCT imdb_score) * 100.0) / COUNT(*) AS metric_value
FROM raw_titles
UNION ALL
SELECT 'imdb_score', 
       'razonabilidad' AS metric_name, 
       (COUNT(CASE WHEN imdb_score BETWEEN 0 AND 10 THEN 1 END) * 100.0) / COUNT(*) AS metric_value
FROM raw_titles
UNION ALL
SELECT 'imdb_score', 
       'identificabilidad' AS metric_name, 
       (COUNT(DISTINCT imdb_score) * 100.0) / COUNT(*) AS metric_value
FROM raw_titles;


-- Métricas de calidad para la columna IMDB_VOTES en raw_titles

INSERT INTO quality_metrics_raw_titles (column_name, metric_name, metric_value)
SELECT 'imdb_votes' AS column_name, 
       'precision' AS metric_name, 
       (COUNT(CASE WHEN imdb_votes >= 0 THEN 1 END) * 100.0) / COUNT(imdb_votes) AS metric_value
FROM raw_titles
UNION ALL
SELECT 'imdb_votes', 
       'semantica' AS metric_name, 
       (COUNT(CASE WHEN imdb_votes >= 0 THEN 1 END) * 100.0) / COUNT(*) AS metric_value
FROM raw_titles
UNION ALL
SELECT 'imdb_votes', 
       'estructura' AS metric_name, 
       (COUNT(CASE WHEN imdb_votes REGEXP '^[0-9]+$' THEN 1 END) * 100.0) / COUNT(*) AS metric_value
FROM raw_titles
UNION ALL
SELECT 'imdb_votes', 
       'completitud' AS metric_name, 
       (COUNT(CASE WHEN imdb_votes IS NOT NULL THEN 1 END) * 100.0) / COUNT(*) AS metric_value
FROM raw_titles
UNION ALL
SELECT 'imdb_votes', 
       'consistencia' AS metric_name, 
       (COUNT(DISTINCT imdb_votes) * 100.0) / COUNT(*) AS metric_value
FROM raw_titles
UNION ALL
SELECT 'imdb_votes', 
       'razonabilidad' AS metric_name, 
       (COUNT(CASE WHEN imdb_votes >= 0 THEN 1 END) * 100.0) / COUNT(*) AS metric_value
FROM raw_titles
UNION ALL
SELECT 'imdb_votes', 
       'identificabilidad' AS metric_name, 
       (COUNT(DISTINCT imdb_votes) * 100.0) / COUNT(*) AS metric_value
FROM raw_titles;

SELECT * FROM quality_metrics_raw_titles

-- Media de cada métrica para todas las columnas
SELECT 
    metric_name,
    AVG(metric_value) AS average_metric_value
FROM quality_metrics_raw_titles
GROUP BY metric_name;

-- Calcular la media total de todas las métricas
SELECT 
    AVG(average_metric_value) AS overall_quality_score
FROM (
    SELECT 
        AVG(metric_value) AS average_metric_value
    FROM quality_metrics_raw_titles
    GROUP BY metric_name
) AS metric_averages;

-- La calidad del dataset es de un 67,98%

-- Data set best_movies 
-- Creamos una tabla temporal para best_movies
CREATE TEMPORARY TABLE quality_metrics_best_movies (
    column_name VARCHAR(255),
    metric_name VARCHAR(255),
    metric_value DECIMAL(5,2)
);


-- Métricas para TITLE
INSERT INTO quality_metrics_best_movies (column_name, metric_name, metric_value)
SELECT 
    'title' AS column_name,
    'precision' AS metric_name,
    (COUNT(CASE WHEN LENGTH(TITLE) <= 255 THEN 1 ELSE 0 END) * 100.0) / COUNT(TITLE) AS metric_value
FROM best_movies_netflix
UNION ALL
SELECT 
    'title', 
    'semantica',
    (COUNT(CASE WHEN TITLE IS NOT NULL AND TITLE != '' THEN 1 ELSE 0 END) * 100.0) / COUNT(*) AS metric_value
FROM best_movies_netflix
UNION ALL
SELECT 
    'title', 
    'estructura',
    (COUNT(CASE WHEN TITLE REGEXP '^[a-zA-Z0-9 ]+$' THEN 1 ELSE 0 END) * 100.0) / COUNT(*) AS metric_value
FROM best_movies_netflix
UNION ALL
SELECT 
    'title', 
    'completitud',
    (COUNT(CASE WHEN TITLE IS NOT NULL THEN 1 ELSE 0 END) * 100.0) / COUNT(*) AS metric_value
FROM best_movies_netflix
UNION ALL
SELECT 
    'title', 
    'consistencia',
    (COUNT(CASE WHEN rt.title = bm.TITLE THEN 1 ELSE 0 END) * 100.0) / COUNT(*) AS metric_value
FROM best_movies_netflix bm
LEFT JOIN raw_titles rt ON bm.TITLE = rt.title
UNION ALL
SELECT 
    'title', 
    'razonabilidad',
    (COUNT(CASE WHEN LENGTH(TITLE) > 1 AND LENGTH(TITLE) <= 255 THEN 1 ELSE 0 END) * 100.0) / COUNT(*) AS metric_value
FROM best_movies_netflix
UNION ALL
SELECT 
    'title', 
    'identificabilidad',
    (COUNT(DISTINCT TITLE) * 100.0) / COUNT(*) AS metric_value
FROM best_movies_netflix;



-- Métricas para RELEASE_YEAR
INSERT INTO quality_metrics_best_movies (column_name, metric_name, metric_value)
SELECT 
    'release_year' AS column_name,
    'precision' AS metric_name,
    (COUNT(CASE WHEN release_year = FLOOR(release_year) THEN 1 ELSE 0 END) * 100.0) / COUNT(*) AS metric_value
FROM best_movies_netflix
UNION ALL
SELECT 
    'release_year', 
    'semantica',
    (COUNT(CASE WHEN release_year BETWEEN 1900 AND YEAR(CURRENT_DATE) THEN 1 ELSE 0 END) * 100.0) / COUNT(*) AS metric_value
FROM best_movies_netflix
UNION ALL
SELECT 
    'release_year', 
    'estructura',
    (COUNT(CASE WHEN release_year REGEXP '^[0-9]{4}$' THEN 1 ELSE 0 END) * 100.0) / COUNT(*) AS metric_value
FROM best_movies_netflix
UNION ALL
SELECT 
    'release_year', 
    'completitud',
    (COUNT(CASE WHEN release_year IS NOT NULL THEN 1 ELSE 0 END) * 100.0) / COUNT(*) AS metric_value
FROM best_movies_netflix
UNION ALL
SELECT 
    'release_year', 
    'consistencia',
    (COUNT(DISTINCT release_year) * 100.0) / COUNT(*) AS metric_value
FROM best_movies_netflix
UNION ALL
SELECT 
    'release_year', 
    'razonabilidad',
    (COUNT(CASE WHEN release_year BETWEEN 1900 AND EXTRACT(YEAR FROM CURRENT_DATE) THEN 1 ELSE 0 END) * 100.0) / COUNT(*) AS metric_value
FROM best_movies_netflix
UNION ALL
SELECT 
    'release_year', 
    'identificabilidad',
    (COUNT(DISTINCT release_year) * 100.0) / COUNT(*) AS metric_value
FROM best_movies_netflix;


-- Métricas para SCORE
INSERT INTO quality_metrics_best_movies (column_name, metric_name, metric_value)
SELECT 
    'score' AS column_name,
    'precision' AS metric_name,
    (COUNT(CASE WHEN score REGEXP '^[0-9]+\.[0-9]$' THEN 1 ELSE 0 END) * 100.0) / COUNT(*) AS metric_value
FROM best_movies_netflix
UNION ALL
SELECT 
    'score', 
    'semantica',
    (COUNT(CASE WHEN score BETWEEN 0 AND 10 THEN 1 ELSE 0 END) * 100.0) / COUNT(*) AS metric_value
FROM best_movies_netflix
UNION ALL
SELECT 
    'score', 
    'estructura',
    (COUNT(CASE WHEN score REGEXP '^[0-9]+(\.[0-9]+)?$' THEN 1 ELSE 0 END) * 100.0) / COUNT(*) AS metric_value
FROM best_movies_netflix
UNION ALL
SELECT 
    'score', 
    'completitud',
    (COUNT(CASE WHEN score IS NOT NULL THEN 1 ELSE 0 END) * 100.0) / COUNT(*) AS metric_value
FROM best_movies_netflix
UNION ALL
SELECT 
    'score', 
    'consistencia',
    (COUNT(DISTINCT score) * 100.0) / COUNT(*) AS metric_value
FROM best_movies_netflix
UNION ALL
SELECT 
    'score', 
    'razonabilidad',
    (COUNT(CASE WHEN score BETWEEN 0 AND 10 THEN 1 ELSE 0 END) * 100.0) / COUNT(*) AS metric_value
FROM best_movies_netflix
UNION ALL
SELECT 
    'score', 
    'identificabilidad',
    (COUNT(DISTINCT score) * 100.0) / COUNT(*) AS metric_value
FROM best_movies_netflix;


-- Métricas para number_of_votes
INSERT INTO quality_metrics_best_movies (column_name, metric_name, metric_value)
SELECT 'number_of_votes' AS column_name, 
       'precision' AS metric_name,
       (COUNT(CASE WHEN number_of_votes = FLOOR(number_of_votes) THEN 1 ELSE 0 END) * 100.0) / COUNT(*) AS metric_value
FROM best_movies_netflix
UNION ALL
SELECT 'number_of_votes', 
       'semantica' AS metric_name,
       (COUNT(CASE WHEN number_of_votes > 0 THEN 1 ELSE 0 END) * 100.0) / COUNT(*) AS metric_value
FROM best_movies_netflix
UNION ALL
SELECT 'number_of_votes', 
       'estructura' AS metric_name,
       (COUNT(CASE WHEN number_of_votes REGEXP '^[0-9]+$' THEN 1 ELSE 0 END) * 100.0) / COUNT(*) AS metric_value
FROM best_movies_netflix
UNION ALL
SELECT 'number_of_votes', 
       'completitud' AS metric_name,
       (COUNT(CASE WHEN number_of_votes IS NOT NULL THEN 1 ELSE 0 END) * 100.0) / COUNT(*) AS metric_value
FROM best_movies_netflix
UNION ALL
SELECT 'number_of_votes', 
       'consistencia' AS metric_name,
       (COUNT(DISTINCT number_of_votes) * 100.0) / COUNT(*) AS metric_value
FROM best_movies_netflix
UNION ALL
SELECT 'number_of_votes', 
       'razonabilidad' AS metric_name,
       (COUNT(CASE WHEN number_of_votes BETWEEN 100 AND 30000000 THEN 1 ELSE 0 END) * 100.0) / COUNT(*) AS metric_value
FROM best_movies_netflix
UNION ALL
SELECT 'number_of_votes', 
       'identificabilidad' AS metric_name,
       (COUNT(DISTINCT number_of_votes) * 100.0) / COUNT(*) AS metric_value
FROM best_movies_netflix;



-- Métricas para duration
INSERT INTO quality_metrics_best_movies (column_name, metric_name, metric_value)
SELECT 'duration' AS column_name, 
       'precision' AS metric_name,
       (COUNT(CASE WHEN DURATION BETWEEN 10 AND 200 THEN 1 END) * 100.0) / COUNT(DURATION) AS metric_value
FROM best_movies_netflix
UNION ALL
SELECT 'duration', 
       'semantica' AS metric_name,
       (COUNT(CASE WHEN DURATION >= 0 THEN 1 END) * 100.0) / COUNT(*) AS metric_value
FROM best_movies_netflix
UNION ALL
SELECT 'duration', 
       'estructura' AS metric_name,
       (COUNT(CASE WHEN DURATION REGEXP '^[0-9]+$' THEN 1 END) * 100.0) / COUNT(*) AS metric_value
FROM best_movies_netflix
UNION ALL
SELECT 'duration', 
       'completitud' AS metric_name,
       (COUNT(CASE WHEN DURATION IS NOT NULL THEN 1 END) * 100.0) / COUNT(*) AS metric_value
FROM best_movies_netflix
UNION ALL
SELECT 'duration', 
       'consistencia' AS metric_name,
       (COUNT(DISTINCT DURATION) * 100.0) / COUNT(*) AS metric_value
FROM best_movies_netflix
UNION ALL
SELECT 'duration', 
       'razonabilidad' AS metric_name,
       (COUNT(CASE WHEN DURATION BETWEEN 10 AND 300 THEN 1 END) * 100.0) / COUNT(*) AS metric_value
FROM best_movies_netflix
UNION ALL
SELECT 'duration', 
       'identificabilidad' AS metric_name,
       (COUNT(DISTINCT DURATION) * 100.0) / COUNT(*) AS metric_value
FROM best_movies_netflix;



-- Métricas para main_genre
INSERT INTO quality_metrics_best_movies (column_name, metric_name, metric_value)
SELECT 'main_genre' AS column_name, 
       'precision' AS metric_name,
       (COUNT(CASE WHEN MAIN_GENRE IN ('Drama', 'Comedy', 'Action', 'Horror', 'Thriller', 'Romance', 'Documentary', 'Scifi', 'Western', 'Crime', 'War', 'Fantasy', 'Musical', 'Animation', 'Sports') THEN 1 END) * 100.0) / COUNT(MAIN_GENRE) AS metric_value
FROM best_movies_netflix
UNION ALL
SELECT 'main_genre', 
       'semantica' AS metric_name,
       (COUNT(CASE WHEN MAIN_GENRE IS NOT NULL AND MAIN_GENRE != '' THEN 1 END) * 100.0) / COUNT(*) AS metric_value
FROM best_movies_netflix
UNION ALL
SELECT 'main_genre', 
       'estructura' AS metric_name,
       (COUNT(CASE WHEN MAIN_GENRE REGEXP '^[a-zA-Z ]+$' THEN 1 END) * 100.0) / COUNT(*) AS metric_value
FROM best_movies_netflix
UNION ALL
SELECT 'main_genre', 
       'completitud' AS metric_name,
       (COUNT(CASE WHEN MAIN_GENRE IS NOT NULL THEN 1 END) * 100.0) / COUNT(*) AS metric_value
FROM best_movies_netflix
UNION ALL
SELECT 'main_genre', 
       'consistencia' AS metric_name,
       (COUNT(DISTINCT MAIN_GENRE) * 100.0) / COUNT(*) AS metric_value
FROM best_movies_netflix
UNION ALL
SELECT 'main_genre', 
       'razonabilidad' AS metric_name,
       (COUNT(CASE WHEN MAIN_GENRE IN ('Drama', 'Comedy', 'Action', 'Horror', 'Thriller', 'Romance') THEN 1 END) * 100.0) / COUNT(*) AS metric_value
FROM best_movies_netflix
UNION ALL
SELECT 'main_genre', 
       'identificabilidad' AS metric_name,
       (COUNT(DISTINCT MAIN_GENRE) * 100.0) / COUNT(*) AS metric_value
FROM best_movies_netflix;



-- Métricas para main_production
INSERT INTO quality_metrics_best_movies (column_name, metric_name, metric_value)
SELECT 
    'main_production' AS column_name,
    'precision' AS metric_name,
    (COUNT(CASE WHEN main_production IN ('GB', 'US', 'IN', 'UA', 'CD', 'TR', 'ES', 'AU', 'JP', 'ZA', 'HK', 'DE', 'KR', 'CA', 'BE', 'NO', 'NZ', 'MX', 'FR', 'MW', 'TH', 'AR', 'PS', 'HU', 'IT', 'CN', 'PL', 'KH', 'IE', 'BR', 'XX', 'LT', 'NL', 'DK', 'ID') THEN 1 ELSE 0 END) * 100.0) / COUNT(*) AS metric_value
FROM best_movies_netflix
UNION ALL
SELECT 
    'main_production', 
    'semantica',
    (COUNT(CASE WHEN main_production IS NOT NULL AND main_production != '' THEN 1 ELSE 0 END) * 100.0) / COUNT(*) AS metric_value
FROM best_movies_netflix
UNION ALL
SELECT 
    'main_production', 
    'estructura',
    (COUNT(CASE WHEN main_production REGEXP '^[A-Z]{2,3}$' THEN 1 ELSE 0 END) * 100.0) / COUNT(*) AS metric_value
FROM best_movies_netflix
UNION ALL
SELECT 
    'main_production', 
    'completitud',
    (COUNT(CASE WHEN main_production IS NOT NULL THEN 1 ELSE 0 END) * 100.0) / COUNT(*) AS metric_value
FROM best_movies_netflix
UNION ALL
SELECT 
    'main_production', 
    'consistencia',
    (COUNT(DISTINCT main_production) * 100.0) / COUNT(*) AS metric_value
FROM best_movies_netflix
UNION ALL
SELECT 
    'main_production', 
    'razonabilidad',
    (COUNT(CASE WHEN main_production IN ('GB', 'US', 'IN', 'UA', 'CD', 'TR', 'ES', 'AU', 'JP', 'ZA', 'HK', 'DE', 'KR', 'CA', 'BE', 'NO', 'NZ', 'MX', 'FR', 'MW', 'TH', 'AR', 'PS', 'HU', 'IT', 'CN', 'PL', 'KH', 'IE', 'BR', 'XX', 'LT', 'NL', 'DK', 'ID') THEN 1 ELSE 0 END) * 100.0) / COUNT(*) AS metric_value
FROM best_movies_netflix
UNION ALL
SELECT 
    'main_production', 
    'identificabilidad',
    (COUNT(DISTINCT main_production) * 100.0) / COUNT(*) AS metric_value
FROM best_movies_netflix;


-- Media de cada métrica para todas las columnas
SELECT 
    metric_name,
    AVG(metric_value) AS average_metric_value
FROM quality_metrics_best_movies
GROUP BY metric_name;

-- Calcular la media total de todas las métricas
SELECT 
    AVG(average_metric_value) AS overall_quality_score
FROM (
    SELECT 
        AVG(metric_value) AS average_metric_value
    FROM quality_metrics_best_movies
    GROUP BY metric_name
) AS metric_averages;
-- La calidad de este data set es de un 77,9%


-- Data set best_shows
-- Creamos una tabla temporal para best_shows
CREATE TEMPORARY TABLE quality_metrics_best_shows (
    column_name VARCHAR(255),
    metric_name VARCHAR(255),
    metric_value DECIMAL(5,2)
);

-- Métricas para title
INSERT INTO quality_metrics_best_shows (column_name, metric_name, metric_value)
SELECT 
    'title' AS column_name,
    'precision' AS metric_name,
    (COUNT(CASE WHEN title REGEXP '^[A-Za-z0-9 :\-]+$' THEN 1 ELSE 0 END) * 100.0) / COUNT(*) AS metric_value
FROM best_shows_netflix
UNION ALL
SELECT 
    'title',
    'semantica',
    (COUNT(CASE WHEN title IS NOT NULL AND LENGTH(title) > 0 THEN 1 ELSE 0 END) * 100.0) / COUNT(*)
FROM best_shows_netflix
UNION ALL
SELECT 
    'title',
    'estructura',
    (COUNT(CASE WHEN LENGTH(title) BETWEEN 1 AND 255 THEN 1 ELSE 0 END) * 100.0) / COUNT(*)
FROM best_shows_netflix
UNION ALL
SELECT 
    'title',
    'completitud',
    (COUNT(CASE WHEN title IS NOT NULL THEN 1 ELSE 0 END) * 100.0) / COUNT(*)
FROM best_shows_netflix
UNION ALL
SELECT 
    'title',
    'consistencia',
    (COUNT(DISTINCT title) * 100.0) / COUNT(*)
FROM best_shows_netflix
UNION ALL
SELECT 
    'title',
    'razonabilidad',
    (COUNT(CASE WHEN LENGTH(title) BETWEEN 3 AND 100 THEN 1 ELSE 0 END) * 100.0) / COUNT(*)
FROM best_shows_netflix
UNION ALL
SELECT 
    'title',
    'identificabilidad',
    (COUNT(DISTINCT title) * 100.0) / COUNT(*)
FROM best_shows_netflix;


-- Métricas para release_year
INSERT INTO quality_metrics_best_shows (column_name, metric_name, metric_value)
SELECT 
    'release_year' AS column_name,
    'precision' AS metric_name,
    (COUNT(CASE WHEN release_year = FLOOR(release_year) THEN 1 ELSE 0 END) * 100.0) / COUNT(*) AS metric_value
FROM best_shows_netflix
UNION ALL
SELECT 
    'release_year',
    'semantica',
    (COUNT(CASE WHEN release_year BETWEEN 1900 AND YEAR(CURRENT_DATE) THEN 1 ELSE 0 END) * 100.0) / COUNT(*) AS metric_value
FROM best_shows_netflix
UNION ALL
SELECT 
    'release_year',
    'estructura',
    (COUNT(CASE WHEN release_year REGEXP '^[0-9]{4}$' THEN 1 ELSE 0 END) * 100.0) / COUNT(*) AS metric_value
FROM best_shows_netflix
UNION ALL
SELECT 
    'release_year',
    'completitud',
    (COUNT(CASE WHEN release_year IS NOT NULL THEN 1 ELSE 0 END) * 100.0) / COUNT(*) AS metric_value
FROM best_shows_netflix
UNION ALL
SELECT 
    'release_year',
    'consistencia',
    (COUNT(DISTINCT release_year) * 100.0) / COUNT(*) AS metric_value
FROM best_shows_netflix
UNION ALL
SELECT 
    'release_year',
    'razonabilidad',
    (COUNT(CASE WHEN release_year BETWEEN 1900 AND YEAR(CURRENT_DATE) THEN 1 ELSE 0 END) * 100.0) / COUNT(*) AS metric_value
FROM best_shows_netflix
UNION ALL
SELECT 
    'release_year',
    'identificabilidad',
    (COUNT(DISTINCT release_year) * 100.0) / COUNT(*) AS metric_value
FROM best_shows_netflix;


-- Métricas para score
INSERT INTO quality_metrics_best_shows (column_name, metric_name, metric_value)
SELECT 
    'score' AS column_name,
    'precision' AS metric_name,
    (COUNT(CASE WHEN score REGEXP '^[0-9]+\.[0-9]$' THEN 1 ELSE 0 END) * 100.0) / COUNT(*) AS metric_value
FROM best_shows_netflix
UNION ALL
SELECT 
    'score',
    'semantica',
    (COUNT(CASE WHEN score BETWEEN 0 AND 10 THEN 1 ELSE 0 END) * 100.0) / COUNT(*)
FROM best_shows_netflix
UNION ALL
SELECT 
    'score',
    'estructura',
    (COUNT(CASE WHEN score REGEXP '^[0-9]+\.[0-9]$' THEN 1 ELSE 0 END) * 100.0) / COUNT(*)
FROM best_shows_netflix
UNION ALL
SELECT 
    'score',
    'completitud',
    (COUNT(CASE WHEN score IS NOT NULL THEN 1 ELSE 0 END) * 100.0) / COUNT(*)
FROM best_shows_netflix
UNION ALL
SELECT 
    'score',
    'consistencia',
    (COUNT(DISTINCT score) * 100.0) / COUNT(*)
FROM best_shows_netflix
UNION ALL
SELECT 
    'score',
    'razonabilidad',
    (COUNT(CASE WHEN score BETWEEN 0 AND 10 THEN 1 ELSE 0 END) * 100.0) / COUNT(*)
FROM best_shows_netflix
UNION ALL
SELECT 
    'score',
    'identificabilidad',
    (COUNT(DISTINCT score) * 100.0) / COUNT(*)
FROM best_shows_netflix;

-- Métricas para number_of_votes
INSERT INTO quality_metrics_best_shows (column_name, metric_name, metric_value)
SELECT 
    'number_of_votes' AS column_name,
    'precision' AS metric_name,
    (COUNT(CASE WHEN number_of_votes = FLOOR(number_of_votes) THEN 1 ELSE 0 END) * 100.0) / COUNT(*) AS metric_value
FROM best_shows_netflix
UNION ALL
SELECT 
    'number_of_votes',
    'semantica',
    (COUNT(CASE WHEN number_of_votes > 0 THEN 1 ELSE 0 END) * 100.0) / COUNT(*) AS metric_value
FROM best_shows_netflix
UNION ALL
SELECT 
    'number_of_votes',
    'estructura',
    (COUNT(CASE WHEN number_of_votes REGEXP '^[0-9]+$' THEN 1 ELSE 0 END) * 100.0) / COUNT(*) AS metric_value
FROM best_shows_netflix
UNION ALL
SELECT 
    'number_of_votes',
    'completitud',
    (COUNT(CASE WHEN number_of_votes IS NOT NULL THEN 1 ELSE 0 END) * 100.0) / COUNT(*) AS metric_value
FROM best_shows_netflix
UNION ALL
SELECT 
    'number_of_votes',
    'consistencia',
    (COUNT(DISTINCT number_of_votes) * 100.0) / COUNT(*) AS metric_value
FROM best_shows_netflix
UNION ALL
SELECT 
    'number_of_votes',
    'razonabilidad',
    (COUNT(CASE WHEN number_of_votes BETWEEN 100 AND 30000000 THEN 1 ELSE 0 END) * 100.0) / COUNT(*) AS metric_value
FROM best_shows_netflix
UNION ALL
SELECT 
    'number_of_votes',
    'identificabilidad',
    (COUNT(DISTINCT number_of_votes) * 100.0) / COUNT(*) AS metric_value
FROM best_shows_netflix;


-- Métricas para duration
INSERT INTO quality_metrics_best_shows (column_name, metric_name, metric_value)
SELECT 
    'duration' AS column_name,
    'precision' AS metric_name,
    (COUNT(CASE WHEN duration BETWEEN 10 AND 200 THEN 1 ELSE 0 END) * 100.0) / COUNT(*) AS metric_value
FROM best_shows_netflix
UNION ALL
SELECT 
    'duration',
    'semantica',
    (COUNT(CASE WHEN duration >= 0 THEN 1 ELSE 0 END) / COUNT(*)) * 100 AS metric_value
FROM best_shows_netflix
UNION ALL
SELECT 
    'duration',
    'estructura',
    (COUNT(CASE WHEN duration REGEXP '^[0-9]+$' THEN 1 ELSE 0 END) / COUNT(*)) * 100 AS metric_value
FROM best_shows_netflix
UNION ALL
SELECT 
    'duration',
    'completitud',
    (COUNT(CASE WHEN duration IS NOT NULL THEN 1 ELSE 0 END) / COUNT(*)) * 100 AS metric_value
FROM best_shows_netflix
UNION ALL
SELECT 
    'duration',
    'consistencia',
    (COUNT(DISTINCT duration) * 100.0) / COUNT(*) AS metric_value
FROM best_shows_netflix
UNION ALL
SELECT 
    'duration',
    'razonabilidad',
    (COUNT(CASE WHEN duration BETWEEN 10 AND 300 THEN 1 ELSE 0 END) * 100.0) / COUNT(*) AS metric_value
FROM best_shows_netflix
UNION ALL
SELECT 
    'duration',
    'identificabilidad',
    (COUNT(DISTINCT duration) * 100.0) / COUNT(*) AS metric_value
FROM best_shows_netflix;


-- Métricas para number_of_seasons
INSERT INTO quality_metrics_best_shows (column_name, metric_name, metric_value)
SELECT 
    'number_of_seasons' AS column_name,
    'precision' AS metric_name,
    (COUNT(CASE WHEN number_of_seasons = FLOOR(number_of_seasons) THEN 1 ELSE 0 END) * 100.0) / COUNT(*) AS metric_value
FROM best_shows_netflix
UNION ALL
SELECT 
    'number_of_seasons',
    'semantica',
    (COUNT(CASE WHEN number_of_seasons > 0 THEN 1 ELSE 0 END) * 100.0) / COUNT(*) AS metric_value
FROM best_shows_netflix
UNION ALL
SELECT 
    'number_of_seasons',
    'estructura',
    (COUNT(CASE WHEN number_of_seasons REGEXP '^[0-9]+$' THEN 1 ELSE 0 END) * 100.0) / COUNT(*) AS metric_value
FROM best_shows_netflix
UNION ALL
SELECT 
    'number_of_seasons',
    'completitud',
    (COUNT(CASE WHEN number_of_seasons IS NOT NULL THEN 1 ELSE 0 END) * 100.0) / COUNT(*) AS metric_value
FROM best_shows_netflix
UNION ALL
SELECT 
    'number_of_seasons',
    'consistencia',
    (COUNT(DISTINCT number_of_seasons) * 100.0) / COUNT(*) AS metric_value
FROM best_shows_netflix
UNION ALL
SELECT 
    'number_of_seasons',
    'razonabilidad',
    (COUNT(CASE WHEN number_of_seasons BETWEEN 1 AND 20 THEN 1 ELSE 0 END) * 100.0) / COUNT(*) AS metric_value
FROM best_shows_netflix
UNION ALL
SELECT 
    'number_of_seasons',
    'identificabilidad',
    (COUNT(DISTINCT number_of_seasons) * 100.0) / COUNT(*) AS metric_value
FROM best_shows_netflix;


-- Métricas para main_genre
INSERT INTO quality_metrics_best_shows (column_name, metric_name, metric_value)
SELECT 
    'main_genre' AS column_name,
    'precision' AS metric_name,
    (COUNT(CASE WHEN main_genre IN ('drama', 'scifi', 'documentary', 'action', 'comedy', 'western', 'animation', 'crime', 'reality', 'war', 'thriller', 'romance') THEN 1 END) * 100.0) / COUNT(main_genre) AS metric_value
FROM best_shows_netflix
UNION ALL
SELECT 
    'main_genre',
    'semantica',
    (COUNT(CASE WHEN main_genre IS NOT NULL AND main_genre != '' THEN 1 END) * 100.0) / COUNT(*) AS metric_value
FROM best_shows_netflix
UNION ALL
SELECT 
    'main_genre',
    'estructura',
    (COUNT(CASE WHEN main_genre REGEXP '^[a-zA-Z ]+$' THEN 1 END) * 100.0) / COUNT(*) AS metric_value
FROM best_shows_netflix
UNION ALL
SELECT 
    'main_genre',
    'completitud',
    (COUNT(CASE WHEN main_genre IS NOT NULL THEN 1 END) * 100.0) / COUNT(*) AS metric_value
FROM best_shows_netflix
UNION ALL
SELECT 
    'main_genre',
    'consistencia',
    (COUNT(DISTINCT main_genre) * 100.0) / COUNT(*) AS metric_value
FROM best_shows_netflix
UNION ALL
SELECT 
    'main_genre',
    'razonabilidad',
    (COUNT(CASE WHEN main_genre IN ('drama', 'scifi', 'documentary', 'action', 'comedy', 'western', 'animation', 'crime', 'reality', 'war', 'thriller', 'romance') THEN 1 END) * 100.0) / COUNT(*) AS metric_value
FROM best_shows_netflix
UNION ALL
SELECT 
    'main_genre',
    'identificabilidad',
    (COUNT(DISTINCT main_genre) * 100.0) / COUNT(*) AS metric_value
FROM best_shows_netflix;


-- Métricas para main_production
INSERT INTO quality_metrics_best_shows (column_name, metric_name, metric_value)
SELECT 
    'main_production' AS column_name,
    'precision' AS metric_name,
    (COUNT(CASE WHEN main_production REGEXP '^[A-Z]{2}$' THEN 1 ELSE 0 END) * 100.0) / COUNT(*) AS metric_value
FROM best_shows_netflix
UNION ALL
SELECT 
    'main_production',
    'semantica',
    (COUNT(CASE WHEN main_production IN ('US', 'GB', 'IN', 'JP', 'CA', 'DE', 'AU', 'KR', 'DK', 'TR', 'IL', 'ES', 'SE', 'FR', 'BE', 'BR', 'NO', 'IT', 'FI') THEN 1 ELSE 0 END) * 100.0) / COUNT(*) AS metric_value
FROM best_shows_netflix
UNION ALL
SELECT 
    'main_production',
    'estructura',
    (COUNT(CASE WHEN main_production REGEXP '^[A-Z]{2}$' THEN 1 ELSE 0 END) * 100.0) / COUNT(*) AS metric_value
FROM best_shows_netflix
UNION ALL
SELECT 
    'main_production',
    'completitud',
    (COUNT(CASE WHEN main_production IS NOT NULL THEN 1 ELSE 0 END) * 100.0) / COUNT(*) AS metric_value
FROM best_shows_netflix
UNION ALL
SELECT 
    'main_production',
    'consistencia',
    (COUNT(DISTINCT main_production) * 100.0) / COUNT(*) AS metric_value
FROM best_shows_netflix
UNION ALL
SELECT 
    'main_production',
    'razonabilidad',
    (COUNT(CASE WHEN main_production IN ('US', 'GB', 'IN', 'JP', 'CA', 'DE', 'AU', 'KR', 'DK', 'TR', 'IL', 'ES', 'SE', 'FR', 'BE', 'BR', 'NO', 'IT', 'FI') THEN 1 ELSE 0 END) * 100.0) / COUNT(*) AS metric_value
FROM best_shows_netflix
UNION ALL
SELECT 
    'main_production',
    'identificabilidad',
    (COUNT(DISTINCT main_production) * 100.0) / COUNT(*) AS metric_value
FROM best_shows_netflix;
select * from quality_metrics_best_shows

-- Media de cada métrica para todas las columnas
SELECT 
    metric_name,
    AVG(metric_value) AS average_metric_value
FROM quality_metrics_best_shows
GROUP BY metric_name;

-- Calcular la media total de todas las métricas
SELECT 
    AVG(average_metric_value) AS overall_quality_score
FROM (
    SELECT 
        AVG(metric_value) AS average_metric_value
    FROM quality_metrics_best_shows
    GROUP BY metric_name
) AS metric_averages;
-- La calidad de este data set es un 80,6%


-- Para los tres data set, las métricas de integridad, linaje y puntualidad no aplican porque:
-- Integridad: No hay claves foráneas o relaciones cruzadas que validar.
-- Puntualidad: Las columnas no están relacionadas con fechas o tiempos.
-- Linaje: No se evalúa directamente en SQL, ya que requiere documentación externa.

-- 2.  Valores nulos 

-- Valores nulos en raw_titles
-- En primer lugar, visualizamos los registros que tengan celdas vacías para convertirlos en nulos y poder tratarlos
SELECT
    SUM(CASE WHEN id = '' THEN 1 ELSE 0 END) AS empty_id,
    SUM(CASE WHEN title = '' THEN 1 ELSE 0 END) AS empty_title,
    SUM(CASE WHEN type = '' THEN 1 ELSE 0 END) AS empty_type,
    SUM(CASE WHEN release_year = '' THEN 1 ELSE 0 END) AS empty_release_year,
    SUM(CASE WHEN age_certification = '' THEN 1 ELSE 0 END) AS empty_age_certification,
    SUM(CASE WHEN runtime = '' THEN 1 ELSE 0 END) AS empty_runtime,
    SUM(CASE WHEN genres = '' THEN 1 ELSE 0 END) AS empty_genres,
    SUM(CASE WHEN production_countries = '' THEN 1 ELSE 0 END) AS empty_production_countries,
    SUM(CASE WHEN seasons = '' THEN 1 ELSE 0 END) AS empty_seasons,
    SUM(CASE WHEN imdb_id = '' THEN 1 ELSE 0 END) AS empty_imdb_id,
    SUM(CASE WHEN imdb_score = '' THEN 1 ELSE 0 END) AS empty_imdb_score,
    SUM(CASE WHEN imdb_votes = '' THEN 1 ELSE 0 END) AS empty_imdb_votes
FROM 
    raw_titles;
   
-- Actualizar celdas vacías en la columna `title`
UPDATE raw_titles
SET title = NULL
WHERE title = '';

-- Actualizar celdas vacías en la columna `runtime`
UPDATE raw_titles
SET runtime = NULL
WHERE runtime = '';

-- Actualizar celdas vacías en la columna `imdb_id`
UPDATE raw_titles
SET imdb_id = NULL
WHERE imdb_id = '';

-- Actualizar celdas vacías en la columna `age_certification`
UPDATE raw_titles
SET age_certification = NULL
WHERE age_certification = '';
 
-- Actualizar seasons a 0 cuando type es 'movie' y seasons es NULL
UPDATE raw_titles
SET seasons = 0
WHERE type = 'MOVIE' AND seasons IS NULL;
-- Las películas no tienen temporadas, por lo que asignamos 0 a 'seasons' cuando 'type' es 'MOVIE'.

-- Comprobar si quedan películas con seasons NULL 
SELECT *
FROM raw_titles
WHERE type = 'MOVIE' AND seasons IS NULL;

-- Comprobamos que ya no hay registros donde seasons es NULL
SELECT 
    COUNT(*) AS null_seasons_count
FROM raw_titles
WHERE seasons IS NULL;

-- Imputar valores nulos en la columna score
-- Calcular la media de imdb_score y almacenarla en una variable
SET @avg_imdb_score = (SELECT AVG(imdb_score) FROM raw_titles WHERE imdb_score IS NOT NULL);

-- Imputar los valores nulos en imdb_score con la media almacenada en la variable
UPDATE raw_titles
SET imdb_score = @avg_imdb_score
WHERE imdb_score IS NULL;

SELECT COUNT(*) AS null_imdb_score
FROM raw_titles
WHERE imdb_score IS NULL; -- aqui confirmamos que ya no tenemos valores nulos


-- Imputar valores nulos en la columna votes
-- Calcular la media de imdb_votes y almacenarla en una variable
SET @avg_imdb_votes = (SELECT AVG(imdb_votes) FROM raw_titles WHERE imdb_votes IS NOT NULL);

-- Imputar los valores nulos en imdb_votes con la media almacenada en la variable
UPDATE raw_titles
SET imdb_votes = @avg_imdb_votes
WHERE imdb_votes IS NULL;

SELECT COUNT(*) AS null_imdb_votes
FROM raw_titles
WHERE imdb_votes IS NULL; -- aqui confirmamos que ya no tenemos valores nulos


-- Eliminamos el registro con valores nulos en el titulo
DELETE FROM raw_titles WHERE title IS NULL;

-- Rellenamos los valores nulos de la columna 'age_certification' con valor desconocido
UPDATE raw_titles
SET age_certification = 'unknown'
WHERE age_certification IS NULL;


SELECT DISTINCT age_certification
FROM raw_titles; -- confirmamos que no hay inconsistencias


-- Rellenamos los valores nulos de la columna 'imdb_id' con valor desconocido
UPDATE raw_titles
SET imdb_id = 'unknown'
WHERE imdb_id IS NULL;

-- Comprobamos cómo son las filas con valores nulos de la columna 'runtime' para ver cómo tratarlos
SELECT * 
FROM raw_titles 
WHERE runtime IS NULL
-- Observamos que todos los faltantes son de tipo 'SHOW'

-- Rellenamos los valores nulos de la columna 'runtime' con la media de los que no son nulos de tipo SHOW
UPDATE raw_titles rt
JOIN (
    SELECT AVG(runtime) AS avg_runtime
    FROM raw_titles
    WHERE runtime IS NOT NULL AND type = 'SHOW'
) avg_table
SET rt.runtime = avg_table.avg_runtime
WHERE rt.runtime IS NULL 


-- Confirmamos que ya no tenemos valores nulos:
SELECT
	COUNT(*) AS total_rows,
    COUNT(CASE WHEN title IS NULL THEN 1 END) AS null_count_title,
    COUNT(CASE WHEN type IS NULL THEN 1 END) AS null_count_type,
    COUNT(CASE WHEN release_year IS NULL THEN 1 END) AS null_count_release_year,
    COUNT(CASE WHEN age_certification IS NULL THEN 1 END) AS null_count_age_certification,
    COUNT(CASE WHEN runtime IS NULL THEN 1 END) AS null_count_runtime,
    COUNT(CASE WHEN genres IS NULL THEN 1 END) AS null_count_genres,
    COUNT(CASE WHEN production_countries IS NULL THEN 1 END) AS null_count_production_countries,
    COUNT(CASE WHEN seasons IS NULL THEN 1 END) AS null_count_seasons,
    COUNT(CASE WHEN imdb_id IS NULL THEN 1 END) AS null_count_imdb_id,
    COUNT(CASE WHEN imdb_score IS NULL THEN 1 END) AS null_count_imdb_score,
    COUNT(CASE WHEN imdb_votes IS NULL THEN 1 END) AS null_count_imdb_votes
FROM raw_titles;


-- Valores nulos en best_movies
SELECT
    COUNT(*) AS total_rows,
    COUNT(CASE WHEN `index` IS NULL THEN 1 END) AS null_count_index,
    COUNT(CASE WHEN title IS NULL THEN 1 END) AS null_count_title,
    COUNT(CASE WHEN release_year IS NULL THEN 1 END) AS null_count_release_year,
    COUNT(CASE WHEN score IS NULL THEN 1 END) AS null_count_score,
    COUNT(CASE WHEN number_of_votes IS NULL THEN 1 END) AS null_count_number_of_votes,
    COUNT(CASE WHEN duration IS NULL THEN 1 END) AS null_count_duration,
    COUNT(CASE WHEN main_genre IS NULL THEN 1 END) AS null_count_main_genre,
    COUNT(CASE WHEN main_production IS NULL THEN 1 END) AS null_count_main_production
FROM best_movies_netflix;
-- no hay valores nulos

-- Valores nulos en best_shows
SELECT
    COUNT(*) AS total_rows,
    COUNT(CASE WHEN `index` IS NULL THEN 1 END) AS null_count_index,
    COUNT(CASE WHEN title IS NULL THEN 1 END) AS null_count_title,
    COUNT(CASE WHEN release_year IS NULL THEN 1 END) AS null_count_release_year,
    COUNT(CASE WHEN score IS NULL THEN 1 END) AS null_count_score,
    COUNT(CASE WHEN number_of_votes IS NULL THEN 1 END) AS null_count_number_of_votes,
    COUNT(CASE WHEN duration IS NULL THEN 1 END) AS null_count_duration,
    COUNT(CASE WHEN number_of_seasons IS NULL THEN 1 END) AS null_count_number_of_seasons,
    COUNT(CASE WHEN main_genre IS NULL THEN 1 END) AS null_count_main_genre,
    COUNT(CASE WHEN main_production IS NULL THEN 1 END) AS null_count_main_production
FROM best_shows_netflix;
-- no hay valores nulos

-- 2. Normalización
-- Convertir los textos a minúsculas en las tablas
UPDATE raw_titles SET title = LOWER(TRIM(title)), type = LOWER(TRIM(type)), genres = LOWER(TRIM(genres)), production_countries = LOWER(TRIM(production_countries));
UPDATE best_movies_netflix SET title = LOWER(TRIM(title)), main_genre = LOWER(TRIM(main_genre)), main_production = LOWER(TRIM(main_production));
UPDATE best_shows_netflix SET title = LOWER(TRIM(title)), main_genre = LOWER(TRIM(main_genre)), main_production = LOWER(TRIM(main_production));


-- Eliminar corchetes y comillas en las columnas genres y production_countries
UPDATE raw_titles
SET genres = REPLACE(REPLACE(REPLACE(genres, '[', ''), ']', ''), '''', ''),
    production_countries = REPLACE(REPLACE(REPLACE(production_countries, '[', ''), ']', ''), '''', '')
WHERE genres LIKE '%[%]' OR production_countries LIKE '%[%]';
-- Nos damos cuenta que hay filas en las columnas 'production_countries' y 'genres' son solamente corchetes vacios, por lo que al eliminarlos se quedan filas vacías, por lo que vamos a convertirlas en valores nulos y los vamos a tratar


-- Actualizar celdas vacías en la columna `genres`
UPDATE raw_titles
SET genres = NULL
WHERE genres = '';

-- Rellenamos los valores nulos de la columna 'genres' con valor desconocido
UPDATE raw_titles
SET genres = 'unknown'
WHERE genres IS NULL;

-- Actualizar celdas vacías en la columna `production_countries`
UPDATE raw_titles
SET production_countries = NULL
WHERE production_countries = '';

-- Rellenamos los valores nulos de la columna 'production_countries' con valor desconocido
UPDATE raw_titles
SET production_countries = 'unknown'
WHERE production_countries IS NULL;


-- Cambiar a minúsculas las columnas del data set best_movies
ALTER TABLE best_movies_netflix
RENAME COLUMN TITLE TO title;

ALTER TABLE best_movies_netflix
RENAME COLUMN RELEASE_YEAR TO release_year;

ALTER TABLE best_movies_netflix
RENAME COLUMN SCORE TO score;

ALTER TABLE best_movies_netflix
RENAME COLUMN NUMBER_OF_VOTES TO number_of_votes;

ALTER TABLE best_movies_netflix
RENAME COLUMN DURATION TO duration;

ALTER TABLE best_movies_netflix
RENAME COLUMN MAIN_GENRE TO main_genre;

ALTER TABLE best_movies_netflix
RENAME COLUMN MAIN_PRODUCTION TO main_production;


-- Cambiar a minúsculas las columnas del data set best_shows
ALTER TABLE best_shows_netflix
RENAME COLUMN TITLE TO title;

ALTER TABLE best_shows_netflix
RENAME COLUMN RELEASE_YEAR TO release_year;

ALTER TABLE best_shows_netflix
RENAME COLUMN SCORE TO score;

ALTER TABLE best_shows_netflix
RENAME COLUMN NUMBER_OF_VOTES TO number_of_votes;

ALTER TABLE best_shows_netflix
RENAME COLUMN DURATION TO duration;

ALTER TABLE best_shows_netflix
RENAME COLUMN NUMBER_OF_SEASONS TO number_of_seasons;

ALTER TABLE best_shows_netflix
RENAME COLUMN MAIN_GENRE TO main_genre;

ALTER TABLE best_shows_netflix
RENAME COLUMN MAIN_PRODUCTION TO main_production;



-- 4. Consistencia entre tablas
-- Verificar títulos en best_movies_netflix que no están en raw_titles
SELECT bmn.title
FROM best_movies_netflix bmn
LEFT JOIN raw_titles rt ON bmn.title = rt.title
WHERE rt.title IS NULL;

-- Verificar títulos en best_shows_netflix que no están en raw_titles
SELECT bsn.title
FROM best_shows_netflix bsn
LEFT JOIN raw_titles rt ON bsn.title = rt.title
WHERE rt.title IS NULL;
-- Confirmamos que todos los titulos están en raw_titles
