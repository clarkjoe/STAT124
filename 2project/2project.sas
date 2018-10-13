filename anKey '/folders/myshortcuts/STAT124/SASUniversityEdition/myfolders/1project/A1_Ans_only.txt';
filename stuAn '/folders/myshortcuts/STAT124/SASUniversityEdition/myfolders/1project/Form A1_only.csv';

/* data statments */
data answerKey;
	infile anKey delimiter=',' dsd;
	input ID $ (A1-A150) ($);
/* 	ID = substrn(ID, 5, 3); */
run;

data studentAnswers;
	infile stuAn delimiter=',' dsd;
	input ID $ (A1-A150) ($); 
run;

/* perform calculations */
data results;
	set answerKey studentAnswers;
	
	array answers(150) $ A1-A150;
	array keys(150) $ k1-k150;
	array match(150) m1-m150;
	
	retain k1-k150;
	
	if ID = "AAAAKEY" then do;
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
	keep ID matches r;
run;

/* rename variables and convert to numeric */
data results;
	set results;
	Identifier = input(ID, best12.);
	Question = input(r, best12.);
	matched = input(matches, best12.);
	drop r matches ID;
run;

/* means statement */
proc means data=results sum nonobs noprint nway;
	class Identifier;
	var matched;
	output out=scores (drop=_TYPE_ _FREQ_)
		sum=Student_Scores;
run;

proc means data=results sum nonobs noprint nway;
	class Question;
	var matched;
	output out=questions (drop=_TYPE_ _FREQ_)
		sum=Number_Correct;
run;

/* sort statments */
proc sort data=scores;
	by Descending Student_Scores Identifier;
run;

proc sort data=questions;
	by Descending Number_Correct Question;
run;

/* print statements */
proc print data=scores;
run;

proc print data=questions;
run;