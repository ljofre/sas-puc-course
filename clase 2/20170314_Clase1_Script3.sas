/******************************************************************************************************************************/
/**********											CLASE 1: 10/03/15												***********/
/******************************************************************************************************************************/


/*Ejemplo 1: Creación de BBDD*/	

Data Ejemplo1_1;                      
Input v1 v2 v3 v4; /*v1-v4 Son los nombres de las variables que se van a crear.*/
Cards; 
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
Set Ejemplo1_1(keep=v1 v2); /*Guardar sólo las variables v1 y v2*/
v5=v1+v2; 				  /*Crea una variable a partir de v1 y v2*/
Run;
proc print;run;
Quit;

Data Ejemplo1_2;                      
Set Ejemplo1_1; /*Guardar sólo las variables v1 y v2*/
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

