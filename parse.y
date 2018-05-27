%{ 
#include <stdarg.h>
#include <stdio.h>    
#define YYSTYPE char*
int yylex();
void yyerror(char const *s);
int yydebug = 1;
                                                                
%} 

/* Token definitions */
%token IF
%token ELSE
%token INT
%token RETURN
%token VOID
%token WHILE
%token PLUS
%token MINUS
%token MUL
%token DIV
%token LOWER
%token LOWER_OR_EQUAL
%token GREATER
%token GREATER_OR_EQUAL
%token EQUAL
%token NOT_EQUAL
%token ASSIGN
%token SEMICOLON
%token COMMA
%token OPEN_BRACE
%token CLOSE_BRACE
%token OPEN_PARENTHESES
%token CLOSE_PARENTHESES
%token OPEN_SQR_BRACKET
%token CLOSE_SQR_BRACKET
%token COMMENT_START
%token COMMENT_END
%token ID
%token NUM
                                                                                                                                                      
 

/* Grammar rule set */
%%  
program: declaration-list;

declaration-list: declaration-list declaration 			
		| declaration;

declaration: var-declaration
	   | fun-declaration;

var-declaration: type-specifier ID SEMICOLON
		| type-specifier ID OPEN_SQR_BRACKET NUM CLOSE_SQR_BRACKET SEMICOLON;

type-specifier: INT | VOID;

fun-declaration: type-specifier ID OPEN_PARENTHESES params CLOSE_PARENTHESES compound-stmt;

params: param-list | VOID;

param-list: param-list COMMA param 
	  | param;

param: type-specifier ID
     | type-specifier ID OPEN_SQR_BRACKET CLOSE_SQR_BRACKET;

compound-stmt: OPEN_BRACE local-declarations statement-list CLOSE_BRACE;

local-declarations: local-declarations var-declaration
		  | %empty;

statement-list: statement-list statement
	      | %empty;

statement: expression-stmt 
	 | compound-stmt
	 | selection-stmt
	 | iteration-stmt
	 | return-stmt;

expression-stmt: expression SEMICOLON
	       | SEMICOLON;

selection-stmt: IF OPEN_PARENTHESES expression CLOSE_PARENTHESES statement
	      | IF OPEN_PARENTHESES expression CLOSE_PARENTHESES statement ELSE statement;

iteration-stmt: WHILE OPEN_PARENTHESES expression CLOSE_PARENTHESES statement;

return-stmt: RETURN SEMICOLON
           | RETURN expression SEMICOLON;

expression: var ASSIGN expression
	  | simple-expression;

var: ID | ID OPEN_SQR_BRACKET expression CLOSE_SQR_BRACKET;


simple-expression: additive-expression relop additive-expression
		 | additive-expression;

relop: LOWER | LOWER_OR_EQUAL
     | GREATER | GREATER_OR_EQUAL
     | EQUAL | NOT_EQUAL;

additive-expression: additive-expression addop term 
		   | term;

addop: PLUS | MINUS;

term: term mulop factor | factor;

mulop: MUL | DIV;

factor: OPEN_PARENTHESES expression CLOSE_PARENTHESES
      | var
      | call
      | NUM;

call: ID OPEN_PARENTHESES args CLOSE_PARENTHESES;

args: arg-list | %empty;

arg-list: arg-list COMMA expression
        | expression;
                                                                       
%%                                                                                   
 
int main(void){
   yyparse();
}

