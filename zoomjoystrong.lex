%{
	#include "zoomjoystrong.tab.h"
	#include <stdlib.h>
	#include <stdio.h>
	#include "zoomjoystrong.h"
	//for a reason the programmer is not aware of, flex will often detect more than one EOF signal
	//this boolean int, and the code with the <<EOF>> match is meant to check if flex has already detected a EOF signal 
	//so this lexer does not report multiple. 
	int isEnd = 0;
%}

%%

[0-9]+		{yylval.i = atoi(yytext); return INT;}
[0-9]\.[0-9]	{yylval.f = atof(yytext); return FLOAT;} //note: no float is actually used in sample code 
;		{return END_STATEMENT;}
<<EOF>>		{if (isEnd == 0){ //if no EOF has previously been matched
			finish(); //close GUI window
			isEnd = 1;
			return END;} //return a single END terminal
		else{
			yyterminate();
			}
		}
point		{return POINT;}
line		{return LINE;}
circle		{return CIRCLE;}
rectangle	{return RECTANGLE;}
set_color	{return SET_COLOR;}
[ \t\s\n\r]	;	//ignore whitespace	
%%
