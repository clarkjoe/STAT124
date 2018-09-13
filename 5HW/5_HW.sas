/* simple data step */
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

/* sorted by sales */
proc sort data=employees_sales out=employees_sales_sortSales;
	by descending sales;
run;

proc print data=employees_sales_sortSales noobs label; /* remembered to suppress obs */
	var lname sales;
	title 'Sales Report 1';
	label lname='Last Names';
	label sales='Sales';

/* sorted by last name */
proc sort data=employees_sales out=employees_sales_sortLname;
	by lname;
run;

proc print data=employees_sales_sortLname noobs label; /* remembered to suppress obs */
	var lname sales;
	title 'Sales Report 2';
	label lname='Last Names';
	label sales='Sales';
	
/* sales average by lname */
proc means data=employees_sales_sortLname mean noprint;
	by lname;
	output out=results (drop=_TYPE_ _FREQ_)
		mean=sales;
run;
	
proc print data=results noobs label;
	title 'Sales Average Report 1';
	label lname='Last Names';
	label sales='Sales';
run;

/* sales average (class) by lname */
proc means data=employees_sales mean noprint;
	class lname;
	output out=results (drop=_TYPE_ _FREQ_)
		mean=sales;
run;
	
proc print data=results noobs label;
	title 'Sales Average Report 2';
	label lname='Last Names';
	label sales='Sales';