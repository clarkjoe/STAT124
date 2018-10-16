filename dA '/folders/myshortcuts/STAT124/SASUniversityEdition/myfolders/final/Domains FormA.csv';
filename dB '/folders/myshortcuts/STAT124/SASUniversityEdition/myfolders/final/Domains FormB.csv';
filename fA '/folders/myshortcuts/STAT124/SASUniversityEdition/myfolders/final/FormA.csv';
filename fB '/folders/myshortcuts/STAT124/SASUniversityEdition/myfolders/final/FormB.csv';

/* data statments */
data domainA;
	infile dA delimiter=',' firstobs=2 dsd;
	length Id $5. Domain $50.;
	input Id $ Domain $ Domain_Num Question;
run;

data domainB;
	infile dB delimiter=',' firstobs=2 dsd;
	length Id $5. Domain $50.;
	input Id $ Domain $ Domain_Num Question;
run;

data formA;
	infile fA delimiter=',' dsd;
	input Id $ (A1-A150) ($);
run;

data formB;
	infile fB delimiter=',' dsd;
	input Id $ (A1-A150) ($);
run;

/* perform calculations */
data resultsA;
	set formA;
	
	array answers(150) $ A1-A150;
	array keys(150) $ k1-k150;
	array match(150) m1-m150;
	
	retain k1-k150;
	
	if Id = "AAAAKEY" then do;
		do i = 1 to 150;
			keys(i) = answers(i);
		end;
	end;
	
	else do;
		do r = 1 to 150;
			if keys(r) = answers(r) then match(r) = 1;
			else match(r) =0;
			matches = match(r);
			output;
		end;
	end;
	keep Id matches r;
run;

data resultsB;
	set formB;
	
	array answers(150) $ A1-A150;
	array keys(150) $ k1-k150;
	array match(150) m1-m150;
	
	retain k1-k150;
	
	if Id = "BBBBKEY" then do;
		do i = 1 to 150;
			keys(i) = answers(i);
		end;
	end;
	
	else do;
		do r = 1 to 150;
			if keys(r) = answers(r) then match(r) = 1;
			else match(r) =0;
			matches = match(r);
			output;
		end;
	end;
	keep Id matches r;
run;

/* rename variables and convert to numeric */
data resultsA;
	set resultsA;
	Student = input(Id, best12.);
	Question = input(r, best12.);
	matched = input(matches, best12.);
	Form = 'A';
	drop r matches Id;
run;

data resultsB;
	set resultsB;
	Student = input(Id, best12.);
	Question = input(r, best12.);
	matched = input(matches, best12.);
	Form = 'B';
	drop r matches Id;
run;

/* proc sort statements */
proc sort data=resultsA;
	by Question;
run;
proc sort data=domainA;
	by Question;
run;

proc sort data=resultsB;
	by Question;
run;
proc sort data=domainB;
	by Question;
run;

/* merge statements */
data mergedA;
	merge resultsA domainA;
	by Question;
run;

data mergedB;
	merge resultsB domainB;
	by Question;
run;

/* combine two merged datasets */
data grand;
	set mergedA mergedB;

/* proc means statement */
proc means data=grand sum nonobs noprint;
	class Student Domain_Num;
	var matched;
	id Domain Form;
	where Student=1 or Student=2 or Student=3;
	output out=skyrim (drop=_TYPE_ _FREQ_)
		sum=Score;
run;

data skyrim;
	set skyrim (firstobs=7);
	Percentage=Score/100;
 run;

proc print data=skyrim;
run;
