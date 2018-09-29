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
	local=11;
	else if state='Vermont' then
	local=22;
	else if state='Washington' then
	local=33;
	else if state='Maryland' then
	local=44;
run;
	
/* creating user format */
proc format;
	value $gf
		1="john"
		2="carl"
		3="harold"
		4="jacob";
	invalue sf
		"Texas"=11
		"Vermont"=22
		"Washington"=33
		"Maryland"=44;
run;

/* using the formats */
data employees2;
	set employees;
	boss=put(group, $gf.);
	local=input(state, sf.);

/* printing the data */
proc print data=employees1;
proc print data=employees2;