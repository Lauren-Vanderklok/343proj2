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

line_command: LINE INT INT INT INT END_STATEMENT	{if ($2 <= 1024 && $4 <= 1024 && $3 <= 768 && $5 <= 768){
								if ($2 >= 0 && $3 >= 0 && $4 >= 0 && $5 >= 0){
	    								line($2, $3, $4, $5);}
								else{
									yyerror("line command values are out of bounds");
								}
							}else{
								yyerror("line command values are out of bounds");
							}
							}
								
	    ;

point_command: POINT INT INT END_STATEMENT 		{if ($2 <= 1024 && $3 <= 768){
	     							if ($2 >= 0 && $3 >= 0){
									point($2, $3);
								}else{
									yyerror("point command values are out of bounds");
								}
							}else{
								yyerror("point command values are out of bounds");
							}
							}
	     ;

circle_command: CIRCLE INT INT INT END_STATEMENT	{if ($2 <= 1024 && $3 <= 768){
	      							if ($2 >= 0 && $3 >= 0){
									circle($2, $3, $4);
								}else{
									yyerrror("circle command values are out of bounds");
								}
							}else{
								yyerror("circle command values are out of bounds");
							}
							}
	      ;

rectangle_command: RECTANGLE INT INT INT INT END_STATEMENT {if ($2 <= 1024 && $3 <= 768){
								if ($2 >= 0 && $3 >= 0){
									rectangle($2, $3, $4, $5);
								}else{
									yyerror("rectangle command values are out of bounds");
								}
							}else{
								yyerror("rectangle command values are out of bounds");
							}
							}
		 ;
set_color: SET_COLOR INT INT INT END_STATEMENT		{if ($2 <= 255 && $3 <= 255 && $4 <= 255){
								if ($2 >= 0 && $3 >= 0 $4 >= 0){
									set_color($2, $3, $4);
								}else{
									yyerror("set color command values are out of bounds");
								}
							}else{
								yyerror("set color command values are out of bounds");
							}	
							}
	 ;


%%

int main(int argc, char** argv){
	setup();
	yyparse();
}

void yyerror(const char* msg){
	fprintf(stderr, "error: %s\n", msg);
}
int yywrap(void){
	return 1;
}
