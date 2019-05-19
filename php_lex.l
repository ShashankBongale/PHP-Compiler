%{
#include <stdio.h>
#include <stdlib.h>
#define YYSTYPE char *
#include "y.tab.h"
#define YY_USER_ACTION yylloc.first_line = yylloc.last_line = yylineno;
%}
D [0-9.]
%option yylineno
%%
"<?php" {yylval=strdup(yytext);return T_START;}
"?>" {yylval=strdup(yytext);return T_END;}
"<=" {yylval=strdup(yytext);return T_LE;}
">=" {yylval=strdup(yytext);return T_GE;}
"!==" {yylval=strdup(yytext);return T_NEC;}
"<>"|"!=" {yylval=strdup(yytext);return T_NE;}
"==" {yylval=strdup(yytext);return T_EQ;}
"===" {yylval=strdup(yytext);return T_EQC;}
"**" {yylval=strdup(yytext);return T_EXP;}
"and"|"&&" {yylval=strdup(yytext);return T_AND;}
"or"|"||" {yylval=strdup(yytext);return T_OR;}
"xor" {yylval=strdup(yytext);return T_XOR;}
"switch" {yylval=strdup(yytext);return T_SW;}
"foreach" {yylval=strdup(yytext);return T_FE;}
"as" {yylval=strdup(yytext);return T_AS;}
"case" {yylval=strdup(yytext);return T_CASE;}
"break" {yylval=strdup(yytext);return T_BR;}
"default" {yylval=strdup(yytext);return T_DF;}
{D}+ {yylval=strdup(yytext);return NUM;}
[ \t\n] {;}
"<" {yylval=strdup(yytext);return T_LT;}
">" {yylval=strdup(yytext);return T_GT;}
"!" {yylval=strdup(yytext);return T_NOT;}
"{" {yylval=strdup(yytext);return T_OP;}
"}" {yylval=strdup(yytext);return T_CP;}
"(" {yylval=strdup(yytext);return T_OB;}
")" {yylval=strdup(yytext);return T_CB;}
";" {yylval=strdup(yytext);return T_SC;}
":" {yylval=strdup(yytext);return T_C;}
"+" {yylval=strdup(yytext);return T_PL;}
"-" {yylval=strdup(yytext);return T_MIN;}
"*" {yylval=strdup(yytext);return T_STAR;}
"/" {yylval=strdup(yytext);return T_DIV;}
"," {yylval=strdup(yytext);return T_COM;}
"%" {yylval=strdup(yytext);return T_MOD;}
"=" {yylval=strdup(yytext);return T_EQL;}
"[" {yylval=strdup(yytext);return T_SQO;}
"]" {yylval=strdup(yytext);return T_SQC;}
"echo" {yylval=strdup(yytext);return T_ECH;}
"array" {yylval=strdup(yytext);return T_ARR;}
"$"[_a-zA-Z][_a-zA-Z0-9]* {yylval=strdup(yytext);return T_ID;}
\"(\\.|[^"\\])*\" {yylval=strdup(yytext);return T_STR;}
. {printf("Did not match any valid token");return yytext[0];};
%%
int yywrap()
{
  return 1;
}
