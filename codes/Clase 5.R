# Elaborado por: Eduard Martinez
# Colaboradores:
# Fecha de elaboracion: 12/02/2020
# Ultima modificacion: 16/02/2021

# intial configuration
rm(list = ls()) # limpia el entorno de R
pacman::p_load(tidyverse,reshape2,readxl) # cargar y/o instalar paquetes a usar

# tydyverse
browseURL(url = "https://www.tidyverse.org", browser = getOption("browser"))

#-----------------------------------------------#
# 1. Unir bases de datos por filas y/o columnas #
#-----------------------------------------------#

#### 1.4 Cargar bases de datos
browseURL(url = "http://microdatos.dane.gov.co/index.php/catalog/659/get_microdata", browser = getOption("browser")) # Fuente: DANE

cg_cabecera = readRDS(file = "data/input/Cabecera - Caracteristicas generales (Personas).rds")
ocu_cabecera = readRDS(file = "data/input/Cabecera - Ocupados.rds")

cg_resto = readRDS(file = "data/input/Resto - Caracteristicas generales (Personas).rds")
ocu_resto = readRDS(file = "data/input/Resto - Ocupados.rds")

#### 1.2 Hacer merge de las bases de datos
browseURL(url = "http://microdatos.dane.gov.co/index.php/catalog/659/data_dictionary", browser = getOption("browser")) # Chequear el diccionario de variables

#### 1.2.1 Chequear el identificador
duplicated(cg_cabecera$directorio) %>% table()

duplicated(paste0(cg_cabecera$directorio,cg_cabecera$secuencia_p)) %>% table()

duplicated(paste0(cg_cabecera$directorio,cg_cabecera$secuencia_p,cg_cabecera$orden)) %>% table() # No hay duplicados en X

duplicated(paste0(deso_cabecera$directorio,ocu_cabecera$secuencia_p,ocu_cabecera$orden)) %>% table() # No hay duplicados en Y

#### 1.2.2 Merge dejando todas las observaciones de caracteristicas generales
cabecera = full_join(x = cg_cabecera , y = deso_cabecera , by = c('directorio','secuencia_p','orden') , suffixes = c('_cg','_deso'))  

resto = full_join(x = cg_resto , y = deso_resto , by = c('directorio','secuencia_p','orden') , suffixes = c('_cg','_deso'))  
View(cg_resto) # Vamos s cambiar los nombres de las variables para poder unirlos con cabecera despues
colnames(cg_resto) = tolower(colnames(cg_resto))
colnames(deso_resto) = tolower(colnames(deso_resto))
resto = full_join(x = cg_resto , y = deso_resto , by = c('directorio','secuencia_p','orden') , suffixes = c('_cg','_deso'))  

#### 1.3 Agregando observaciones 
nacional = plyr::rbind.fill(cabecera,resto)

#### 1.4 Visor de datos DANE
warning('En el Task de la clase usted podra hacer calculos con la GEIH y comparar susu resultados con los de esta app')
browseURL(url = "https://sitios.dane.gov.co/visor-geih/#/visor", browser = getOption("browser"))

#### 1.5 exportar y limpiar la base de datos
saveRDS(object = nacional , file = "data/procesados/GEIH nacional.rds")
rm(list = ls())


#------------------------------#
# 2. Transponer bases de datos #
#------------------------------#

#### 1.1. Podemos obtener ayuda adiccional aqui
browseURL(url = "http://www.cookbook-r.com/Manipulating_data/Converting_data_between_wide_and_long_format/", browser = getOption("browser")) # Paquete reshape2
browseURL(url = "https://seananderson.ca/2013/10/19/reshape/", browser = getOption("browser")) # Paquete reshape2
browseURL(url = "https://cloud.r-project.org/web/packages/data.table/vignettes/datatable-reshape.html", browser = getOption("browser")) # Paquete data.table

#### 1.2. Cargar e inspeccionar las bases de datos
browseURL(url = "https://estadisticas.cepal.org/cepalstat/tabulador/ConsultaIntegrada.asp?", browser = getOption("browser")) # Fuente de los datos
ocupa = readRDS(file = 'data/input/tasa ocupados por sexo.rds') # Ojo esto es la tasa de ocupacion
summary(ocupa)
table(ocupa$country)
table(ocupa$country,is.na(ocupa$tasa))

#### 1.3 Long a wide
ocupa_wide = dcast(data = ocupa, formula =  country + year ~ clase , value.var="tasa")
View(ocupa_wide)

#### 1.4 Wide a long
parlamento = read_excel(path = 'data/input/mujeres_parlamento.xlsx')
summary(parlamento)

parlamento_long = melt(data = parlamento, id.vars = c('country') , value.name="mujeres" )
View(parlamento_long)

#### 1.4.1 Veamos la diferencia entre hombres y mujeres
parlamento_long = mutate(parlamento_long, hombres = 100 - mujeres)

#-----------------#
# 3.Agrupar datos # 
#-----------------#
          
'Veamos la distribucion' 
summary(parlamento_long$hombres)

"Mediana de los ultimos 10 yeasr en los paises de america latina"
parlamento_long %>% group_by(country) %>% summarize(m_hombres = median(hombres) , m_mujeres = median(mujeres)) 
results = parlamento_long %>% group_by(country) %>% summarize(m_hombres = median(hombres) , m_mujeres = median(mujeres) , total = count() , sum())
results = results[order(results$m_hombres,decreasing = T),]

"Promedio por year"
parlamento_long %>% group_by(variable) %>% summarize(m_hombres = mean(hombres) , m_mujeres = mean(mujeres))

#### 1.5.1 Hagamos el mismo ejercicio pero para tasa de ocupacion

"Promedio de los ultimos 10 yeasr en los paises de america latina"
ocupa_wide %>% group_by(country) %>% summarize(m_hombres = median(hombres) , m_mujeres = median(mujeres))

"inspeccionemos los NA"
table(ocupa_wide$country,is.na(ocupa_wide$hombres)) %>% addmargins(.,2) 
table(ocupa_wide$country,is.na(ocupa_wide$mujeres)) %>% addmargins(.,2) 

'Eliminemos los NA y hagamoslo de nuevo'
descript = subset(ocupa_wide,is.na(mujeres) == F)
descript %>% group_by(country) %>% summarize(m_hombres = median(hombres) , m_mujeres = median(mujeres))   



