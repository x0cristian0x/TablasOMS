# Tablas De Crecimiento De La OMS

Son tablas dinámicas de la OMS para determinar el estado nutricional del niño de 0 a 17 años.

En la carpteta tablasOMS se encuentra la creacion del app con el package "golem" de r.

En la carpeta ImagenTablaOMS se creo la app, a traves de un contenedor de docker, para correr la imagen es

```bash
docker build -t tablaOMS
```

```bash
docker run -p 5024:5024 dashboard_ps
```