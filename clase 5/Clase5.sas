/******************************************************************************************************************************/
/**********											CLASE 5: 04/04/17									    ***********/
/******************************************************************************************************************************/

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
ods pdf file='C:\Dropbox (MIDE)\03_courses&seminars\01 my courses\201701 - Computaci�n estad�stica\CLASES\20170404 - Clase 5\LATEX\pdf.pdf';
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
