/*********************************************************************************************************/
/* SOLUCION I1:																							 */
/*********************************************************************************************************/


/*1. Crear una librería en la ruta C:\I1*/
Libname I1  "C:\I1";

/*2. Escriba la DATA y guardela en la librería creada por usted*/

DATA I1.Salario;
INPUT ID Nombre $ Sexo $ Salario;
cards;
2 Silvia Mujer 1.5
5 Anna Mujer 1.9
9 Magda Mujer 1.3
4 Pere Hombre 1.7
1 Joan Hombre 1.8
6 David Hombre 3.0
10 Carles Hombre 2.1
7 Cristina Mujer 2.2
3 Josep Hombre 2.5
8 Marta Mujer 1.0
;
RUN;

/*3. Crear una variable categorica para el salario*/
/*Sueldo mínimo en Chile al 1 de enero del 2017 es de $264.000*/
DATA Salario_cat;
SET I1.Salario;
Sal_pesos=Salario*264000;
IF Salario < 1.5 THEN Sal_cat=1;
	Else IF Salario < 2.5 THEN Sal_cat=2;
	Else IF Salario < 3.5 THEN Sal_cat=3;
	Else Sal_cat=4;
RUN;

/*4. Agregar estas 3 observaciones a la base de datos previa*/
DATA Salario2;
INPUT ID Nombre $ Sexo $ Salario;
CARDS;
12 Ester Mujer 1.7
11 Oriol Hombre 2.3
13 Rosa Mujer 3.5
;
RUN;

DATA Salario_cat2;
SET Salario2;
Sal_pesos=Salario*264000;
IF Salario <= 1.5 THEN Sal_cat=1;
	Else IF Salario <= 2.5 THEN Sal_cat=2;
	Else IF Salario <= 3.5 THEN Sal_cat=3;
	Else Sal_cat=4;
Run;

DATA I1.Salario_cat;
SET Salario_cat Salario_cat2;
Run;

/*5. Añadir estas nuevas variables a la DATA del punto 4*/
DATA Recorrido;
INPUT id edad nivest $ transp $ tiempo;
CARDS;
13 40 Est_sup Bus 35
9 21 FPII Moto 7
3 35 FPII Coche 55
4 30 Est_sup Coche 45
12 32 FPII Metro 35
6 37 Gr_medio Bus 35
7 35 Est_sup Bus 15
10 28 Gr_medio Metro 25
8 23 Gr_medio Moto 10
1 27 Est_sup Bus 15
2 20 FPII Metro 20
11 29 Gr_medio Coche 50
5 25 Gr_medio Moto 30
;
RUN;

Proc sort DATA=I1.salario_cat; BY ID; RUN;
Proc sort DATA=Recorrido; BY ID; RUN; 
DATA I1.SAL_Rec;
MERGE I1.Salario_cat Recorrido;
BY ID;
RUN;


/*6.Calcular el promedio del salario en pesos, por nivel educacional y sexo. Presentar los resultados en una tabla de doble entrada*/
proc tabulate data=I1.SAL_REC format=dollar12.;
   class nivest sexo;
   var Sal_pesos;
    table nivest*mean, Sexo*Sal_pesos ;
run;

/*7.Calcular el promedio del tiempo entre su casa y el trabaja, por medio de transporte y sexo. Presentar los resultados en una tabla de doble entrada*/
proc tabulate data=I1.SAL_REC ;
   class transp sexo;
   var Tiempo;
    table Transp*mean, Sexo*Tiempo ;
run;

/*8. Realice un histograma de la variable Salario y Edad según Sexo*/

Proc Univariate data=I1.SAL_REC noprint;
class Sexo;
   histogram Sal_pesos Edad;
run;

/*9. En una nueva DATA llamada Medias_Sal en su librería, guarde el promedio(PROM) y la frecuencia (N) del salario por categoría de este*/
Proc SORT DATA=I1.SAL_REC; By Sal_cat;run;
Proc Means DATA=I1.SAL_REC noprint;
Var Sal_pesos;
by Sal_cat;
   output out=I1.Medias_Sal mean=PROM N=FREQ;
Run;
DATA I1.MEDIAS_SAL;
SET I1.MEDIAS_SAL;
KEEP SAL_cat PROM FREQ;
RUN;
