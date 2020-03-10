%{
	#include "zoomjoystrong.tab.h"
	#include <stdlib.h>
	#include <stdio.h>
%}

%%

[0-9]+		{printf("int"); yylval.i = atoi(yytext); return INT}
[0-9]\.[0-9]	{yylval.f = atof(yytext); return FLOAT}
;		{printf("end_statementt"); return END_STATEMENT}
point		{printf("pointt"); return POINT}
line		{printf("linet"); return LINE}
circle		{printf("circlet"); return CIRCLE}
rectangle	{printf("rectanglet"); return RECTANGLE}
set_color	{printf("set_colort"); return SET_COLOR}
\s		;
\.		;
%%
