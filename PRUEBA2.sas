**PREGUNTA 1;

* definimos primero la funcion para calcular numeros aleatorios enteros;
* de una distribucion uniforme;

%macro RandBetween(min, max, seed);
   (&min + floor((1 + &max - &min) * ranuni(&seed)));
%mend;

* empleando esta funcion, debemos usar una funcion de sas que nos diga la;
* cantidad de dias que tiene un mes especifico de un anio especifico;

%macro gen(name, id, dia, mes, year, n, seed);

	Data &name;
	
	    do i = 1 to &n;
	    
	        &id = i;

	        mes_aux = %RandBetween(1,12, &seed);
	        
	        year_aux = %RandBetween(1990, 1995, &seed);
	        
			*buscamos el numero de dias de un mes para poder muestrear sin omitir nunguno;
	        int_date = year_aux * 10000 + mes_aux * 100 + 1; *formato yyyymmdd;
	        
	        * fecha del ultimo dia del mes de la fecha que se quiere generar;
	        eom = intnx('month', input(put( int_date, 8.), YYMMDD8.) , 0, 'end');
	        
	        *uniforme entre 1 y maximo de dias en el mes;
	        &dia = %RandBetween(1,day(eom), &seed);
	        
	        *conservamos el orden solicitado de las variables sin generar una tabla temporal;
	        &mes = mes_aux;
	        &year = year_aux;
	        
	        output;
	        
	        drop i;
	        drop int_date;
	        drop eom;
	        drop mes_aux;
	        drop year_aux;
	        
	    end;
	    
	run;
	
%mend;

%gen(name=fechas, id=id, dia=dia, mes=mes, year=anio, n=100, seed=8723);

**PREGUNTA 2;

%macro transform(data_in, data_out, id, dia, mes, year, date, dif_year, fecha_obj=20170523);
	data &data_out;
		set &data_in;
		
		int_date = &year * 10000 + &mes * 100 + &dia;
		
		* formato intermedio donde haga match con el entero construido;
		date_aux = input(put(int_date, 8.), YYMMDD10.);
		
		* convertir al formato requerido;
		&date = input(date_aux, DDMMYYD10.);
		format date DDMMYYD10.;
		
		* convertir la fecha de calculo en el formato requerido;
		current_date_aux = input(put(&fecha_obj, 8.), YYMMDD10.);
		current_date = input(current_date_aux, DDMMYYD10.);
		
		&dif_year = yrdif(date, current_date,'AGE');
		
		drop current_date_aux;
		drop current_date;
		drop int_date;
		drop date_aux;
	run;
%mend;

%transform(data_in=fechas, data_out=fechas_transform, id=id, dia=dia, mes=mes, year=anio, dif_year=dif_year, date=date);

**PREGUNTA 3;
*esta pregunta es tan simple como la preguna 2 pero con una validacion adicional.;

%macro isValid(fecha_obj);
	*no implementada, retorna cero si no es un entero valido para fecha;
%mend;

%let message = "escrita fuera de rango";
%macro variar(data_in, data_out, id, dia, mes, year, date, dif_year, fecha_obj);

	%if %isValid(&fecha_obj) ne 0 %then %do; 
		%transform(data_in=&data_in, data_out=&data_out, id=&id, dia=&dia, mes=&mes, year=&year, dif_year=&dif_year, date=&date, fecha_obj=&fecha_obj);
	%else %do;
		%put &message;
	%end;
	
%mend;

%variar(data_in=fechas, data_out=fechas_transform, id=id, dia=dia, mes=mes, year=anio, dif_year=dif_year, date=date, fecha_obj=20170229);





























