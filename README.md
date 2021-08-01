# Tablas De Crecimiento De La OMS

Son tablas dinámicas de la OMS para determinar el estado nutricional del niño de 0 a 17 años.

En la carpteta tablasOMS se encuentra la creacion del app con el package "golem" de r.

En la carpeta ImagenTablaOMS se creo la app, a traves de un contenedor de docker, para correr la imagen es

```bash
docker build -t tablaoms .
```

```bash
docker run -p 5024:5024 tablaoms
```

Tambien se encuentra en docker hub:

```bash
docker pull x0cristianx0/tablaoms:version1
```
luego puedes correr con el comando:

```bash
docker run -p 5024:5024 x0cristianx0/tablaoms:version1
```
