# practica1_etl

# Proyecto ETL: Extracción, Transformación y Carga de Datos

Este proyecto tiene como objetivo diseñar e implementar un proceso ETL (Extract, Transform, Load) para integrar, limpiar y analizar datos de diversas fuentes relacionadas con películas y series. Los datos provienen de plataformas como Netflix e IMDb y se procesan para obtener métricas clave sobre popularidad, géneros, duración y puntuaciones.

## Descripción

En este proyecto, se han trabajado tres datasets principales:

- `raw_titles`: Información de películas y series obtenida de IMDb.
- `best_movies_netflix`: Datos sobre las mejores películas de Netflix.
- `best_shows_netflix`: Datos sobre las mejores series de Netflix.

El proceso ETL incluye las siguientes fases:
1. **Extracción**: Carga de datos desde los archivos CSV.
2. **Transformación**: Métricas de calidad, limpieza de datos, eliminación de duplicados, imputación de valores nulos y normalización.
3. **Carga**: Almacenamiento de los datos transformados en una base de datos SQL, con tablas de hechos y dimensiones.

## Objetivos del Proyecto

- Transformar datos no estructurados en información valiosa para análisis posteriores.
- Analizar patrones de popularidad, géneros más populares y el desempeño de contenido en diferentes plataformas.
- Crear una estructura de base de datos eficiente que facilite consultas complejas.
