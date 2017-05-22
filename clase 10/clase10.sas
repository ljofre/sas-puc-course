
*Ejemplo 1-alternativa 1;
%macro gen1(n,Start,End);
data generate;
do Subj = 1 to &n;
x = int((&End - &Start + 1)*ranuni(0) + &Start);
output;
end;
run;
proc print data=generate noobs;
title "Generar datos aleatorios con &n observaciones";
title2 "Los valores son enteros entre &Start y &End";
run;
%mend gen1;
%gen1(n=13, Start=3, End=30)
%gen1(20,3,30)



%macro gen2(n=,Start=3,End=30);
data generate;
do Subj = 1 to &n;
x = int((&End - &Start + 1)*ranuni(0) + &Start);
output;
end;
run;
proc print data=generate noobs;
title "Generar datos aleatorios con &n observaciones";
title2 "Los valores son enteros entre &Start y &End";
run;
%mend gen;
%gen2(n=21)

*EJEMPLO 2;
libname clase10 "E:\20170504_Clase_10";

%macro count(opts=,start=01jan04,stop=31dec04);
proc freq data=clase10.orders;
where order_date between
"&start"d and "&stop"d;
table order_type / &opts;
title1 "Orders from &start to &stop";
run;
%mend count;
%count()
%count(opts=nocum)
%count(stop=01jul04,opts=nocum nopercent)


%INCLUDE "E:\20170504_Clase_10\Macro_ej.sas";
%count()
%count(opts=nocum)
%count(stop=01jul04,opts=nocum nopercent)
