/* Data statement to get data */
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

/* Custom format for job code */
proc format;
	value $jobtitle 'SR1'='Sales Rep 1' /* remembering not to use '.' at end */
					'SR2'='Sales Rep 2'
					'Man'='Manager'
					'Sec'='Secretary'
					'Jan'='Janitor'
					'Mec'='Mechanic';
run;

/* Simple sort by job */
proc sort data=employees out=employees_sort;
	by job;
run;

/* Print statement to apply and see output of custom formats */
proc print data=employees_sort label;
	format job $jobtitle.; /* remembering to use '.' at end */
	title 'Employees';
	label lname='Last Name';
	label fname='First Name';
	label age='Age';
	label Job='Job';
	label Gender='Gender';
	footnote 'Employee Report';
run;
