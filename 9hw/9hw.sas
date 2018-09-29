/* employees data */
data employees;
	input lname $ fname $ age job $ gender $ group $ state $10.;
	datalines;
Smith Al 55 Man M 1 Texas
Jones Ted 38 SR2 M 2 Vermont
Hall Kim 22 SR1 M 2 Vermont
Jones Kim 19 Sec F 1 Maryland
Clark Guy 31 SR1 M 2 Maryland
Grant Herbert 51 Jan M 3 Texas
Schmidt Henry 62 Mec M 4 Washington
Allen Joe 45 Man M 1 Vermont
Call Steve 43 SR2 M 2 Maryland
McCall Mac 26 Sec F 1 Texas
Sue Joe 25 Mec F 4 Texas
Murphy Cori 21 SR1 F 2 Washington
Love Sue 27 SR2 F 2 Washington
;
run;

/* making employees1 data */
data employees1;
	set employees;
	length boss $ 6;
	if group=1 then
	boss='john';
	else if group=2 then
	boss='carl';
	else if group=3 then
	boss='harold';
	else if group=4 then
	boss='jacob';
	if state='Texas' then
	localcode=11;
	else if state='Vermont' then
	localcode=22;
	else if state='Washington' then
	localcode=33;
	else if state='Maryland' then
	localcode=44;
run;

/* performing first set of tasks */
data employees1;
	set employees1;
	s="nos";
	b1=upcase(compress(boss||s));
	b2=translate(b1, 'NOS', 'SON');
run;

/* employees_sales data */
data employees_sales;
   input lname $ fname $ month $ sales;
   datalines;
Jones Ted Jan 28500
Jones Ted Feb 31200
Jones Ted Mar 14500
Jones Ted Apr 23000
Jones Ted May 42670
Jones Ted Jun 52000
Jones Ted Jul 1200
Jones Ted Aug 13000
Jones Ted Sep 19500
Jones Ted Oct 18430
Jones Ted Nov 19230
Jones Ted Dec 68201
Hall Kim Jan 12500
Hall Kim Feb 13400
Hall Kim Mar 17800
Hall Kim Apr 21200
Hall Kim May 23900
Hall Kim Jun 24100
Hall Kim Jul 25200
Hall Kim Aug 23950
Hall Kim Sep 22200
Hall Kim Oct 21090
Hall Kim Nov 18040
Hall Kim Dec 14210
Clark Guy Jan 32101
Clark Guy Feb 43001
Clark Guy Mar 29050
Clark Guy Apr 25010
Clark Guy May 22999
Clark Guy Jun 20500
Clark Guy Jul 21100
Clark Guy Aug 23400
Clark Guy Sep 27890
Clark Guy Oct 31090
Clark Guy Nov 52300
Clark Guy Dec 41230
Call Steve Jan 12090
Call Steve Feb 10901
Call Steve Mar 9080
Call Steve Apr 8541
Call Steve May 7521
Call Steve Jun 5300
Call Steve Jul 2510
Murphy Cori Jul 5700
Murphy Cori Aug 6900
Murphy Cori Sep 10200
Murphy Cori Oct 12050
Murphy Cori Nov 26800
Murphy Cori Dec 25963
Love Sue Jun 4800
Love Sue Jul 6900
Love Sue Aug 9500
Love Sue Sep 13420
Love Sue Oct 17890
Love Sue Nov 21090
Love Sue Dec 22500
;

/* both proc sort steps to then be merged by */
proc sort data=employees1;
	by lname fname;
proc sort data=employees_sales;
	by lname fname;

/* perform the merge on both sorted vars */
data salesmerged;
	merge employees1 employees_sales;
	by lname fname;
	
/* perform the proc means */
proc means data=salesmerged (drop=age gender group state boss localcode s b1 b2 month) sum nonobs noprint nway;
	class lname fname;
	var sales;
	id job;
	where job contains("SR");
	output out=salessum  (drop=_TYPE_ _FREQ_)
		sum=totalsales;
run;

/* data step to get correct format */
data salessum;
	set salessum;
	totalsales_format=put(totalsales, dollar10.);
	put totalsales_format=;
	drop totalsales;

/* print data sets */
proc print data=employees1 noobs;
proc print data=salesmerged noobs;
proc print data=salessum label noobs;
	label lname='Last Name';
	label fname='First Name';
	label job="Position";
	label totalsales_format="Total Sales";

/* perform ods actions */
ods pdf file="/folders/myfolders/9hw/ods9hw.pdf";
proc print data=employees1 noobs;
proc print data=salesmerged noobs;
proc print data=salessum label noobs;
	label lname='Last Name';
	label fname='First Name';
	label job="Position";
	label totalsales_format="Total Sales";
ods _all_ close;

		