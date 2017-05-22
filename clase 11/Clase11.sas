*EJEMPLO1;
libname clase11 "E:\20170509_Clase_11";
options mlogic;

%let fecha = 01NOV2007;
%macro daily;
proc print data=clase11.order_fact;
where order_date="&fecha"d;
var product_id total_retail_price;
title "Daily sales: &fecha";
run;
%mend daily;
%macro weekly;
proc means data=clase11.order_fact n sum mean;
where order_date between "&fecha"d - 6 and "&fecha"d;
var quantity total_retail_price;
title "Weekly sales: &sysdate9";
run;
%mend weekly;
%macro reports;
%daily
%if &sysday=Wednesday %then %weekly;
%mend reports;
%reports;

%macro reports(day);
%daily
%if &sysday=&day %then %weekly;
%mend reports;
%reports(Wednesday);
%reports(Thursday);


%macro reports(day,macro1,macro2);
%&macro1
%if &sysday=&day %then %&macro2;
%mend reports;
%reports(Wednesday,daily,weekly);


