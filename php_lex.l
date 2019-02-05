%{
#include <stdio.h>
#define T_START 1
#define T_END 1
#define T_ID 2
#define T_LE 3
#define T_GE 4
#define T_NEC 5
#define T_NE 6
#define T_EQ 7
#define T_EQC 8
#define T_EXP 9
#define T_AND 10
#define T_OR 11
#define T_XOR 12
#define T_SW 13
#define T_FE 14
#define T_AS 15
#define T_CASE 16
#define T_BR 17
#define T_DF 18
#define NUM 19
%}
D [0-9.]
%option yylineno
%%
"<?php" {return T_START;}
"?>" {return T_END;}
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
"switch" {return T_SW;}
"foreach" {return T_FE;}
"as" {return T_AS;}
"case" {return T_CASE;}
"break" {return T_BR;}
"default" {return T_DF;}
{D}+ {return NUM;}
[ \t\n] {;}
"<" {return 60;}
">" {return 62;}
"!" {return 33;}
"{" {return 123;}
"}" {return 125;}
"(" {return 40;}
")" {return 41;}
";" {return 59;}
":" {return 158;}
"+" {return 43;}
"-" {return 45;}
"*" {return 42;}
"/" {return 47;}
"%" {return 37;}
"=" {return 61;}
"$"[_a-zA-Z][_a-zA-Z0-9]* {return T_ID;}
. {return -1;}
%%

int main()
{
  int token = yylex();
  while(token)
  {
    if(token == -1)
    {
      printf("Invalid syntax at line %d\n",yylineno);
      exit(0);
    }
    printf("%s %d %d\n",yytext,token,yylineno);
    token = yylex();
  }
  return 0;
}
