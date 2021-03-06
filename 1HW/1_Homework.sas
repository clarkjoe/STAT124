
data employees;
   input lname $ fname $ age job $ gender $;
   datalines;
Smith Al 55 Man M
Jones Ted 38 SR2 M
Hall Kim 22 SR1 M
Jones Kim 19 Sec F
Clark Guy 31 SR1 M
Grant Herbert 51 Jan M
Schmidt Henry 62 Mec M
Allen Joe 45 Man M
Call Steve 43 SR2 M
McCall Mac 26 Sec F
Sue Joe 25 Mec F
Murphy Cori 21 SR1 F
Love Sue 27 SR2 F
;
run;

/* PROC statment to sort by desceding age */
/*    Title, labels, and footnotes are added to report */
/* Added the temporary work.neat table to practice working with temporary tables */
proc sort data=employees out=work.neat;
	by descending age;
proc print data=neat label;
	var lname fname age job gender;
	title 'Employees';
	label lname='Last Name';
	label fname='First Name';
	label age='Age';
	label Job='Job';
	label Gender='Gender';
	footnote 'Employee Report';
run;