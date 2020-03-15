%{
	#include "zoomjoystrong.tab.h"
	#include <stdlib.h>
	#include <stdio.h>
	#include "zoomjoystrong.h"
	int isEnd = 0;
%}

%%

[0-9]+		{printf("INT"); yylval.i = atoi(yytext); return INT;}
[0-9]\.[0-9]	{yylval.f = atof(yytext); return FLOAT;}
;		{printf("SEMICOLON"); return END_STATEMENT;}
<<EOF>>		{if (isEnd == 0){
			finish();
			isEnd = 1;
			return END;}
		else{
			yyterminate();
			}
		}
point		{printf("POINT"); return POINT;}
line		{printf("LINE"); return LINE;}
circle		{printf("CIRCLE"); return CIRCLE;}
rectangle	{printf("RECTANGLE"); return RECTANGLE;}
set_color	{printf("SET_COLOR"); return SET_COLOR;}
[ \t\s\n\r]	;		;
%%
