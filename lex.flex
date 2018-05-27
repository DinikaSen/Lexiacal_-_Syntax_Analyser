%option noyywrap
%x COMMENT

%{
#include "parse.tab.h"
extern char* yytext;
void yyerror(char const *s){
   fprintf(stderr, "ERROR : %s\n" ,s);
}

%}

%%

"if"			{return IF;}
"else"			{return ELSE;}
"int"			{return INT;}
"return"		{return RETURN;}
"void"			{return VOID;}
"while"			{return WHILE;}
"+"			{return PLUS;}
"-"			{return MINUS;}
"*"			{return MUL;}
"/"			{return DIV;}
"<"			{return LOWER;}
"<="			{return LOWER_OR_EQUAL;}
">"			{return GREATER;}
">="			{return GREATER_OR_EQUAL;}
"=="			{return EQUAL;}
"!="			{return NOT_EQUAL;}
"="			{return ASSIGN;}
";"			{return SEMICOLON;}
","			{return COMMA;}
"{"			{return OPEN_BRACE;}
"}"			{return CLOSE_BRACE;}
"("			{return OPEN_PARENTHESES;}
")"			{return CLOSE_PARENTHESES;}
"["			{return OPEN_SQR_BRACKET;}
"]"			{return CLOSE_SQR_BRACKET;}
"/*"			{BEGIN(COMMENT);
			printf("inside comment\n");}
<COMMENT>"*/"		{BEGIN(INITIAL);
			printf("end of comment\n");}
<COMMENT>.		{ }
<COMMENT>\n		{ printf("new line inside comment\n");}
<COMMENT><<EOF>>	{yyerror( "Unclosed multiline comment..!" );
                   	yyterminate();}
[a-zA-Z]+		{return ID;}
[0-9]+			{return NUM;}
[ \t\n]+		{;}
.			{yyerror("Unexpected token..!");}

%%
