proc sort data=sashelp.cars(keep=Make Model Type Origin MSRP Cylinders Horsepower)
	OUT=CARS;
	by origin type;
run;

Proc print data=cars; run;
proc report data=cars nowd OUT=QUARTILES; 
  		column origin type msrp msrp=msrp2 msrp=msrp3 msrp=msrp4 msrp=msrp5;

	define origin / group; 
	define type / group; 
** Define Statistics; 
	define msrp / p25; 
	define msrp2 / median; 
	define msrp3 / p75; 
	define msrp4 / min; 
	define msrp5 / max;
run;

data cars2;  
merge cars(rename=(origin=origen type=tipo)) quartiles(rename=(origin=origen type=tipo msrp=per25 msrp2=per50 msrp3=per75
                             msrp4=pmin msrp5=pmax));
     by origen tipo;
label origen="Origen" Tipo="Tipo";
run;

Proc Print data=cars2; run;

** Ejemplo 1; 
TITLE "Continente #byvar1: #byval(origen)"; 
TITLE2 "Vehículo #byvar2: #byval(tipo)";
   ** Especificaciones del ODS;
ods pdf file = "E:\20170604\Cars_ej1.pdf";
proc report data=cars2; 
by origen tipo; 
  		column origen tipo per25 per50 per75 pmin pmax;

	define origen / group; 
	define tipo / group; 
	define per25/"P25";
run;
ods _all_ close;



** Ejemplo 2; 
TITLE "Continente #byvar1: #byval(origen)"; 
TITLE2 "Vehículo #byvar2: #byval(tipo)";
   ** Especificaciones del ODS;
ods pdf file = "E:\20170604\Cars_ej2.pdf";
proc report data=cars2 nowd spanrows split="|" missing style(report)=[asis=on]; 
/*nowd spanrows  : combina las celdas por grupo*/
by origen tipo; 
column tipo=tipo2 make msrp=MSRPORD model cylinders horsepower msrp per25 per50 per75 pmin pmax msrpptle; 
** DEFINE Specifications; 
define tipo2 / noprint;
define make / order style(column)=[font_weight=bold]; 
define MSRPORD / order noprint;
define model / order;
define cylinders / order style(column)=[just=c]; 
define horsepower / order style(column)=[just=c];
define per25 / noprint;
define per50 / noprint;
define per75 / noprint;
define pmin  / noprint;
define pmax  / noprint;
define msrpptle / computed "MSRP|Price Point"
                  style(column)=[just=l indent=.75 in cellwidth=1.8 in];
Run;
ods _all_ close;

** Ejemplo 3; 
TITLE "Continente #byvar1: #byval(origen)"; 
TITLE2 "Vehículo #byvar2: #byval(tipo)";
   ** Especificaciones del ODS;
ods pdf file = "E:\20170604\Cars_ej3.pdf";
proc report data=cars2 nowd spanrows split="|" missing style(report)=[asis=on]; 
by origen tipo; 
column tipo=tipo2 make msrp=MSRPORD model cylinders horsepower msrp per25 per50 per75 pmin pmax msrpptle; 
** DEFINE Specifications; 
define tipo2 / noprint;
define make / order style(column)=[font_weight=bold]; 
define MSRPORD / order noprint;
define model / order;
define cylinders / order style(column)=[just=c]; 
define horsepower / order style(column)=[just=c];
define per25 / noprint;
define per50 / noprint;
define per75 / noprint;
define pmin  / noprint;
define pmax  / noprint;
define msrpptle / computed "MSRP|Price Point"
                  style(column)=[just=l indent=.75 in cellwidth=1.8 in];
