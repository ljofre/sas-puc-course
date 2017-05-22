/*
 * 
 * primer script clase 1
 * 
 */

/*creacion de estructuras de datos en sas*/

Data alumnos; *definir la variable alumnos (los comentarios en linea terminan en semicolon);
Input Id Nombre $ sexo $; *por defecto son valores numericos, los string se especifican con signo $;
cards; *indica que las siguientes lineas van en la tabla;
16198755 Leonardo Hombre
10477862 Nancy Mujer
1234 Javier Perro
;
run;
Quit;

/*esta estructura de datos recien creada queda almacenada en works.alumnos y es temporal*/


/*exportar los datos a distintos tipos de archivos y formatos*/

proc export data=work.alumnos
	outfile='/folders/myfolders/clase 1/data/alumnos.txt'
	dbms=tab replace;
	putnames=yes;
run;

/*leer los archivos desde un txt*/ 
proc import out=work.alumnos2
	datafile='/folders/myfolders/clase 1/data/alumnos.txt'
	dbms=tab replace;
run;

/* tambien podemos setear los tipos de variables desde un archivo */
data alumnos3;
infile '/folders/myfolders/clase 1/data/alumnos.txt'
delimiter='	' firstobs=2;
Input Id Nombre $ Sexo $;
Run;

/*podemos crear librerias: qué es una librería.*/

libname EPG3308 '/folders/myfolders/lib';

data EPG3308.alumnos4;
infile '/folders/myfolders/clase 1/data/alumnos.txt'
delimiter='	' firstobs=2;
Input Id Nombre $ Sexo $;
Run;

/* desplegar la informacion */
proc print data=EPG3308.alumnos4;


/*
 * 
 * segundo script clase 1
 * 
 */

Data NUMERO;
infile datalines dsd; * no se que es dsd ;
input x1 x2 x3;
datalines;
1,,3
4,5,
7,8,9
;
run;

data NUMERO2;
infile datalines dsd delimiter='ab';
input X1 X2 X3;
datalines;
a2b3
4a5b6
7a8b
;
Run;

data NUMERO3;
infile datalines missover;
input X1-X5;
datalines;
1 2 3
4 5 6 7 8
9 10 11 12 13
14 15 16 17
;
run;

/*
 * 
 * tercer script clase 1
 * 
 */

/*Ejemplo 1: Creación de BBDD*/	

Data Ejemplo1_1;                      
Input v1 v2 v3 v4; /*v1-v4 Son los nombres de las variables que se van a crear.*/
Cards; * la primera columna es de id;
1 1 2 3 4 
2 5 6 7 8
3 9 10 11 12
4 13 14 15 16 
;          		/*Cards sirve para crear bases de datos en SAS*/
Run;
Quit;          /* Quit es para que el proceso termine*/

Data Ejemplo1_2;                      
Input v1 s2 s3 s4; /*v1-v4 Son los nombres de las variables que se van a crear.*/
Cards; 
1 1 2 3 4
6 5 6 7 8
2 9 10 11 12
5 13 14 15 16 
;          		/*Cards sirve para crear bases de datos en SAS*/
Run;
Quit;          /* Quit es para que el proceso termine*/
proc sort data=Ejemplo1_1; by v1; run;
proc sort data=Ejemplo1_2; by v1; run;

Data Ejemplo2_1;
Merge Ejemplo1_1 Ejemplo1_2;       	/*Une las BBDD hacia el lado*/
by v1;
Run;							    
Quit;


Data Ejemplo1_2;                      
Set Ejemplo1_1(keep=v1 v2); /*Guardar s�lo las variables v1 y v2*/
v5=v1+v2; 				  /*Crea una variable a partir de v1 y v2*/
Run;
proc print;run;
Quit;

Data Ejemplo1_2;                      
Set Ejemplo1_1; /*Guardar s�lo las variables v1 y v2*/
v5=v1+v2; 				  /*Crea una variable a partir de v1 y v2*/
drop V3 V4;
proc print;run;
Quit;

