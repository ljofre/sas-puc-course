/*Ejemplo 1*/
Proc iml;
Matriz1=J(2,3,0);
Matriz2=J(2,3,"C");
print Matriz1; 
print Matriz3;
quit;


/*Ejemplo 2

tal cual se crea la data son las columnas que aparecen
*/
Data ejercicio2;
do i=1 to 1000;
x=rannor(3)*2;
y=2+3*x;
output;
end;
drop i;
run;

Proc iml;
USE ejercicio2;
READ ALL INTO BD;
print BD;
quit;


/*Ejemplo 3*/
Proc iml;
Matriz2=J(2,3,"C");
print Matriz2;

CREATE Ejemplo3 FROM Matriz2 ;
APPEND FROM Matriz2;
quit;

/*Ejemplo 4 y 5*/
Proc iml;
Matriz2={1 2 3,4 5 6};
print matriz2;

Valor=Matriz2[1,3];
print Valor;
quit;

/*Ejemplo práctico 1*/
Data notas;
infile "/folders/myfolders/clase 8/Notas.txt"
delimiter=';' firstobs=2;
input Nombre $ P1 P2 P3 P4;
run;

proc iml;
USE NOTAS;
READ ALL INTO nombre var{Nombre};
READ ALL INTO notas var{P1 P2 P3 P4};
print nombre;
print notas;

n=nrow(notas);
print n;
matriz=j(n,4,0);

do i=1 to n;
	do j=1 to 4;
		aux1=notas[i,j]/10;
		if aux1<1 then matriz[i,j]=notas[i,j]*10;
		else matriz[i,j]=notas[i,j];
	end;
end;

print matriz;


PROMEDIO=MATRIZ[,:]; *vector con el largo de los promedios;
CONTADOR=T(1:NROW(MATRIZ)); * iterador numero de filas;
BD_P=CONTADOR||PROMEDIO;
PRINT BD_P;

Ind_ap=loc(BD_P[,2]>=40);
Aprob=BD_P[ind_ap,];
Nom1=NOM[ind_ap,];
print Nom1 Aprob;

Ind_rep=loc(BD_P[,2]<40);
Reprob=BD_P[ind_rep,];
Nom2=NOM[ind_rep,];
print Nom2 Reprob;

CREATE lista_aprob FROM nom1 ;
APPEND FROM nom1;
CREATE lista_reprob FROM nom2 ;
APPEND FROM nom2;
quit;


/*Ejemplo Pr�ctico 2:*/
Proc iml;
USE ejercicio2;
READ ALL INTO BD;
Y=BD[,2];
N=nrow(BD);
Unos=J(N,1,1);
X=Unos||BD[,1];
beta=inv(t(X)*X)*t(x)*Y;
print beta;
quit;

*****************************************************************;
Proc Iml;
a = 1;
b = 2;
start fun1(x,y);
z = x+y;
x = x+1;
y = y+1;
print z x y;
finish fun1;
run fun1(a,b);
quit;




proc iml;
start funcion1(a,b);
	aux1 = a**b;
	aux2 = aux1 + a;
return (aux2);
finish funcion1;

start funcion2(c,d);
	aux3 = d**c;
	aux4 = aux3*c;
return(aux4);
finish funcion2;
resultado1 = funcion1(2,3);
resultado2 = funcion2(2,3);
resultado3 = funcion2(2,resultado2);

print 'Los resultados de las funciones son:' 
resultado1 resultado2 resultado3;

quit;

proc iml;
a={1 2, 3 4, 5 6};
print a; 
a={[2] 1, [2] 2};
print a;
quit;

Proc iml;
USE ejercicio2;
READ ALL INTO BD;
call gstart;
Y=BD[,2];
X=BD[,1];
call gpoint(X,Y);
call gshow;
quit;

*Gpoint dibuja seg{un la ubicacion especifica. X son las coordenadas horizontales e Y son las coordenadas verticales.;
*Gshow muestra la grafica en una ventana; 
