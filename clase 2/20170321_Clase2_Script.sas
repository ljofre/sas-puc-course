/******************************************************************************************************************************/
/**********											CLASE 2: 21/03/17												***********/
/******************************************************************************************************************************/

/* Comandos comunes dentro de una DATA;
		- DROP: Elimina variables
		- KEEP: Guarda en la DATA s�lo las variables que se desean mantener en ellas.
		- RENAME: (Nombre-Antiguo = Nombre-Nuevo) Renombra las variables
		- FIRSTOBS: (FIRSTOBS=n) Indica desde que l�nea se comienza a leer.
		- OBS: (OBS=n) Indica en que l�nea termina la lectura de datos.
		- WHERE: (WHERE=Condici�n) Filtra por filas y mantiene s�lo las que cumple la condici�n.
*/


/*EJEMPLO 1: Descargar BBDD en http://www.deis.cl/estadisticas-de-natalidad-2011/
	Nacidos vivos inscritos seg�n peso al nacer, por regi�n y comuna. Chile, 2011
	Nacidos vivos inscritos seg�n edad de la madre, por regi�n y comuna. Chile, 2011
*/
DATA PESO;
infile "C:\20170321 - Clase 2\codes\Peso2011.txt" 
delimiter=';' firstobs=2;
Input Region $ : 39.  Comuna $ : 20.  
Total MENOS1500 
ENTRE_1500A2499 
ENTRE_2500A2999 
Mayor_igual_3000 
Ignorado;
Run;

DATA EDAD;
infile "C:\20170321 - Clase 2\codes\Edad2011.txt" 
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


/*CONCATENAR DOS DATAS:

Se usa la opci�n SET. La Base de datos tendr� tantas observaciones
como la suma de las observaciones de los archivos a concatena
*/
DATA PESO_REGION_3_y_M;
SET PESO_REGION_M PESO_REGION_3;
PROC PRINT;
RUN;

/* UNIR DOS ARCHIVOS:

Se usa la opci�n MERGE. La Base de se une por la variable tipo, la
cual debe ser com�n en ambos y ordena previamente. 
*/

PROC SORT DATA=PESO; BY Region Comuna;RUN;
PROC SORT DATA=EDAD; BY Region Comuna;RUN;

DATA UNION;
MERGE Edad Peso;
By Region Comuna;
PROC PRINT;
RUN;

PROC SORT DATA=PESO_REGION_M; BY Region Comuna;RUN;
data UNION2;
merge PESO_REGION_M(IN=k) Edad(IN=j);
by Region Comuna;
if k=j;
PROC PRINT;
RUN;


/* MODIFICACI�N Y CREACI�N DE VARIABLES:
		Para crear variable, s�lo se agrega una linea dentro del data, tal que Nueva Variable= Expresi�n
		Agunos operadores aritm�ticos son;
			- Potencia: **
			- Multiplicaci�n:*
			- Divisi�n: /
			- Suma: +
			- Resta: -
*/
DATA Ejemplo;
Set Union2;
Total_nac_ci=MENOS1500 + ENTRE_1500A2499 + ENTRE_2500A2999 + Mayor_igual_3000; 
Total_mad_ci = Menor_15 + Entre15_19 + Entre20_34 + Mas_Igual35 ;
RE1 = Menor_15/Total_mad_ci*100;
RE2 = Entre15_19/Total_mad_ci*100;
RE3 = Entre20_34/Total_mad_ci*100;
RE4 = Mas_Igual35/Total_mad_ci*100;
proc print;
run;



/* SENTENCIA DE CONTROL:
	- IF; (IF condici�n).
		- Igual a: EQ o =
		- Diferente a: NE
		- Menor que: LT o <=
		- Mayor que: GT o >=
		- Algunos operadores l�gicos: OR, AND, NOT
*/


/* EJEMPLO: A partir del archivo Ejemplo, que ya creamos, Crearemos una DATA que contenga s�lo a las comunas de la regi�n Metropolitana 
			que al menos el 50% de las madres tenga entre 20-34 a�os durante el nacimiento de sus hijos en el a�o 2011.
*/

DATA Ejemplo2;
SET Ejemplo (Where=(Region='Metropolitana de Santiago'));
if RE3 >= 50;
proc print;
run;

/*O tambi�n */
DATA Ejemplo2;
SET Ejemplo;
if RE3 >= 50 and Region='Metropolitana de Santiago';
proc print;
run;



/*EJERCICIO EN CLASES: 
	- Crear una data, donde est�n todas las comunas a lo largo de Chile, con las categor�as de peso del ni�o al nacer y de la edad de la madre. 
	- Guarde esta en una librer�a creada por usted.
	- Luego realice lo siguiente
			- Crear una nueva variable que indique la categor�a de peso al nacer m�s frecuente,
			- Crear una nueva variable que indique la categor�a de peso al nacer menos frecuente,
			- Repita los pasos anteriores con las categor�as de edad de la madre.
			- Realice una descripci�n de los nacimientos en Chile durante el 2011. (A�N NO TENEMOS LAS HERRAMIENTAS PARA RESOLVERLA)   
						- Que regi�n presenta m�s nacimiento de madres adolescentes en el a�o 2011 en Chile.
						- Qu� regi�n present� durante el 2011 nacimientos con bebes de bajo peso (menos 1500gr) con mayor frecuencia a lo largo de Chile. (considere el total de nacimientos en la regi�n)