Data Ejemplo1_3;                      
Set Ejemplo1_2;
Rename v1=S1 v2=S2 v5=S5;     		/*Renombra las variables*/
proc print;run;
Quit;


Data Ejemplo1_4;                      
Set Ejemplo1_3;
If S5>2 and S5<20;           		/*Crea una base con observaciones >2 y <20*/
*If s5>=20 ;        		/* Borra las observaciones >=20*/
proc print;run;
Quit;


/*Ejemplo 2: Unión de BBDD*/

Data Ejemplo2_1;
Merge Ejemplo1_2 Ejemplo1_3;       	/*Une las BBDD hacia el lado*/
proc print;run;
Quit;

Data Ejemplo2_2;
*Set Ejemplo1_2 Ejemplo1_3;       	/*Une las BBDD hacia el Abajo, Deben tener el mismo nombre las variables*/
Set Ejemplo1_1 Ejemplo1_2;       	/*Une las BBDD hacia el Abajo, Deben tener el mismo nombre las variables*/
proc print;run;
Quit;

proc print data=Ejemplo1_3;
run;
proc print data=Ejemplo1_4;
run;
Proc Append base=Ejemplo1_3 data=Ejemplo1_4;   /*Similar al set*/
proc print;run;
Quit;

/*Ejemplo 3: Ordenar las BBDD*/
Proc sort Data=Ejemplo1_1;   /*Ordena la Base de Datos por la variable v1*/
*By descending v1;			/*Se detalla de que forma se ordena la variable, por defecto es ascendiente*/
By v1;				
Run;

Proc Print data=Ejemplo1_1;  /*Imprime en el output temporal*/
Run;
Quit;


/*
 * 
 * 
 * primer script clase 2
 * 
 * 
 * 
 */

DATA PESO;
infile '/folders/myfolders/clase 2/20170321_Clase2_Data_Peso2011.txt' encoding='wlatin1'
delimiter=';' firstobs=2;
Input Region $ : 39.  Comuna $ : 20.  
Total MENOS1500 
ENTRE_1500A2499 
ENTRE_2500A2999 
Mayor_igual_3000 
Ignorado;
Run;

DATA EDAD;
infile '/folders/myfolders/clase 2/20170321_Clase2_Data_Edad2011.txt' encoding='wlatin1'
dlm=';' firstobs=2;
Input Region $ : 39.  
	Comuna $ : 20. 
	Total Menor_15 
	Entre15_19 
	Entre20_34 
	Mas_Igual35 
	Ignorado;
Run;

DATA PESO2 (DROP=Total Ignorado);
SET PESO;
PROC PRINT;
RUN;

DATA EDAD2 (KEEP =REGION COMUNA MENOR_15 ENTRE20_34 MAS_iGUAL35);
SET EDAD;
PROC PRINT;
RUN;

DATA PESO_EJEMPLO;
SET PESO2(FIRSTOBS=2 OBS=5);
PROC PRINT;
RUN;

DATA PESO_REGION_M;
SET PESO2 (Where=(Region='Metropolitana de Santiago'));
PROC PRINT;
RUN;

DATA PESO_REGION_3;
SET PESO2 (Where=(Region='De Atacama'));
PROC PRINT;
RUN;

DATA PESO_REGION_M_Sant;
SET PESO2 (Where=(Region='Metropolitana de Santiago' and 
			Comuna='Santiago'));
PROC PRINT;
RUN;

/*
 * 
 * clase 3 vamos que se puede
 * 
 * 
 */

DATA EPG3308;
infile '/folders/myfolders/clase 3/EPG3308.txt' ENCODING='wlatin1'
delimiter=';' firstobs=2;
Input N APELLIDO$ : 39.  NOMBRE$ : 20.  ;
Run; * lectura del  archivo con encoding latino;

