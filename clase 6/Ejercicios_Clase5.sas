Libname Clase5 "C:\Dropbox (MIDE)\03_courses&seminars\01 my courses\201701 - Computación estadística\SAS\20170404_Clase_5\";
*pregunta1;
DATA Clase5.Nacimientos;
set sashelp.Bweight;
label BLACK='COLOR DE PIEL' smoke='FUMADORA' weight='PESO'
	visit='Visitas al doctor' married='casada';
run;

*pregunta2;
proc summary data = Clase5.Nacimientos ;
 class black MomSmoke;
 var weight;
 output out=Clase5.peso n=peso_n mean=peso_mean std=peso_std;
run;
*pregunta3;
proc univariate data = Clase5.Nacimientos  ;
 class black MomSmoke;
 var weight;
run;

PROC TTEST DATA=Clase5.Nacimientos;
 class MomSmoke;
 var weight;
RUN; 
*pregunta4.1;
proc format;
   value fm_black 0='Blanco'
                  1='Negro';
   value fm_smoke 0='NO'
                  1='SI';
	value fm_married 0='NO'
                  1='SI';
run;
title 'Peso de recien nacidos';
title2 'Fuma/No Fuma';
proc tabulate data=Clase5.nacimientos;
   class MomSmoke ;
   var weight;
    table weight*MomSmoke*mean*{style={background=yellow}};
format black fm_black. MomSmoke fm_smoke.;
run;

*pregunta4.2;
title2 'Color de Piel/Fuma';
proc tabulate data=Clase5.nacimientos;
   class MomSmoke black;
   classlev MomSmoke black / style=[foreground=black background=beige ];
   var weight;
    table black*MomSmoke, weight*mean ;  
format black fm_black. MomSmoke fm_smoke.;
run;

*pregunta4.3;
title2 'Visitas pre-natales';
proc tabulate data=Clase5.nacimientos;
   class visit ;
   var weight;
    table visit, weight*mean ;
format  married fm_married. black fm_black. MomSmoke fm_smoke.;
run;

*pregunta4.4;
title2 'Visitas pre-natales/Casada';
proc tabulate data=Clase5.nacimientos;
   class married visit ;
   var weight;
    table married*visit, weight*mean ;
format  married fm_married. black fm_black. MomSmoke fm_smoke.;
run;
