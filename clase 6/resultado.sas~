/*Crear una libreria con la ruta*/
LIBNAME practica '/folders/myfolders/lib';

/* importe a su librería usando PROC IMPORT la DARA*/
data practica.iris;
	infile '/folders/myfolders/clase 6/DATA_Iris.txt' delimiter='	' firstobs=2;
	input SepalLength SepalWidth PetalLength PetalWidth Species;
run;

/* lectura de datos de iris */
proc import out=practica.iris 
		datafile='/folders/myfolders/clase 6/DATA_Iris.txt' dbms=tab replace;
run;

/* debemos cambiar 1="Setosa", 2="Verdicolor", 3="virginica"
data practica.iris_new;
	set practica.iris;

	if Species=1 then
		Species_label="Setosa";
	else if Species=2 then
		Species_label="Verdicolor";
	else
		Species_label="virginica";
run;

*/

/* Calcule el promedio de SepalLenght 
SepalWidth por tipo de especie. Guarde los resultados 
en una data llamada PromedioSepal.*/
proc format;
value fm_type 1='Setosa'
			2='Versicolor'
			3='Virginica'; 
run;
proc sort data=practica.iris;by Species; format Species fm_type.; run;

PROC MEANS data=practica.iris noprint;
var SepalLength SepalWidth;
by Species;
Output out=practica.PromedioSepal mean=Promlen Promwid;
format Species fm_type.;
run;

proc print data=practica.promediosepal;

*PARTE 1-c;
DATA practica.iris_mean_merge;
Merge practica.iris(IN=I1) practica.PromedioSepal(IN=I2);
by species;
drop _TYPE_;
format Species fm_type.;
run;

/* pregunta 2 */

DATA practica.creencia_raza;
INPUT Raza $ Creencia $ Total;
CARDS;
Blanca SI 1339
Blanca NO 300
Negra SI 260
Negra NO 55
Otra SI 88
Otra NO 22
;
RUN;

/* pregunta 3 */

ods pdf file= '/folders/myfolders/lib';
title 'Creencias v/s Raza';
proc tabulate data=practica.creencia_raza;
   class Raza Creencia / style=[foreground=black background=beige ];
   classlev Raza Creencia/ style=[foreground=black background=beige ]  ;
   var total / style=[foreground=black background=beige ];
    table Raza*Creencia, 
total*(all='Total')*{style={background=beige}}/
style=[bordercolor=blue foreground=black];  
run;
ods pdf close;