DATA Nombre;
SET EPG3308;
contar=0;
DO i=1 to length(APELLIDO);
S1=substr(APELLIDO,i,1);
IF (S1="A" or S1="E" or S1="I" or S1="O" or S1="U" or
	S1="a" or S1="e" or S1="i" or S1="o" or S1="u" or
	S1="á" or S1="é" or S1="í" or S1="ó" or S1="ú" or
	S1="Á" or S1="É" or S1="Í" or S1="Ó" or S1="Ú" ) 
THEN contar=contar+1;
END;
DROP i S1;
PROC PRINT;
RUN; *itera para cada uno de los elementos de la columna, todos al mismo tiempo;

/*ALGUNAS FUNCIONES 
	- substr(ARGUMENTO,Posicion inicial,longitud):
				Extrae desde el argumento los caracteres, tal que comienza desde la posición que se indica como inicial y con la longitud requerida. Por Ejemplo, substr(CAMILO,2,3)=AMI.
	- LENGTH(variable)
				Es la longitud de la variable especificada.
	- SCAN(variable,n,dlm) 
				Extrae la n-ésima posición del string (variable), separando con la clave $dlm$  
	- TRANWRD(variable,"elemento_busca","elemento-reemplazo")
				Encuentra "elemento_busca" y lo reemplaza por "elemento_reemplazo"  
	- LOWCASE/UPCASE 
				reemplaza todas las mayúsculas por minúsculas / la forma inversa
	- FIND(variable, valor)
				Encuentra el valor en la cadena y entrega la posición.
	- Más funciones en SAS help 
*/

/* segunda parte clase 3: iteradores*/

Data Ejemplo1;
n=0;
DO WHILE(n<= 5);
output;
n+1;
END;
RUN;
proc print; run;


data ejemplo2;
set ejemplo1;
do while(n<3);
y=n*2;
n+1;
output;
end;
run;
proc print; run;


data Ejemplo3;
input x1 x2;
do j=1 to 10 while(j<x1);
y1=x1**j;
y2=(x1+x2)**j;
output;
end;
cards;
6 1
11 1
run;
proc print;
run; * todos contra todos;

/*Ejemplos de DO UNTIL*/
data Ejemplo4;
K = 1;
do until(K > 1);
k2=K*2;
output;
K+1;
end;
run;
proc print data=ejemplo4;
run;

data ejemplo5;
input x;
z=0;
do i = 1 to 5 until(z > 5);
   z = z+x*i; 
output;
end;
cards;
1
2
3
4
;
run;
proc print data=ejemplo5;
run;


data ejemplo6;
DO x = 1, 2, 3, 4, 5, 6, 7, 8;
   y = x**2;
   output;
end;
run;


proc print data=ejemplo6 noobs;
run;


/* parte dos clase 3  : resumenes estadisticos*/

data cake;
   input LastName $ 1-12 Age 13-14 PresentScore 16-17 
         TasteScore 19-20 Flavor $ 23-32 Layers 34 ;
   datalines;
Orlando     27 93 80  Vanilla    1
Ramey       32 84 72  Rum        2
Goldston    46 68 75  Vanilla    1
Roe         38 79 73  Vanilla    2
Larsen      23 77 84  Chocolate  .
Davis       51 86 91  Spice      3
Strickland  19 82 79  Chocolate  1
Nguyen      57 77 84  Vanilla    .
Hildenbrand 33 81 83  Chocolate  1
Byron       62 72 87  Vanilla    2
Sanders     26 56 79  Chocolate  1
Jaeger      43 66 74             1
Davis       28 69 75  Chocolate  2
Conrad      69 85 94  Vanilla    1
Walters     55 67 72  Chocolate  2
Rossburger  28 78 81  Spice      2
Matthew     42 81 92  Chocolate  2
Becker      36 62 83  Spice      2
Anderson    27 87 85  Chocolate  1
Merritt     62 73 84  Chocolate  1
;
run;

