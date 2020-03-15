%{
	#include "zoomjoystrong.tab.h"
	#include <stdlib.h>
	#include <stdio.h>
	#include "zoomjoystrong.h"
	int isEnd = 0;
%}

%%

[0-9]+		{yylval.i = atoi(yytext); return INT;}
[0-9]\.[0-9]	{yylval.f = atof(yytext); return FLOAT;}
;		{return END_STATEMENT;}
<<EOF>>		{if (isEnd == 0){
			finish();
			isEnd = 1;
			return END;}
		else{
			yyterminate();
			}
		}
point		{return POINT;}
line		{return LINE;}
circle		{return CIRCLE;}
rectangle	{return RECTANGLE;}
set_color	{return SET_COLOR;}
[ \t\s\n\r]	;		;
%%
