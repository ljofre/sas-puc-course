***LENGUAJE MACRO*******;
*USO DE %LET;

%let lib=Clase9;
%let Ruta=E:\20170427_Clase_9;
libname &lib "&Ruta";

%let date1=27042017;
%let date2=04052017;


%let Archivo_pdf=\Out_print.pdf;

ods pdf file = "&Ruta&Archivo_pdf";
DATA &lib..Clases;
input Clase Fecha: yymmdd10. ;
cards;
1 20170427
2 20170502
3 20170504
4 20170509
5 20170511
6 20170516
7 20170518
8 20170523
9 20170525
10 20170530
11 20170601
12 20170606
13 20170608
14 20170613
;
RUN;
%let dmin=%sysfunc(inputn(&date1,ddmmyy10.));
%let dmax=%sysfunc(inputn(&date2,ddmmyy10.));
%let fmin=%sysfunc(inputn(&date1,ddmmyy10.),ddmmyy10);
%let fmax=%sysfunc(inputn(&date2,ddmmyy10.),ddmmyy10);
proc print data=&lib..Clases;
where Fecha  between &dmin and &dmax;
var Clase Fecha;
title "Clases de Macros serán entre los días &fmin y &fmax" ;
format Fecha ddmmyy10.;
run;

ods pdf close;


*Nota sobre ods pdf: Existe algunas opciones dpara modificar el pdf, por ejemplo
style: Define el estilo del pdf.

Al mismo código anterior veamos algunas de las opciones.;

%let Archivo_pdf=\Out_print2.pdf;
ods pdf file = "&Ruta&Archivo_pdf"
style = BarrettsBlue
pdftoc=2;
ods pdf text = "Ejemplo de como se pueden hacer comentarios en el pdf";
proc print data=&lib..Clases;
where Fecha  between &dmin and &dmax;
var Clase Fecha;
title "Clases de Macros serán entre los días &fmin y &fmax" ;
format Fecha ddmmyy10.;
run;
ods pdf text = "Usted puede usarlo en cualquier parte del programa";
ods pdf close;


******************************************************************************
USO DE %SYMDEL;

%SYMDEL lib;
*He borrado lib, entonces la siguiente sintaxis debe dar error.;
proc print data=&lib..Clases;
where Fecha  between &dmin and &dmax;
var Clase Fecha;
title "Clases de Macros serán entre los días &fmin y &fmax" ;
format Fecha ddmmyy10.;
run;


******************************************************************************
* USO DE %PUT;

%put Clase9;

******************************************************************************
* Variables MACRO de valores FIJO;

%put &sysdate; 
%put &sysdate9;
%put &sysday;
%put &systime;
%put &sysscp;
%put &sysver;
%put &sysuserid;

*EJEMPLO DE USO;
%let inicio=&systime;
%let lib=Clase9;
DATA &lib..Clases;
input Clase Fecha: yymmdd10. ;
cards;
1 20170427
2 20170502
3 20170504
4 20170509
5 20170511
6 20170516
7 20170518
8 20170523
9 20170525
10 20170530
11 20170601
12 20170606
13 20170608
14 20170613
;
RUN;
%let dmin=%sysfunc(inputn(&date1,ddmmyy10.));
%let dmax=%sysfunc(inputn(&date2,ddmmyy10.));
%let fmin=%sysfunc(inputn(&date1,ddmmyy10.),ddmmyy10);
%let fmax=%sysfunc(inputn(&date2,ddmmyy10.),ddmmyy10);
proc print data=&lib..Clases;
where Fecha  between &dmin and &dmax;
var Clase Fecha;
title "Clases de Macros serán entre los días &fmin y &fmax" ;
format Fecha ddmmyy10.;
run;
%let Final=&systime;

%put &Inicio;
%put &Final;

%let inicio=%sysfunc(time(),timeampm.);
DATA &lib..Clases;
input Clase Fecha: yymmdd10. ;
cards;
1 20170427
2 20170502
3 20170504
4 20170509
5 20170511
6 20170516
7 20170518
8 20170523
9 20170525
10 20170530
11 20170601
12 20170606
13 20170608
14 20170613
;
RUN;
%let dmin=%sysfunc(inputn(&date1,ddmmyy10.));
%let dmax=%sysfunc(inputn(&date2,ddmmyy10.));
%let fmin=%sysfunc(inputn(&date1,ddmmyy10.),ddmmyy10);
%let fmax=%sysfunc(inputn(&date2,ddmmyy10.),ddmmyy10);
proc print data=&lib..Clases;
where Fecha  between &dmin and &dmax;
var Clase Fecha;
title "Clases de Macros serán entre los días &fmin y &fmax" ;
format Fecha ddmmyy10.;
run;
%let Final=%sysfunc(time(),timeampm.);

%put &Inicio;
%put &Final;


**************************************************************;
* EJEMPLO DE MACROS PARA OPERAR SIMBOLOS;

*CAMBIA LAS LETRAS A MAYUSCULAS;
%let var_1 = ejemplo_macro_text;
%let aux_1 = %upcase(&var_1);
%put &aux_1;
%put &var_1;

* Substrae desde la posición 9 5 letras;
%let aux_2 = %substr(&var_1,9,5);
%put &aux_2;

* Substrae y cambia a mayúscula;
%let aux_3 = %upcase(%substr(&aux_1,15,4));
%put &aux_3;

*Lee la palabra que está n veces a la izquierda o derecha del separador _; 
*por ejemplo %scan(ejemplo_macro_text,n,_) _ indica que ese es el separador de palabras
n será la posición de la palabra, en este ejemplo son 3 palabras, entonces
si n=1 obtengo ejemplo
si n=2 obtengo macro
si n=3 obtengo text;

%let aux_4 = %scan(&var_1,1,_); 
%put &aux_4;
%let aux_5 = %scan(&var_1,2,_);
%put &aux_5;
%let aux_6= %scan(&var_1,3,_);
%put &aux_6;
 
* Busca en una expresión (&var_1) la cadena de caracteres (text)
y devuelve la posición del primer carácter de la cadena, para la primera aparición.;
%let aux_7 = %index(&var_1,text);
%put &aux_7;

******************************************************************************
EJEMPLO DE FUNCIONES ARITMETICAS;

%let var_2 = 100;
*Esta función evalua.;
%let aux_8 = %eval(&var_2 + 50);
%put &aux_8; 

*calcula el minimo entre la variable var_2 y 50;
*tambien puede usar median, max,median...;
%let aux_9 = %sysfunc(min(&var_2,50));
%put &aux_9;

*Anexa ; 
*A los caracteres que están al lado;
%let aux_10 = %str(;)_ejemplo_%str(;);
%put &aux_10;

*Ejemplo de uso;
%let aux_11 = data ejemplo %str(;) 
do i=1 to 100%str(;)
sim = RAND('NORMAL',0,1) %str(;) 
output%str(;) 
end %str(;)
run %str(;) ;
%put &aux_11;

&aux_11.;

**********************************************************;
*EJEMPLO DE MACRO;
%macro time;
%put La hora es %sysfunc(time(),timeampm.).;
%mend time;

%time;