proc means data=cake n mean max min range std fw=8;
run;


Title 'Ejemplo 2';
Data grade;
   input Name $ 1-8 Gender $ 11 Status $13 Year $ 15-16 
         Section $ 18 Score 20-21 FinalGrade 23-24;
   datalines;
Abbott    F 2 97 A 90 87
Branford  M 1 98 A 92 97
Crandell  M 2 98 B 81 71
Dennison  M 1 97 A 85 72
Edgar     F 1 98 B 89 80
Faust     M 1 97 B 78 73
Greeley   F 2 97 A 82 91
Hart      F 1 98 B 84 80
Isley     M 2 97 A 88 86
Jasper    M 1 97 B 91 93
;
proc means data=grade maxdec=3;
   var Score;
   class Status Year;
   types () status*year;
run;

title 'Ejemplo 3';
proc sort data=Grade out=GradeBySection;
   by section;
run;

proc means data=GradeBySection min max median;
   by Section;
   var Score;
   class Status Year;
run;

proc means data=Grade noprint;
   class Status Year;
   var FinalGrade;
   output out=sumstat mean=AverageGrade
          idgroup (max(score) obs out (name)=BestScore) / ways levels;
run;
proc print data=sumstat; run;

/* 
 * 
 * clase 4
 * 
 PROCEDIMIENTO UNIVARIATE;
		Se usa para obtener una variedad de estadísticos para resumir la distribución de los datos, por ejemplo,
			- Momentos de la muestra.
			- Medidas básicas de locación y variabilidad.
			- Intervalos de confianza para la media, desviación estándar y varianza.
			- Test de normalidad.
			- Cuantiles, intervalos de confianza.
			- Observaciones extremas, valores extremos.
			- Valores missing.
*/

Title 'Ejemplo 1: Presión';
data Presion;
   input PacienteID $ Sistolica Diastolica @@;
   datalines;
CK 120 50  SS 96  60 FR 100 70
CP 120 75  BL 140 90 ES 120 70
CP 165 110 JI 110 40 MC 119 66
FC 125 76  RW 133 60 KD 108 54
DS 110 50  JW 130 80 BH 120 65
JW 134 80  SB 118 76 NS 122 78
GS 122 70  AB 122 78 EC 112 62
HH 122 82
;
proc univariate data=Presion; 
run;

proc univariate data=Presion; 
id pacienteID; *Identifica cual de los pacientes son valores extremo;
run;

title 'ejemplo 2';
Data tableros;
   input espesor @@;
   label espesor = 'Espesor del enchapado (mils)';
   datalines;
3.468 3.428 3.509 3.516 3.461 3.492 3.478 3.556 3.482 3.512
3.490 3.467 3.498 3.519 3.504 3.469 3.497 3.495 3.518 3.523
3.458 3.478 3.443 3.500 3.449 3.525 3.461 3.489 3.514 3.470
3.561 3.506 3.444 3.479 3.524 3.531 3.501 3.495 3.443 3.458
3.481 3.497 3.461 3.513 3.528 3.496 3.533 3.450 3.516 3.476
3.512 3.550 3.441 3.541 3.569 3.531 3.468 3.564 3.522 3.520
3.505 3.523 3.475 3.470 3.457 3.536 3.528 3.477 3.536 3.491
3.510 3.461 3.431 3.502 3.491 3.506 3.439 3.513 3.496 3.539
3.469 3.481 3.515 3.535 3.460 3.575 3.488 3.515 3.484 3.482
3.517 3.483 3.467 3.467 3.502 3.471 3.516 3.474 3.500 3.466
;

run;

proc univariate data=tableros noprint;
   histogram espesor;
run;

proc univariate data=tableros;
   histogram espesor / normal(percents=20 40 60 80 midpercents)
                     name='MyPlot';
   inset n  mean  / pos = NE format = 5.2;

