%{
	#include <stdio.h>
	#include "zoomjoystrong.h"
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
	     | sentence zoomjoystrong
;

sentence: line_command
	| point_command
	| circle_command
	| rectangle_command
	| set_color
;							
							//the default dimensions of the GUI window are 1024x768
							//check that no command is drawing off the screen
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
									yyerror("circle command values are out of bounds");
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
							//RGB values cannot be more than 255
							//check that the user is not asking for an invalid RGB
set_color: SET_COLOR INT INT INT END_STATEMENT		{if ($2 <= 255 && $3 <= 255 && $4 <= 255){
								if ($2 >= 0 && $3 >= 0 && $4 >= 0){
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
//main to setup the GUI and execute the REPL
//GUI window is closed in the END match of the lexer
int main(int argc, char** argv){
	setup();
	yyparse();
}
//basic report from stderr error function
void yyerror(const char* msg){
	fprintf(stderr, "error: %s\n", msg);
}
//yywrap is a function for lexing/parsing multiple files in a row
//it is not alway included automatically
//this program will only lex/parse one file, so this function will always return 1
int yywrap(void){
	return 1;
}
