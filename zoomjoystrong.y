%{
	#include <stdio.h>
	#include "zoomjoystrong.h"
	void yyerror(const char* msg);
	int yylex();
%}
%error-verbose
%union {int i; float f;}

%start zoomjoystrong

%token END
%token END_STATEMENT
%token POINT
%token LINE
%token CIRCLE
%token RECTANGLE
%token SET_COLOR
%token INT
%token FLOAT

%type<i> INT
%type<f> FLOAT

%%

zoomjoystrong: sentence END
	     | sentence zoomjoystrong
;

sentence: line_command
	| point_command
	| circle_command
	| rectangle_command
	| set_color
;

line_command: LINE INT INT INT INT END_STATEMENT	{printf("line_command"); line($2, $3, $4, $5);}
	    ;

point_command: POINT INT INT END_STATEMENT 		{printf("point_command"); point($2, $3);}
	     ;

circle_command: CIRCLE INT INT INT END_STATEMENT	{printf("circle_command"); circle($2, $3, $4);}
	      ;

rectangle_command: RECTANGLE INT INT INT INT END_STATEMENT {printf("rectangle_command"); rectangle($2, $3, $4, $5);}
		 ;
set_color: SET_COLOR INT INT INT END_STATEMENT		{printf("set_color"); set_color($2, $3, $4);}
	 ;


%%

int main(int argc, char** argv){
	setup();
	yyparse();
//	finish();
}

void yyerror(const char* msg){
	fprintf(stderr, "error: %s\n", msg);
}
int yywrap(void){
	return 1;
}
