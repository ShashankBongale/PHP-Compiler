%{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include "y.tab.h"
#define YY_USER_ACTION yylloc.first_line = yylloc.last_line = yylineno;
%}
D [0-9.]
%option yylineno
%%
"<?php" {strcpy(yylval.type.string,yytext);return T_START;}
"?>" {strcpy(yylval.type.string,yytext);return T_END;}
"<=" {strcpy(yylval.type.string,yytext);return T_LE;}
">=" {strcpy(yylval.type.string,yytext);return T_GE;}
"!==" {strcpy(yylval.type.string,yytext);return T_NEC;}
"<>"|"!=" {strcpy(yylval.type.string,yytext);return T_NE;}
"==" {strcpy(yylval.type.string,yytext);return T_EQ;}
"===" {strcpy(yylval.type.string,yytext);return T_EQC;}
"**" {strcpy(yylval.type.string,yytext);return T_EXP;}
"and"|"&&" {strcpy(yylval.type.string,yytext);return T_AND;}
"or"|"||" {strcpy(yylval.type.string,yytext);return T_OR;}
"xor" {strcpy(yylval.type.string,yytext);return T_XOR;}
"switch" {strcpy(yylval.type.string,yytext);return T_SW;}
"foreach" {strcpy(yylval.type.string,yytext);return T_FE;}
"as" {strcpy(yylval.type.string,yytext);return T_AS;}
"case" {strcpy(yylval.type.string,yytext);return T_CASE;}
"break" {strcpy(yylval.type.string,yytext);return T_BR;}
"default" {strcpy(yylval.type.string,yytext);return T_DF;}
{D}+ {strcpy(yylval.type.string,yytext);return NUM;}
[ \t\n] {;}
"<" {strcpy(yylval.type.string,yytext);return T_LT;}
">" {strcpy(yylval.type.string,yytext);return T_GT;}
"!" {strcpy(yylval.type.string,yytext);return T_NOT;}
"{" {strcpy(yylval.type.string,yytext);return T_OP;}
"}" {strcpy(yylval.type.string,yytext);return T_CP;}
"(" {strcpy(yylval.type.string,yytext);return T_OB;}
")" {strcpy(yylval.type.string,yytext);return T_CB;}
";" {strcpy(yylval.type.string,yytext);return T_SC;}
":" {strcpy(yylval.type.string,yytext);return T_C;}
"+" {strcpy(yylval.type.string,yytext);return T_PL;}
"-" {strcpy(yylval.type.string,yytext);return T_MIN;}
"*" {strcpy(yylval.type.string,yytext);return T_STAR;}
"/" {strcpy(yylval.type.string,yytext);return T_DIV;}
"," {strcpy(yylval.type.string,yytext);return T_COM;}
"%" {strcpy(yylval.type.string,yytext);return T_MOD;}
"=" {strcpy(yylval.type.string,yytext);return T_EQL;}
"echo" {strcpy(yylval.type.string,yytext);return T_ECH;}
"array" {strcpy(yylval.type.string,yytext);return T_ARR;}
"$"[_a-zA-Z][_a-zA-Z0-9]* {strcpy(yylval.type.string,yytext);return T_ID;}
\"(\\.|[^"\\])*\" {strcpy(yylval.type.string,yytext);return T_STR;}
. {printf("Did not match any valid token");return yytext[0];};
%%
int yywrap()
{
  return 1;
}
