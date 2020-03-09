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

zoomjoystrong: sentance END
	     | zoomjoystrong sentance END
;

sentance: line_command END_STATEMENT
	| point_command END_STATEMENT
	| circle_command END_STATEMENT
	| rectangle_command END_STATEMENT
	| set_color END_STATEMENT


%%

int main(int argc, char** argv){
	yyparse();
}
