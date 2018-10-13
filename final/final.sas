filename dA '/folders/myshortcuts/STAT124/SASUniversityEdition/myfolders/final/Domains FormA.csv';
filename dB '/folders/myshortcuts/STAT124/SASUniversityEdition/myfolders/final/Domains FormB.csv';
filename fA '/folders/myshortcuts/STAT124/SASUniversityEdition/myfolders/final/FormA.csv';
filename fB '/folders/myshortcuts/STAT124/SASUniversityEdition/myfolders/final/FormB.csv';

/* data statments */
data domainA;
	infile dA delimiter=',' dsd;
	input ID $ (A1-A150) ($);
run;