# Elaborado por: Eduard Martinez
# Colaboradores:
# Fecha de elaboracion: 12/02/2020
# Ultima modificacion: 16/02/2021

# intial configuration
rm(list = ls()) # limpia el entorno de R
pacman::p_load(here,tidyverse,reshape2) # cargar y/o instalar paquetes a usar

#Crear 2 objetos que contenga carac y ocupa
carac= readRDS("data/input/Cabecera - Caracteristicas generales (Personas).rds")
ocupa=readRDS("data/input/Cabecera - Ocupados.rds")

#verificar el id unico de la variable
duplicated(carac[,c("directorio", "secuencia_p", "orden")]) %>% table() #no hay ninguno duplicado entonces sí hay uno único
data= full_join(x=carac, y=ocupa, by=c("directorio", "secuencia_p", "orden"))