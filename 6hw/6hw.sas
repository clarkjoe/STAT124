/* IOUT data */
data iout;
   infile "/folders/myfolders/3HW/iout.csv" dlm=",";
   input Student Q Score;
run;
 
/* sum scores by student */
proc means data=iout mean sum nonobs noprint nway;
	class Student;
	var Score;
	id Q;
	output out=StudentResults (drop=_TYPE_ _FREQ_)
		sum=StudentSum
run;

/* percentage of correct answers by student */
data StudentResults;
	set StudentResults;
	StudentPerct=(divide(StudentSum, 150) * 100);
run;

proc print data=StudentResults noobs label;
	var Student StudentPerct;
	label StudentPerct = Percentage;
run;

/* sum scores by question */
proc means data=iout mean sum nonobs noprint nway;
	class Q;
	var Score;
	output out=QResults (drop=_TYPE_ _FREQ_)
		sum=QSum;
run;

/* percentage of students with correct answer by question */
data QResults;
	set QResults;
	QPerct=(divide(QSum, 50) * 100);
run;

proc print data=QResults noobs label;
	var Q QPerct;
	label Q = Question
	QPerct = Percentage;
run;