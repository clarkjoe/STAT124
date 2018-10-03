/* creating user-defined format */
proc format;
	value num
		0='zero'
		1='one'
		2='two'
		3='three'
		4='four'
		5='five'
		6='six'
		7='seven'
		8='eight'
		9='nine'
		;
run;

/* perform all necessary calculations */
data one;
	array x{10} x1-x10;
	do i=0 to 9;
		n=put(i, num.);
		do j=0 to 9;
		k=sum((i*10),j);
		o=put(j, num.);
		if mod(k, 2)^=1 then
			m='EVEN';
		else
			m='ODD';
		p=upcase(compress(n||o));
		q=tranwrd(p, 'NO', 'ON');
		r=substrn(q,1,2);
		x{1} = ((1)/k);
		x{2} = ((2)/k);
		x{3} = ((3)/k);
		x{4} = ((4)/k);
		x{5} = ((5)/k);
		x{6} = ((6)/k);
		x{7} = ((7)/k);
		x{8} = ((8)/k);
		x{9} = ((9)/k);
		x{10} = ((10)/k);
		output;
		end;
	end;
run;

/* rearrange order of columns */
data onePretty;
	retain i j k x1-x10 m n o p q r;
	set one;
run;
	
/* simple proc print step */
proc print data=onePretty noobs;

/* perform ods action */
ods pdf file="/folders/myfolders/10hw/ods10hw.pdf";
proc print data=onePretty noobs;
ods _all_ close;