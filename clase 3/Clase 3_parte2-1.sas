/******************************************************************************************************************************/
/**********											CLASE 3(parte 2): 28/03/17									    ***********/
/******************************************************************************************************************************/





data cake;
   input LastName $ 1-12 Age 13-14 PresentScore 16-17 
         TasteScore 19-20 Flavor $ 23-32 Layers 34 ;
   datalines;
Orlando     27 93 80  Vanilla    1
Ramey       32 84 72  Rum        2
Goldston    46 68 75  Vanilla    1
Roe         38 79 73  Vanilla    2
Larsen      23 77 84  Chocolate  .
Davis       51 86 91  Spice      3
Strickland  19 82 79  Chocolate  1
Nguyen      57 77 84  Vanilla    .
Hildenbrand 33 81 83  Chocolate  1
Byron       62 72 87  Vanilla    2
Sanders     26 56 79  Chocolate  1
Jaeger      43 66 74             1
Davis       28 69 75  Chocolate  2
Conrad      69 85 94  Vanilla    1
Walters     55 67 72  Chocolate  2
Rossburger  28 78 81  Spice      2
Matthew     42 81 92  Chocolate  2
Becker      36 62 83  Spice      2
Anderson    27 87 85  Chocolate  1
Merritt     62 73 84  Chocolate  1
;
run;

proc means data=cake n mean max min range std fw=8;
run;


Title 'Ejemplo 2';
Data grade;
   input Name $ 1-8 Gender $ 11 Status $13 Year $ 15-16 
         Section $ 18 Score 20-21 FinalGrade 23-24;
   datalines;
Abbott    F 2 97 A 90 87
Branford  M 1 98 A 92 97
Crandell  M 2 98 B 81 71
Dennison  M 1 97 A 85 72
Edgar     F 1 98 B 89 80
Faust     M 1 97 B 78 73
Greeley   F 2 97 A 82 91
Hart      F 1 98 B 84 80
Isley     M 2 97 A 88 86
Jasper    M 1 97 B 91 93
;
proc means data=grade maxdec=3;
   var Score;
   class Status Year;
   types () status*year;
run;

title 'Ejemplo 3';
proc sort data=Grade out=GradeBySection;
   by section;
run;
proc means data=GradeBySection min max median;
   by Section;
   var Score;
   class Status Year;
run;

proc means data=Grade noprint;
   class Status Year;
   var FinalGrade;
   output out=sumstat mean=AverageGrade
          idgroup (max(score) obs out (name)=BestScore) / ways levels;
run;
proc print data=sumstat; run;