run;

/* MIDPERCENTS: Imprime una tabla con los puntos medios de los intervalos del histograma.*/
/* PERCENTS: Enumera los porcentajes para los cuales se tabulan los cuantiles calculados a partir de datos 
			y los estimados a partir de curvas*/
/* Position = posición
	POS = posición
	Determina la posición de la inserción. 
	La posición al margen(NW-por defecto)*/
	
/*Pueden ver más opciones en: 
http://support.sas.com/documentation/cdl/en/procstat/66703/HTML/default/viewer.htm#procstat_univariate_syntax09.htm*/


title 'ejercicio 3';
data Normal1;
do i=1 to 100;
X= rannor(1)*10+100;
Y=1;
output;
end;
do i=1 to 100;
X= rannor(1)*5+150;
Y=2;
output;
end;
do i=1 to 100;
X= rannor(1)*8+200;
Y=3;
output;
end;
run;

proc univariate data=NORMAL1 noprint;
   class Y;
   histogram X / NCOLS=1 nrows = 3;
   inset mean std="Std Dev" / pos = ne format = 6.3;
run;
proc univariate data=NORMAL1 noprint;
   class Y;
   histogram X /  normal(percents=20 40 60 80 midpercents) NCOLS=1 nrows = 3;
   inset mean std="Std Dev" / pos = ne format = 6.3;
run;

proc univariate data=NORMAL1 noprint;
   class Y;
   histogram X /  normal(percents=20 40 60 80 midpercents) 
    Gamma
	NCOLS=1 nrows = 3;
   inset mean std="Std Dev" / pos = ne format = 6.3;
run;
proc univariate data=NORMAL1 noprint;
   histogram X / kernel(c = 0.20 );
run;


proc univariate data=NORMAL1 noprint;
  qqplot X ;
run;
proc univariate data=NORMAL1 noprint;
   probplot X / normal(mu=150 sigma=10);
run;

proc univariate data=NORMAL1 noprint;
   cdfplot X / normal;
   inset normal(mu sigma);
run;


/*clase 5 summary-tabulate*/

/* PROCEDIMIENTO SUMMARY;
		PROC SUMMARY Invoca el procedimiento, calcula estad�sticos descriptivos
					a trav�s de todas las variables o un grupo de observaciones.
		BY Usted lo especifica si desea calcular los estad�sticos separados por
			grupo.
		CLASS Para especificar variables cuyos valores definen sub grupos para
				el an�lisis.
		FREQ Para especificar la variable cuyos valores especifica la frecuencia
			para cada observaci�n.
		ID Incluye variables de identificaci�n adicionales en el conjunto de salida.*/

proc print data = sashelp.class(where=(age in (12,14,15)));


proc summary data = sashelp.class(where=(age in (12,14,15)));
 class sex age;
 var height;
 output out=ejemplo1 n=hgt_n mean=hgt_mean std=hgt_std;
run;

proc means data = sashelp.class(where=(age in (12,14,15)));
 class sex age;
 var height;
 output out=ejemplo2 n=hgt_n mean=hgt_mean std=hgt_std;
run;

proc summary data = sashelp.class;
 class sex age;
 var height;
 output out=ejemplo3
 mean=hgt_mean
 max=hgt_max
 min=hgt_min
 maxid(height(name))=maxhtname
 minid(height(name))=minhtname;
run;

/* PROCEDIMIENTO TABULATE, 
		PROC TABULATE Invoca el procedimiento, calcula estad�sticos descriptivos
				y los muestra en formato de tabla.
		BY Usted lo especifica si desea calcular los estad�sticos separados por
				grupo.
		CLASS Para especificar variables cuyos valores definen sub grupos para
				el an�lisis.
		CLASSLEV Especifique un estilo para los niveles de las variables de
				clase.
		FREQ Identificar una variable en el conjunto de datos de entrada cuyos
				valores representan la frecuencia de cada observaci�n.*/

