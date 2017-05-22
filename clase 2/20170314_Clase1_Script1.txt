
Data Alumnos;
Input Id Nombre $ Sexo $;
cards;
1234 Josefa F
;
run;
proc print data=Alumnos;
run;
Quit;


/*Exportar DATA*/

PROC EXPORT DATA= WORK.ALUMNOS 
            OUTFILE= "C:\20170307 - Clase 1\code\prod\Alumnos.txt" 
            DBMS=TAB REPLACE;
     PUTNAMES=YES;
RUN;


/*Importar DATA*/
PROC IMPORT OUT= WORK.ALUMNOS2 
            DATAFILE= "C:\20170307 - Clase 1\code\prod\Alumnos.txt"
            DBMS=TAB REPLACE;
RUN;


DATA ALUMNOS3;
infile "C:\20170307 - Clase 1\code\prod\Alumnos.txt" 
delimiter=';' firstobs=2;
Input Id    Nombre $ Sexo $;
Run;

Proc print data=Alumnos3;
run;

proc contents data=Alumnos3;
run;


/*LIBNAME*/

Libname EPG3308 "C:\20170307 - Clase 1\code\prod";
libname EPG3308 "C:\20170307 - Clase 1\code\";

DATA EPG3308.ALUMNOS4;
infile "C:\20170307 - Clase 1\code\prod\Alumnos.txt" 
delimiter=';' firstobs=2;
Input Id    Nombre $ Sexo $;
Run;


