%{
	#include <stdio.h>
	void yyerror(const char* msg);
	int yylex();
%}

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
	     | sentence zoomjoystrong END
;

sentence: line_command
	| point_command
	| circle_command
	| rectangle_command
	| set_color
;

line_command: LINE INT INT INT INT END_STATEMENT	{printf("line_command");}
	    ;

point_command: POINT INT INT END_STATEMENT 		{printf("point_command");}
	     ;

circle_command: CIRCLE INT INT INT END_STATEMENT	{printf("circle_command");}
	      ;

rectangle_command: RECTANGLE INT INT INT INT END_STATEMENT {printf("rectangle_command");}
		 ;
set_color: SET_COLOR INT INT INT END_STATEMENT		{printf("set_color");}
	 ;


%%

int main(int argc, char** argv){
	yyparse();
}

void yyerror(const char* msg){
	fprintf(stderr, "error: %s\n", msg);
}