** Crear columnas de símbolos de precios y resaltar las filas mínimas y máximas;
compute msrpptle / char length=6;
           ** Determinar Percentil y Asignar $ como símbolo;
           if msrp.sum <= per25.sum then msrpptle="$";
    		else if per25.sum < msrp.sum <=per50.sum then msrpptle="$$";
   			 else if per50.sum < msrp.sum<= per75.sum then msrpptle="$$$";
    		else if msrp.sum > per75.sum then msrpptle="$$$$";
    ** Color a la celda Min y Max;
   				 if pmin.sum=msrp.sum then
    		  call define('msrp.sum','style','style={background=blue
                  foreground=white font_weight=bold}');
    if pmax.sum=msrp.sum then
      call define('msrp.sum','style','style={background=red
                  foreground=white font_weight=bold}');
endcomp;
run;
ods _all_ close;


TITLE "Continente #byvar1: #byval(origen)"; 
TITLE2 "Vehículo #byvar2: #byval(tipo)";
   ** Especificaciones del ODS;
ods pdf file = "E:\20170604\Cars_ej4.pdf"; 
options nodate orientation=portrait; 

ods escapechar="^";
/*Especifica el carácter especial que identifica el símbolo de formato en línea. El carácter de escapechar debe ser uno de los siguientes caracteres @, ^,  \. */
proc report data=cars2 nowd spanrows split="|" missing style(report)=[asis=on]; 
by origen tipo; 
column tipo=tipo2 make msrp=MSRPORD model cylinders horsepower msrp per25 per50 per75 pmin pmax msrpptle; 
** DEFINE Specifications; 
define tipo2 / noprint;
define make / order style(column)=[font_weight=bold]; 
define MSRPORD / order noprint;
define model / order;
define cylinders / order style(column)=[just=c]; 
define horsepower / order style(column)=[just=c];
define per25 / noprint;
define per50 / noprint;
define per75 / noprint;
define pmin  / noprint;
define pmax  / noprint;
define msrpptle / computed "MSRP|Price Point"
                  style(column)=[just=l indent=.75 in cellwidth=1.8 in];
** Crear columnas de símbolos de precios y resaltar las filas mínimas y máximas;
compute msrpptle / char length=6;
           ** Determinar Percentil y Asignar $ como símbolo;
           if msrp.sum <= per25.sum then msrpptle="$";
    		else if per25.sum < msrp.sum <=per50.sum then msrpptle="$$";
   			 else if per50.sum < msrp.sum<= per75.sum then msrpptle="$$$";
    		else if msrp.sum > per75.sum then msrpptle="$$$$";
    ** Color a la celda Min y Max;
   				 if pmin.sum=msrp.sum then
    		  call define('msrp.sum','style','style={background=blue
                  foreground=white font_weight=bold}');
    if pmax.sum=msrp.sum then
      call define('msrp.sum','style','style={background=red
                  foreground=white font_weight=bold}');
endcomp;
compute before _PAGE_ / left; 
length text0 - text6 $100;
if _BREAK_=' ' then
  do;
    text0="^{style [font_size=12 pt textdecoration=underline]"
           ||strip(type2)||" MSRP Price Point}";
    text1="MSRP <=Percentil 25 ("
          ||strip(put(per25.sum,dollar10.))||") ($)";
    text2="MSRP <=Percentil 50("
           ||strip(put(per50.sum,dollar10.))||") ($$)";
    text3="MSRP <=Percentil 75("
           ||strip(put(per75.sum,dollar10.))||") ($$$)";
    text4="MSRP  > Percentil 75("
           ||strip(put(per75.sum,dollar10.))||") ($$$$)";


text5=
"^{style [font_face=wingdings font_size=12 pt foreground=blue]n}"
          ||"El más bajo  MSRP: " || strip(put(pmin.sum,dollar10.));
text6=
"^{style [font_face=wingdings font_size=12 pt foreground=red]n}"
          ||"El más alto MSRP: " || strip(put(pmax.sum,dollar10.));
  end;
** Put New Variables in Line Statements;
  line text0 $100.;
  line '';
  line text1 $100.;
  line text2 $100.;
  line text3 $100.;
  line text4 $100.;
  line '';
  line text5 $100.;
  line text6 $100.;
endcomp;
compute before make;
  line '';
endcomp;
run;
ods _all_ close;



