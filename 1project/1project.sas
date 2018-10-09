filename ans '/folders/myshortcuts/STAT124/SASUniversityEdition/myfolders/1project/A1_Ans_only.txt';
filename domains '/folders/myshortcuts/STAT124/SASUniversityEdition/myfolders/1project/Domains Form A1.csv';
filename form '/folders/myshortcuts/STAT124/SASUniversityEdition/myfolders/1project/Form A1_only.csv';


/* data ans; */
/* 	infile ans delimiter=','; */
/* 	input ID $ (A1-A150) ($); run; */
	
data domains;
/* 	infile domains delimiter=',' firstobs=1s; */
	input Id Domain $ Domain_Number Question; run;
	
data form;
	infile form delimiter=',';
	input Id (A1-A150) ($); run;

/* proc print data=ans; */
proc print data=form;
/* proc print data=domains; */