data Energia;
   length Estado $2;
   input Region Provincia Estado $ Tipos Gastos;
   datalines;
1 1 ME 1 708
1 1 ME 2 379
1 1 NH 1 597
1 1 NH 2 301
1 1 VT 1 353
1 1 VT 2 188
1 1 MA 1 3264
1 1 MA 2 2498
1 1 RI 1 531
1 1 RI 2 358
1 1 CT 1 2024
1 1 CT 2 1405
1 2 NY 1 8786
1 2 NY 2 7825
1 2 NJ 1 4115
1 2 NJ 2 3558
1 2 PA 1 6478
1 2 PA 2 3695
4 3 MT 1 322
4 3 MT 2 232
4 3 ID 1 392
4 3 ID 2 298
4 3 WY 1 194
4 3 WY 2 184
4 3 CO 1 1215
4 3 CO 2 1173
4 3 NM 1 545
4 3 NM 2 578
4 3 AZ 1 1694
4 3 AZ 2 1448
4 3 UT 1 621
4 3 UT 2 438
4 3 NV 1 493
4 3 NV 2 378
4 4 WA 1 1680
4 4 WA 2 1122
4 4 OR 1 1014
4 4 OR 2 756
4 4 CA 1 10643
4 4 CA 2 10114
4 4 AK 1 349
4 4 AK 2 329
4 4 HI 1 273
4 4 HI 2 298
;
proc tabulate data=energia format=dollar12.;
   class region provincia estado Tipos;
   var Gastos;
    table Region*Provincia*mean, Tipos*Gastos  /printmiss;
run;

proc tabulate data=energia format=dollar12.;
   class region provincia estado Tipos;
   var Gastos;
    table Region*Provincia, Tipos*Gastos  /printmiss;
run;

*OPCIONAL;
proc format;
   value fm_region 1='Tarapaca'
                2='Antofagasta'
                3='Atacama'
                4='Coquimbo';
   value fm_provincia 1='Cordillera'
                2='Pre-Cordillea'
                3='Valle'
                4='Costa';
   value fm_tipo 1='Residencial'
                 2='Empresa';
run;
proc tabulate data=energia format=dollar12. ;
   class region provincia estado Tipos;
   var Gastos;
    table Region*Provincia, Tipos*Gastos  /printmiss;
	format region fm_region. provincia fm_provincia. Tipos fm_tipo.;
	title 'Gastos de Energ�a';
   title2 '(en Pesos)';
run;


*SUMA por FILAS-COLUMNAS;
ods pdf file='/folders/myfolders/clase 5/output.pdf';
proc tabulate data=energia format=dollar12. ;
   class region provincia estado Tipos ;
   var Gastos;
    table Region*(Provincia all='Subtotal')
			all='Total por Regions'*f=dollar12.,
		 Tipos='Clientes'*Gastos=' '*sum=' ' 
			all='Total clientes'*gastos=' '*sum=' ' / 
         style=[bordercolor=blue];
	format region fm_region. provincia fm_provincia. Tipos fm_tipo.;
	title 'Gastos de Energ�a';
   title2 '(en Pesos)';
run;

ods pdf close;

ods pdf file='external-PDF-file';
proc tabulate data=energia format=dollar12. ;
   class region provincia estado Tipos ;
   var Gastos;
    table Region*{style={background=yellow}}*(Provincia all='Subtotal')
			all='Total por Regions'*{style={background=red}}*f=dollar12.,
		 Tipos='Clientes'*Gastos=' '*sum=' ' 
			all='Total clientes'*gastos=' '*sum=' ' / 
         style=[bordercolor=blue];
	format region fm_region. provincia fm_provincia. Tipos fm_tipo.;
	title 'Gastos de Energ�a';
   title2 '(en Pesos)';
run;

ods pdf close;

















