data employees;
   infile "/folders/myshortcuts/STAT124/SASUniversityEdition/myfolders/hw2.txt";
   input lname $ fname $
         age job $ gender $;
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