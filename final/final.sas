/* windows */
/* filename dA '/folders/myshortcuts/STAT124/SASUniversityEdition/myfolders/final/Domains FormA.csv'; */
/* filename dB '/folders/myshortcuts/STAT124/SASUniversityEdition/myfolders/final/Domains FormB.csv'; */
/* filename fA '/folders/myshortcuts/STAT124/SASUniversityEdition/myfolders/final/FormA.csv'; */
/* filename fB '/folders/myshortcuts/STAT124/SASUniversityEdition/myfolders/final/FormB.csv'; */

/* mac */
filename dA '/folders/myfolders/final/Domains FormA.csv';
filename dB '/folders/myfolders/final/Domains FormB.csv';
filename fA '/folders/myfolders/final/FormA.csv';
filename fB '/folders/myfolders/final/FormB.csv';

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
run;

/* proc means statement */
proc means data=grand sum nonobs noprint;
	class Student Domain_Num;
	var matched;
	id Domain Form;
/* 	where Student=1 or Student=2 or Student=3 or Student=4; */
	output out=skyrim (drop=_TYPE_ _FREQ_)
		sum=Score;
run;

data skyrim;
	set skyrim (firstobs=7);
	if Domain_Num=1 or Domain_Num=3 or Domain_Num=4 then
		Percentage=Score/30;
	else if Domain_Num=2 then
		Percentage=Score/35;
	else if Domain_Num=5 then
		Percentage=Score/25;
	else
		Percentage=Score/150;
run;
 
proc sort data=skyrim;
	by Student;
run;

/* proc print data=skyrim; */

/* video */
data ScoresCombined;
	set skyrim;
	retain os opT ds1 dp1T ds2 dp2T ds3 dp3T ds4 dp4T ds5 dp5T;
	array scores_array(*) os opT ds1 dp1T ds2 dp2T ds3 dp3T ds4 dp4T ds5 dp5T;
	by Student;
	if first.Student then i=0;
	i+1;
	scores_array(i) = Score;
	i+1;
	scores_array(i) = Percentage;
	if last.Student then output;
	drop Domain Domain_Num Score Percentage i;
run;

data ScoresCombined;
	retain Student Form os op ds1 ds2 ds3 ds4 ds5 dp1 dp2 dp3 dp4 dp5;
	set ScoresCombined;
	format op dp1 dp2 dp3 dp4 dp5 percent10.1;
	op=opT;
	dp1=dp1T;
	dp2=dp2T;
	dp3=dp3T;
	dp4=dp4T;
	dp5=dp5T;
	drop opT dp1T dp2T dp3T dp4T dp5T;
run;

proc print data=ScoresCombined;
run;

/* break */
	
proc means data=grand sum nonobs noprint nway;
	class Question Form;
	var matched;
	output out=questions (drop=_TYPE_ _FREQ_)
		sum=correct;
run;

data questions;
	retain Question Form Percentage;
	format Percentage percent10.1;
	set questions;
	Percentage=correct/50;
	drop correct;
run;

data questions1;
	retain Form Question Percentage;
	set questions;
run;

proc sort data=questions1;
	by Form Question;
run;

proc print data=questions1 (obs=10) label;
	title 'Sorted by Form and Question Number';
	label Question='Question Number';
	label Percentage='Question Percentage';
run;

/* 	break */

data questions2;
	retain Percentage Form Question ;
	set questions;
run;

proc sort data=questions2;
	by descending Percentage;
run;

proc print data=questions2 (obs=10) label;
	title 'Sorted by Question Percentage';
	label Question='Question Number';
	label Percentage='Question Percentage';
run;
	
	
	
	
	
	
