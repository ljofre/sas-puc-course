/*1. Importar las Datas a SAS a una librería */
Libname Ej '/folders/myshortcuts/sf_SAS/20170330_Clase_4/Ejercicios';

FILENAME REFFILE '/folders/myshortcuts/sf_SAS/20170330_Clase_4/Ejercicios/Año2.xls';
PROC IMPORT DATAFILE=REFFILE
	DBMS=XLS
	OUT=EJ.PTJE_2;
	GETNAMES=YES;
RUN;

FILENAME REFFILE '/folders/myshortcuts/sf_SAS/20170330_Clase_4/Ejercicios/Año1.xls';
PROC IMPORT DATAFILE=REFFILE
	DBMS=XLS
	OUT=EJ.PTJE_1;
	GETNAMES=YES;
RUN;

/*2. Unir las bases de datos por ID */
proc sort data=Ej.Ptje_1 nodupkey; by ID  ; run;
Data Ej.ptje1;
set Ej.ptje_1;
rename COLEGIO=COLEGIO1 nivel_prueba=nivel1 pje=Ptje1;
run;
Proc sort data=Ej.Ptje_2 nodupkey; by ID; run; 
Data Ej.ptje2;
set Ej.ptje_2;
rename COLEGIO=COLEGIO2 nivel_prueba=nivel2 pje=Ptje2;
run;
Data Ej.Ptje;
Merge Ej.ptje1 (in=i1) Ej.ptje2 (in=i2);
by ID;
if i1=i2;
run;

/*3. Eliminar inconsistencia*/
Data Ej. ptje2;
set Ej.ptje;
nivel=nivel2-nivel1;
if nivel=1;
if ptje2=. then delete;
if ptje1=. then delete;
run;

/*4. Calcular el progreso de los estudiantes*/
data ej.progreso;
set ej.ptje2;
prog=Ptje2-Ptje1;
run;

*5. Promedio de estudiantes que se cambian de colegio;
data Ptje3;
set Ej.Ptje2;
cambio=1;
if COLEGIO1=COLEGIO2 then cambio=0;
run;

/*6. Porcentaje de estdiantes que cambiaron de colegio*/
proc sort data=Ptje3; by nivel2;run;
proc means data=Ptje3;
var cambio;
output out=cambio_colegio;
by nivel2;
run;

Data cole;
set cambio_colegio;
if _stat_='MEAN';
keep nivel2 cambio;
run;

Proc means data=cole ;
var cambio;
output out=Stat_cambio;
run;

data x;
set Stat_cambio;
if _STAT_='MAX';
keep cambio;
run;
proc sort data=cole; by cambio;run;
/*7. Nivel que sufrió más cambio*/
data cole2;
merge cole(IN=i1) X(IN=I2) ;
By cambio;
if i1=i2;
run;

proc print; run;

/*8. Ordena la DATA por colegio y nivel el segundo año y calcule el promedio de ambos puntajes*/
proc sort data=ptje3;by colegio2 nivel2;;run;
proc means data=ptje3;
var ptje1 ptje2;
by colegio2 nivel2;
output out=medias;
run;

/* 9. Pegue la media que calculo en el ítem anterior en la data. Es decir para cada estudiante debe tener sus puntajes individuales de los test y además los de su grupo nivel-colegio*/
Data X2;
set medias;
if _STAT_='MEAN';
keep nivel2 colegio2 ptje1 ptje2;
rename ptje1=mean1 ptje2=mean2;
run;

DATA union1;
merge Ptje3(IN=I1) X2(IN=I2);
by colegio2 nivel2;
run;
/* 10. Ahora, calcule el promedio de cambio de estudiantes por nivel año y péguelo a la data anterior.*/
proc means data=union1;
var cambio;
by colegio2 nivel2;
output out=media_c;
run;
data x3;
set media_c;
prom_cam=round(cambio,0.001);
if _STAT_='MEAN';
keep colegio2 nivel2 prom_cam;
run;

data union2;
merge union1(IN=I1) X3(IN=I2);
by colegio2 nivel2;
run;

/* 11. Finalmente la DATA final debe tener las variables ID, Colegio 2, nivel 2, cambio promedio del nivel colegio, puntaje año 1, puntaje año 2, promedio puntaje año 1 nivel colegio, promedio puntaje año 2 nivel colegio. En ese orden.*/
		
Data final;
retain ID colegio2 nivel2 prom_cam ptje1 ptje2 mean1 mean2; 
set union2;
keep ID colegio2 nivel2 prom_cam ptje1 ptje2 mean1 mean2; 
run;

/*12. Realice un histograma por nivel, graficando la distribución normal y que aparezca la media y desviación estándar en el gráfico de la variable progreso creada anteriormente.*/
proc univariate data=ej.progreso;
class nivel2 ;
var prog;
histogram prog/normal(percents=20 40 60 80 midpercents);
inset mean std="Std Dev" / pos = ne format = 6.3;
run;

/*13. Use Proc univariate para el del primer, segundo y tercer cuantil (en SAS Q1 Q2 Q3) por nivel. Guarde los resultados en la librería.*/
proc univariate data=ej.progreso;
var prog;
class nivel2;
output out=ej.est Q1=q1 Q2=q2 Q3=q3 ;
run;
proc sort data=ej.progreso; by nivel2; run;
/*14. Realice un merge entre la base de datos que contiene progreso y los resultados de los cuantiles por nivel del año 2.*/
data union;
merge ej.progreso ej.est;
by nivel2;
run;
/*15. Crea una variable de clasificación*/
data ej.progreso2;
set union;
if prog<q1 then class=1;
else if prog<q2 then class=2;
else if prog<q3 then class=3;
else class=4;
run;

/*16. Calcule el promedio del progreso por esta variable de clasificación y nivel*/
proc sort data=ej.progreso2; by nivel2  class ; run;
proc means data=ej.progreso2;
var prog;
by nivel2  class ;
output out=medias mean=m_prog;
run;

data medias;
set medias;
keep nivel2 class m_prog;
run;

/*17. Exporte a excel una data que contenga las variables nivel-clasificación-media del progreso, donde la hoja del excel se llame medias-prog*/
PROC EXPORT DATA= WORK.MEDIAS 
            OUTFILE= "/folders/myshortcuts/sf_SAS/20170330_Clase_4/Ejercicios/medias.xlsx" 
            DBMS=xlsx REPLACE;
RUN;
