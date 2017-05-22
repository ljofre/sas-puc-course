/******************************************************************************************************************************/
/**********											CLASE 4: 30/03/17									    ***********/
/******************************************************************************************************************************/

/* PROCEDIMIENTO UNIVARIATE;
		Se usa para obtener una variedad de estadísticos para resumir la distribución de los datos, por ejemplo,
			- Momentos de la muestra.
			- Medidas básicas de locación y variabilidad.
			- Intervalos de confianza para la media, desviación estándar y varianza.
			- Test de normalidad.
			- Cuantiles, intervalos de confianza.
			- Observaciones extremas, valores extremos.
			- Valores missing.
*/

Title 'Ejemplo 1: Presión';
data Presion;
   input PacienteID $ Sistolica Diastolica @@;
   datalines;
CK 120 50  SS 96  60 FR 100 70
CP 120 75  BL 140 90 ES 120 70
CP 165 110 JI 110 40 MC 119 66
FC 125 76  RW 133 60 KD 108 54
DS 110 50  JW 130 80 BH 120 65
JW 134 80  SB 118 76 NS 122 78
GS 122 70  AB 122 78 EC 112 62
HH 122 82
;
proc univariate data=Presion; 
run;

proc univariate data=Presion; 
id pacienteID; *Identifica cual de los pacientes son valores extremo;
run;

title 'ejemplo 2';
Data tableros;
   input espesor @@;
   label espesor = 'Espesor del enchapado (mils)';
   datalines;
3.468 3.428 3.509 3.516 3.461 3.492 3.478 3.556 3.482 3.512
3.490 3.467 3.498 3.519 3.504 3.469 3.497 3.495 3.518 3.523
3.458 3.478 3.443 3.500 3.449 3.525 3.461 3.489 3.514 3.470
3.561 3.506 3.444 3.479 3.524 3.531 3.501 3.495 3.443 3.458
3.481 3.497 3.461 3.513 3.528 3.496 3.533 3.450 3.516 3.476
3.512 3.550 3.441 3.541 3.569 3.531 3.468 3.564 3.522 3.520
3.505 3.523 3.475 3.470 3.457 3.536 3.528 3.477 3.536 3.491
3.510 3.461 3.431 3.502 3.491 3.506 3.439 3.513 3.496 3.539
3.469 3.481 3.515 3.535 3.460 3.575 3.488 3.515 3.484 3.482
3.517 3.483 3.467 3.467 3.502 3.471 3.516 3.474 3.500 3.466
;
proc univariate data=tableros noprint;
   histogram espesor;
run;

proc univariate data=tableros;
   histogram espesor / normal(percents=20 40 60 80 midpercents)
                     name='MyPlot';
   inset n  mean  / pos = NE format = 5.2;

run;

/* MIDPERCENTS: Imprime una tabla con los puntos medios de los intervalos del histograma.*/
/* PERCENTS: Enumera los porcentajes para los cuales se tabulan los cuantiles calculados a partir de datos 
			y los estimados a partir de curvas*/
/* Position = posición
	POS = posición
	Determina la posición de la inserción. 
	La posición al margen(NW-por defecto)*/
	
/*Pueden ver más opciones en: 
http://support.sas.com/documentation/cdl/en/procstat/66703/HTML/default/viewer.htm#procstat_univariate_syntax09.htm*/


title 'ejercicio 3';
data Normal1;
do i=1 to 100;
X= rannor(1)*10+100;
Y=1;
output;
end;
do i=1 to 100;
X= rannor(1)*5+150;
Y=2;
output;
end;
do i=1 to 100;
X= rannor(1)*8+200;
Y=3;
output;
end;
run;

proc univariate data=NORMAL1 noprint;
   class Y;
   histogram X / NCOLS=1 nrows = 3;
   inset mean std="Std Dev" / pos = ne format = 6.3;
run;
proc univariate data=NORMAL1 noprint;
   class Y;
   histogram X /  normal(percents=20 40 60 80 midpercents) NCOLS=1 nrows = 3;
   inset mean std="Std Dev" / pos = ne format = 6.3;
run;

proc univariate data=NORMAL1 noprint;
   class Y;
   histogram X /  normal(percents=20 40 60 80 midpercents) 
    Gamma
	NCOLS=1 nrows = 3;
   inset mean std="Std Dev" / pos = ne format = 6.3;
run;
proc univariate data=NORMAL1 noprint;
   histogram X / kernel(c = 0.20 );
run;


proc univariate data=NORMAL1 noprint;
  qqplot X ;
run;
proc univariate data=NORMAL1 noprint;
   probplot X / normal(mu=150 sigma=10);
run;

proc univariate data=NORMAL1 noprint;
   cdfplot X / normal;
   inset normal(mu sigma);
run;
