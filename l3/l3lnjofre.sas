/* pregunta 1 */

*LECTURA DE LA DATA;
DATA ESTAB_8VO;
    LENGTH
        IDREGION         $ 2
        RBD                8
        DDCIA            $ 2
        RURALIDAD        $ 1
        GRUPO            $ 1
        LEN                8
        MAT                8
        NAT                8
        SOC                8 ;
    FORMAT
        IDREGION         $CHAR2.
        RBD              BEST5.
        DDCIA            $CHAR2.
        RURALIDAD        $CHAR1.
        GRUPO            $CHAR1.
        LEN              BEST3.
        MAT              BEST3.
        NAT              BEST3.
        SOC              BEST3. ;
    INFORMAT
        IDREGION         $CHAR2.
        RBD              BEST5.
        DDCIA            $CHAR2.
        RURALIDAD        $CHAR1.
        GRUPO            $CHAR1.
        LEN              BEST3.
        MAT              BEST3.
        NAT              BEST3.
        SOC              BEST3. ;
    INFILE '/folders/myfolders/l3/ESTAB_8VO.txt'
        LRECL=32767
        FIRSTOBS=2
        ENCODING="WLATIN1"
        DLM='09'x
        MISSOVER
        DSD ;
    INPUT
        IDREGION         : $CHAR2.
        RBD              : ?? BEST5.
        DDCIA            : $CHAR2.
        RURALIDAD        : $CHAR1.
        GRUPO            : $CHAR1.
        LEN              : ?? BEST3.
        MAT              : ?? BEST3.
        NAT              : ?? BEST3.
        SOC              : ?? BEST3. ;
        
    RENAME LEN=LENGUAJE_OCTAVO;
    RENAME MAT=MATEMATICAS_OCTAVO;
    RENAME NAT=NATURALES_OCTAVO;
    RENAME SOC=SOCIALES_OCTAVO;
RUN; 

DATA ESTAB_4TO;
    LENGTH
        IDREGION         $ 2
        RBD                8
        ALUMNOS            8
        DDCIA            $ 2
        RURALIDAD        $ 1
        GRUPO            $ 1
        LEN                8
        MAT                8
        NAT                8 ;
    FORMAT
        IDREGION         $CHAR2.
        RBD              BEST5.
        ALUMNOS          BEST3.
        DDCIA            $CHAR2.
        RURALIDAD        $CHAR1.
        GRUPO            $CHAR1.
        LEN              BEST3.
        MAT              BEST3.
        NAT              BEST3. ;
    INFORMAT
        IDREGION         $CHAR2.
        RBD              BEST5.
        ALUMNOS          BEST3.
        DDCIA            $CHAR2.
        RURALIDAD        $CHAR1.
        GRUPO            $CHAR1.
        LEN              BEST3.
        MAT              BEST3.
        NAT              BEST3. ;
    INFILE '/folders/myfolders/l3/ESTAB_4TO.txt'
        LRECL=32767
        FIRSTOBS=2
        ENCODING="WLATIN1"
        DLM='09'x
        MISSOVER
        DSD ;
    INPUT
        IDREGION         : $CHAR2.
        RBD              : ?? BEST5.
        ALUMNOS          : ?? BEST3.
        DDCIA            : $CHAR2.
        RURALIDAD        : $CHAR1.
        GRUPO            : $CHAR1.
        LEN              : ?? BEST3.
        MAT              : ?? BEST3.
        NAT              : ?? BEST3. ;
        
    RENAME LEN=LENGUAJE_CUARTO;
    RENAME MAT=MATEMATICAS_CUARTO;
    RENAME NAT=NATURALES_CUARTO;
RUN;

*PREGUNTA1 ;
/* pregunta 1 */

proc report data=ESTAB_4TO nowd;
	column IDREGION GRUPO N;
	define IDREGION / group 'IDREGION'  ;

	define GRUPO / group 'GRUPO' ;

	define N / 'N';
	run;
quit;
 


/* pregunta 2*/
PROC SORT data=ESTAB_4TO out=ESTAB_4TO_2;
by RBD;
run;

PROC SORT data=ESTAB_8VO out=ESTAB_8VO_2;
by RBD;
run;

data MBYRBD;
merge ESTAB_4TO_2(in=a) ESTAB_8VO_2(in=b);
by RBD;
if a then curso = 'Cuarto'; else curso = 'Octavo';
run;

proc report data=WORK.MBYRBD nowd;
	column IDREGION N LEN MAT NAT SOC;
	define IDREGION / group 'IDREGION' format=$CHAR2. missing order=formatted;
	compute IDREGION;
		if IDREGION ne ' ' then hold1=IDREGION;
		if IDREGION eq ' ' then IDREGION=hold1;
	endcomp;
	define N / 'N';
	define LEN / analysis MEAN 'LEN' format=BEST3. missing;
	define MAT / analysis MEAN 'MAT' format=BEST3. missing;
	define NAT / analysis MEAN 'NAT' format=BEST3. missing;
	define SOC / analysis MEAN 'SOC' format=BEST3. missing;
	run;
quit;

/* pregunta 3 */



