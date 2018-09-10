/* MOUT data */
data mout;
   infile "/folders/myfolders/3HW/mout.csv" dlm=",";
   input Student Q1-Q150;
run;

proc print data=mout;
	sum Q1-Q150;
run;

/* IOUT data */
data iout;
   infile "/folders/myfolders/3HW/iout.csv" dlm=",";
   input Student Q Score;
run;

proc print data=iout;
	where Student=63;
	sum Score;
run;
