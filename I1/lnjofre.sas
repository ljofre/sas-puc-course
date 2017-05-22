* pregunta 1: carpeta creada en myfolders.

* pregunta 2;
libname i1 '/folders/myfolders/I1';

data i1.persona;
	input id nombre $ sexo $ salario;
	cards;
2 Silvia Mujer 1.5
5 Anna Mujer 1.9
9 Magda Mujer 1.3
4 Pere Hombre 1.7
1 Joan Hombre 1.8
6 David Hombre 3.0
10 Carles Hombre 2.1
7 Cristina Mujer 2.2
3 Josep Hombre 2.5
8 Marta Mujer 1.0
;
run;

* pregunta 3;

data work.label;
	set i1.persona;

	if salario < 1.5 then
		label=1;
	else if 1.5 <=salario and salario <=2.5 then
		label=2;
	else if 2.5 <=salario and salario < 3.5 then
		label=3;
	else
		label=4;
run;

* pregunta 4;

data i1.persona2;
	input id nombre $ sexo $ salario;
	cards;
12 Ester Mujer 1.7
11 Oriol Hombre 2.3
13 Rosa Mujer 3.5
;
run;

Quit;
*unimos las tablas hacia abajo;

data i1.persona3;
	set i1.persona i1.persona2;

proc print ;
run;

Quit;
* pregunta 5: añadir variables con merge;

data i1.new_features;
	input id edad   nivest $ transp $ tiempo;
	cards;
  13 40 Est_sup Bus 35
  9 21 FPII Moto 7
  3 35 FPII Coche 55
  4 30 Est_sup Coche 45
  12 32 FPII Metro 35
  6 37 Gr_medio Bus 35
  7 35 Est_sup Bus 15
  10 28 Gr_medio Metro 25
  8 23 Gr_medio Moto 10
  1 27 Est_sup Bus 15
  2 20 FPII Metro 20
  11 29 Gr_medio Coche 50
  5 25 Gr_medio Moto 30
  ;
run;
quit;

* merge requiere ordenar los datos antes de pegarlos por id;
proc sort data=i1.persona3; by id; run;
proc sort data=i1.new_features; by id; run;


data i1.merge_dataframe;
Merge i1.persona3 i1.new_features;
by id;
Run;							    
Quit;

* problema 6;

proc means data=i1.merge_dataframe maxdec=3;
   var salario;
   class nivest sexo;
   types () nivest*sexo;
   output mean=promedio;
run;

proc tabulate data=i1.merge_dataframe format=dollar12.;
   class nivest sexo;
   var salario;
   table nivest*mean, sexo;
run; * este lo resuelve;

proc tabulate data=i1.merge_dataframe format=dollar12.;
   class nivest sexo;
   var salario;
   table nivest, sexo;
run;

*problema 7;

proc means data=i1.merge_dataframe maxdec=3;
   var tiempo;
   class transp sexo;
   types () transp*sexo;
   output mean=promedio;
run;

proc tabulate data=i1.merge_dataframe format=dollar12.;
   class transp sexo;
   var tiempo;
   table transp*mean, sexo;
run; * este es el que lo hace;

proc tabulate data=i1.merge_dataframe format=dollar12.;
   class transp sexo;
   var tiempo;
   table transp, sexo;
run

* problema 8;

proc univariate data=i1.merge_dataframe noprint;
   class sexo;
   histogram salario / NCOLS=1 nrows = 3;
   inset mean std="Std Dev" / pos = ne format = 6.3;
run;

proc univariate data=i1.merge_dataframe noprint;
   class sexo;
   histogram edad / NCOLS=1 nrows = 3;
   inset mean std="Std Dev" / pos = ne format = 6.3;
run;

* problema 9;









