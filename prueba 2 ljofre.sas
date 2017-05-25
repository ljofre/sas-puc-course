* prueba dos definitiva;

%macro gen2;
	data nname;
		do i=1 to 10;
		x=i;
			output;
		end;
	run;
%mend gen2;

%gen;

proc print data=work.nombre