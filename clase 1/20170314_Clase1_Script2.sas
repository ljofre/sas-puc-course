Data NUMERO;
infile datalines dsd;
input x1 x2 x3;
datalines;
1,,3
4,5,
7,8,9
;
run;
data NUMERO2;
infile datalines dsd delimiter='ab';
input X1 X2 X3;
datalines;
a2b3
4a5b6
7a8b
;
Run;

data NUMERO3;
infile datalines missover;
input X1-X5;
datalines;
1 2 3
4 5 6 7 8
9 10 11 12 13
14 15 16 17
;
run;

