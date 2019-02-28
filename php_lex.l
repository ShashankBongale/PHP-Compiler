%{
#include <stdio.h>
#include "y.tab.h"
%}
D [0-9.]
%option yylineno
%%
"<?php" {printf("Start\n");return T_START;}
"?>" {printf("End\n");return T_END;}
"<=" {return T_LE;}
">=" {return T_GE;}
"!==" {return T_NEC;}
"<>"|"!=" {return T_NE;}
"==" {return T_EQ;}
"===" {return T_EQC;}
"**" {return T_EXP;}
"and"|"&&" {return T_AND;}
"or"|"||" {return T_OR;}
"xor" {return T_XOR;}
"switch" {printf("switch\n");return T_SW;}
"foreach" {return T_FE;}
"as" {return T_AS;}
"case" {return T_CASE;}
"break" {printf("break\n");return T_BR;}
"default" {return T_DF;}
{D}+ {printf("Digit\n");yylval = atoi(yytext);return NUM;}
[ \t\n] {;}
"<" {return T_LT;}
">" {return T_GT;}
"!" {return T_NOT;}
"{" {return T_OP;}
"}" {return T_CP;}
"(" {printf("Open braces\n");return T_OB;}
")" {return T_CB;}
";" {printf("Semicolon\n");return T_SC;}
":" {return T_C;}
"+" {printf("Plus\n");return T_PL;}
"-" {return T_MIN;}
"*" {return T_STAR;}
"/" {return T_DIV;}
"%" {return T_MOD;}
"=" {printf("Equal\n");return T_EQL;}
"$"[_a-zA-Z][_a-zA-Z0-9]* {printf("Identifier\n");return T_ID;}
. {printf("Did not match any valid token");return yytext[0];};
%%
int yywrap()
{
  return 1;
}
