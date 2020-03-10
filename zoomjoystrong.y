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
;

line_command: LINE INT INT INT INT 	{printf("line command");}
	    ;

point_command: POINT INT INT 		{printf("point command");}
	     ;

circle_command: CIRCLE INT INT INT	{printf("circle command");}
	      ;

rectangle_command: RECTANGLE INT INT INT INT {printf("rectangle command");}
		 ;
set_color: SET_COLOR INT INT INT	{printf("set color");}
	 ;


%%

int main(int argc, char** argv){
	yyparse();
}

void yyerror(const char* msg){
	fprintf(stderr, "error: %s\n", msg);
}
