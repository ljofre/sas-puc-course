/******************************************************************************************************************************/
/**********											CLASE 3(parte 1): 28/03/17									    ***********/
/******************************************************************************************************************************/

/* Sentencia DO;
		Cuando se desea de realizar sentencia repetidamente se usa DO.
			DO value=start to stop;
				Sentencias;
			END;
		La instrucción END marca el final de las iteraciones.
*/


/*EJEMPLO 1: Crear una variable que indique el número de vocales que tiene el
nombre.
*/

DATA EPG3308;
infile "C:\20170328 - Clase 3\codes\EPG3308.txt" 
delimiter=';' firstobs=2;
Input N APELLIDO$ : 39.  NOMBRE $ : 20.  ;
Run;

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
RUN;

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


DATA NOMBRE_ALIGN;
SET NOMBRE;
NOM_ALIGN= RIGHT(NOMBRE);
NOMBRE2=TRANWRD(NOMBRE,"A","-");
NOMBRE3=LOWCASE(NOMBRE);
NOMBRE4=FIND(NOMBRE,"A");
RUN;


/* DO WHILE Y DO UNTIL
		DO WHILE: se puede utilizar para realizar las iteraciones mientras ocurre una condición determinada. 
				  La forma de usarlo es la siguiente,
		
					DO WHILE (expresión);
						Sentencias;
					END; 
		
		DO UNTIL: se puede utilizar para realizar las iteraciones mientras NO ocurra una condición determinada.
				  La forma de usarlo es, 

					DO UNTIL (expresión);
						Sentencias;
					END;
	*/
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
run;

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



