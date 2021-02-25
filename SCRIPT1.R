#Ya ubicando lo de filtrar datas frames de filas o columnas y fechas en R en clase 4
#UNIR BASES DE DATOS
# Agregado columnas o variables: join (merge del stata) del paquete dplyr para agregar de un data frame a otro usando un identificador o conjunto de identificadores
#inner_join hace merge de todas todas las obs de la primera base de datos que hacen match
#full_join hace merge de todas todas sin importar si dieron o no match, la que no hace match pone NA
#argumetnos son x, y las bases | by que es la columna de identificador que tienen que hacer match entre ambas | suffixes indica variable que se repiten para diferenciarlas tip var.x para la de x y var.y de la de y
#el by puede ser by=c("var", "var2")
#left_join es para que todos los del primero estén pero los que no hagan match en el segundo se pierden
#right_join hace lo mismo pero al revés, donde deja el segundo con NA pero no con los del primero sin match
#si no hay identificador único se daña el join -para revisar el id único es meterse a duplicated(variable) que devuelve vector con logico en cada uno duplicated(var) %>% table () para mostrar la cnatidad de duplicados
#en ese caso by=c("var1", "var2"="var3") donde toma es cualquiera si se usa full_join o el primero si se usa otro join

#función rbind.fill es para añador observaciones en filas como append

#transponer o pivotear una base: var que se repite en el tiempo se toma como columna [long a wide]
#dcast(data= data_long, formula=var1 de identificación ~ var2 , value.var="var3") con var1 y var 2 las que se quieren poner de columnas con data_long es la base de datos long o pues repetida

#para wide a long es reshape2 o melt
#melt(data=data_wide, id.vars=c("var1"), value.name="varnueva") donde varnueva guarad los valores dentro de la tabla 

#Agrupando variables
#se tiene un dataframe llamado dt y ver una suma de var 3 por cada categoría de var 2 
#dt %>% group_by(var2) %>% summarise(total= sum(var3)) 
#si se quiere un promedio es mean en vez de sum 
#si se hace por más de una var entonces es sin entre comillas ni con la c() entonces es group_by(var2, var1) y devuelve todas las posibles combinaciones
#si se quiere calcular mas de una cosa se divide por comas summarise(varx=mean(var1), vary= min(var3), varz=max(var5)) 