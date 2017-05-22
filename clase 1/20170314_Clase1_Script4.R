Al <- read.table("C:/20170307 - Clase 1/code/prod/Alumnos.txt",sep=";",header=T)

Ejemplo1_1 <- data.frame(t(matrix(c(1:16),4,4)))
#names(Ejemplo1_1)<-c("v1","v2","v3","v4")
names(Ejemplo1_1)<-paste0("v",1:ncol(Ejemplo1_1))

#################################################
Ejemplo1_2 <- data.frame(Ejemplo1_1$v1,Ejemplo1_1$v2,
                         v5=Ejemplo1_1$v1+Ejemplo1_1$v2)
names(Ejemplo1_2)<-c("v1","v2","v3")  
#################################################
variables<-c("v1","v2")
Ejemplo1_2 <- data.frame(Ejemplo1_1[,names(Ejemplo1_1)%in%variables],
                         v5=Ejemplo1_1$v1+Ejemplo1_1$v2)
#################################################
Ejemplo1_3<-Ejemplo1_2
names(Ejemplo1_3) <- sub("v","s",names(Ejemplo1_2))
#################################################
library(plyr)
Ejemplo1_3 <- rename(Ejemplo1_2,c("v1"="s1","v2"="s2","v5"="s5"))


###################################
Ejemplo2_1 <- merge(Ejemplo1_2,Ejemplo1_3) #no es igual a SAS
Ejemplo2_1 <- data.frame(Ejemplo1_2,Ejemplo1_3) 

###################################
Ejemplo1_4 <- Ejemplo1_3[!Ejemplo1_3$s5>=20,]

###################################
install.packages("data.table")
library(data.table)
x<- data.table(Ejemplo1_3)
y<- data.table(Ejemplo1_4)
library(dplyr)
Ejemplo2_2 <- inner_join(x,y,by="s1")
#retorna todos las filas de x donde se hizo el match con los valores de y

Ejemplo2_2 <- left_join(x,y,by="s1") 
#retorna todos las filas de x y todas las columnas de x e y

Ejemplo2_2 <- right_join(x,y,by="s1")  
#retorna todos las filas de y y todas las columnas de x e y

Ejemplo2_2 <- semi_join(x,y,by="s1")  
#retorna todos las filas de x donde hizo match con y, y guarda solo las columnas de x

Ejemplo2_2 <- anti_join(x,y,by="s1")  
#retorna todos las filas de x donde NO hizo match con y, y guarda solo las columnas de x

Ejemplo2_2 <- full_join(x,y,by="s1")  
#retorna todos las filas de x e y y todas las columnas de x e y
