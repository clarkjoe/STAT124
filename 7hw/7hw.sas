/* Declaring lib */
libname mydata '/folders/myshortcuts/STAT124/SASUniversityEdition/myfolders/7hwData';

/* Diamonds data */
filename diamonds '/folders/myshortcuts/STAT124/SASUniversityEdition/myfolders/7hw/Diamonds.csv';
data mydata.diamonds (drop=Rater);
	infile diamonds delimiter=',' firstobs=2 dsd; /* dsd for commas in rows */
	input ID Weight Color $ Clarity $ Rater $ Price $;
run;

/* Bodyfat data */
filename bodyfat '/folders/myshortcuts/STAT124/SASUniversityEdition/myfolders/7hw/BodyFat.txt';
data mydata.bodyfat;
	infile bodyfat delimiter='09'x firstobs=2;
	input ID Date $
		  BodyFat Density Age
		  Weight Height
		  Neck Chest Abdomen;
run;

/* FTSE data */
filename ftse '/folders/myshortcuts/STAT124/SASUniversityEdition/myfolders/7hw/FTSE.csv';
data mydata.ftse;
	infile ftse delimiter=',' firstobs=2 dsd; /* dsd for commas in rows */
	input Date $date11. Price $ Open $ High $ Low $ Vol $ Change $;
/* 	I've looked all over and many resources say date11. is the informat to handle DD-MMM-YYYY */
/* 	I cannot figure out why there are still only 8 characters for the Date column  */
/* 	I've spent many hours trying to figure this out */
run;

/* Employees data */
data mydata.employees;
	input lname $ fname $ Age Job $ Gender $ Group State $;
	datalines;
Smith Al 55 Man M 1 Texas
Jones Ted 38 SR2 M 2 Vermont
Hall Kim 22 SR1 M 2 Vermont
Jones Kim 19 Sec F 1 Maryland
Clark Guy 31 SR1 M 2 
Grant Herbert 51 Jan M 3 Texas
Schmidt Henry 62 Mec M 4 Washington
Allen Joe 45 Man M 1 Vermont
Call Steve 43 SR2 M 2 Maryland
McCall Mac 26 Sec F 1 Texas
Sue Joe 25 Mec F 4 
Murphy Cori 21 SR1 F 2 Washington
Love Sue 27 SR2 F 2 Washington
;
run;

/* All proc steps */
proc print data=mydata.diamonds noobs;
proc print data=mydata.bodyfat noobs;
proc print data=mydata.ftse;
proc print data=mydata.employees label;
	label lname='Last Name';
	label fname='First Name';
run;



