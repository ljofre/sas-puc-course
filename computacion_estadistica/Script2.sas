

Data EPG3308.alumnos; 

Input Id Nombre $ Sexo $; /* definir la estructura de datos */
cards; /* comienza la carga de datos*/

1234 Josefa F
2133 Enrique M
4444 Josefina M
;

run;

proc print data=alumnos;
run;
quit;

proc export data=work.alumnos
			outfile="~/computacion_estadistica/ALUMNOS.txt"
			DBMS=TAB REPLACE; /*EXTENSION Y REMPLAZAR*/
			putnames=YES;		
run; /*exportar datos*/


/* importar datos */
proc import out=work.alumnos2
	 datafile="~/computacion_estadistica/ALUMNOS.txt"
	 dbms=tab replace;
run;


/*leer data*/

data alumnos3;
infile "~/computacion_estadistica/ALUMNOS.txt"
delimiter="\t" firstobs=2;
INPUT id Nombre $ Sexo $;
run;

/*crear una libreria

Ahi se van a guardar las bases de datos que creemos para nuestro proyecto
*/

Libname EPG3308 "~/computacion_estadistica/code/prod";








