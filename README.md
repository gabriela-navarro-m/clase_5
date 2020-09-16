<!-- Estilo del HTML -->
<style type="text/css">
  h1 {font-size: 32px;color: #00008B}
  h1.title {font-size: 32px;}
  h2 {font-size: 30px;color: #4169E1}
  h3 {font-size: 26px;}
  h4 {font-size: 24px;}
   p {font-size: 22px; color: black}
  li { font-size: 18px;color: black}
  .table th:not([align]) {text-align: left;} 
</style>

![GitHub](https://img.shields.io/github/license/taller-R/clase_5) [![contributions welcome](https://img.shields.io/badge/contributions-welcome-brightgreen.svg?style=flat)](https://github.com/taller-R/clase_5/issues) ![](https://img.shields.io/github/followers/taller-R?style=social)

<img src="https://avatars0.githubusercontent.com/u/69440432?s=400&u=96b3e58c713578b563d5c3d3c259f34965ac8e33&v=4" align="right" width=120 height=120 alt="" />

# INSTRUCCIONES


## 1. Descargar la clase

Para descargar las clases debes seguir los siguientes pasos:

```{r}
# 1. Establecer el directorio de trabajo en el que quieres descargar la carpeta
setwd("~/Downloads")

# 2. Descargar el repositorio
download.file(url = "https://github.com/taller-R/clase_5/archive/master.zip", 
              destfile = "clase_5.zip")

# 3. Descomprimir las carpeta
unzip(zipfile = "clase_5.zip")

# 4. Cambiar nuevamente el directorio de trabajo
setwd("~/Downloads/clase_5-master")

# 5. Inspeccionar archivos en el directorio 
list.files()
```
O puede seguir [estas](https://eduard-martinez.github.io/blog/github/clonar_github.html) instrucciones para crear una versión de control de Git en Rstudio que contenga este repositorio.  



## 2. Leer las instrucciones iniciales

Después de descargar o clonar el repositorio de la clase, usted debe abrir el archivo **Intro-clase-5.html** que se encuentra dentro de la carpeta del repositorio. Siga atentamente las instrucciones.



## 3. Script de la clase

Ahora puedes ir a la carpeta **codes** y abrir el script **Clase 5.R** para replicar la clase.

![](help/graphs/great.gif)

## 4. Notas

* Los vídeos de la clase se encuentran [aquí](https://www.dropbox.com/sh/pvli5tnvwxc6bep/AADiqBgOhHqq17K44o81hac2a?dl=0). Nota: Dropbox no deja reproducir los vídeos más de 1 hora en linea, debe descargarlos para que pueda verlos completos.

* Por favor hacer todas las correcciones ortográficas a este y los demás archivos **.Rmd** del repositorio.

