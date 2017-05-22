
*PARTE 1;
libname ej "C:\Practica";

*PARTE 1-a;
PROC IMPORT OUT= ej.Iris 
            DATAFILE= "C:\Practica\DATA_Iris.txt" 
            DBMS=TAB REPLACE;
     GETNAMES=YES;
     DATAROW=2; 
RUN;
proc format;
value fm_type 1='Setosa'
			2='Versicolor'
			3='Virginica'; 
run;
*PARTE 1-b;
proc sort data=ej.IRIS;by Species; format Species fm_type.; run;

PROC MEANS data=ej.IRIS noprint;
var SepalLength SepalWidth;
by Species;
Output out=ej.PromedioSepal mean=Promlen Promwid;
format Species fm_type.;
run;

*PARTE 1-c;
DATA ej.IRIS2;
Merge ej.IRIS(IN=I1) ej.PromedioSepal(IN=I2);
by species;
drop _TYPE_;
format Species fm_type.;
run;


*PARTE 2;

DATA ej.DATOS;
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

*PREGUNTA 3;

ods pdf file= "C:\Practica\creenciasVSraza.pdf";
title 'Creencias v/s Raza';
proc tabulate data=ej.DATOS;
   class Raza Creencia / style=[foreground=black background=beige ];
   classlev Raza Creencia/ style=[foreground=black background=beige ]  ;
   var total / style=[foreground=black background=beige ];
    table Raza*Creencia, 
total*(all='Total')*{style={background=beige}}/
style=[bordercolor=blue foreground=black];  
run;
ods pdf close;
