%{
  #include <stdio.h>
  #include <stdlib.h>
  int yylex();
  void yyerror(char *);
  extern FILE *yyin;
  extern int yylineno;
%}

%token T_START T_END T_LE T_GE T_NEC T_NE T_EQC T_EXP T_AND
%token T_OR T_XOR T_SW T_FE T_AS T_CASE T_BR T_DF NUM T_LT T_GT
%token T_NOT T_OP T_CP T_OB T_CB T_SC T_C T_PL T_MIN T_STAR T_DIV T_MOD T_EQL
%token T_EQ T_ID
%start Start
%%

Start :T_START Statements T_END
  ;

Statements: Statements Assignment T_SC
  |Assignment T_SC
  |Statements Switch_Stat
  |Switch_Stat
  ;

Switch_Stat : T_SW T_OB switch_exp T_CB T_OP Switch_Blk T_CP;

switch_exp : T_ID T_PL Assignment
  | T_ID T_MIN Assignment
  | T_ID T_STAR Assignment
  | T_ID T_DIV Assignment
  | NUM T_PL Assignment
  | NUM T_MIN Assignment
  | NUM T_STAR Assignment
  | NUM T_DIV Assignment
  |NUM
	|T_ID
  ;

Switch_Blk : CaseBlock
  | CaseBlock DEF
	;

CaseBlock :CaseBlock T_CASE NUM T_C St1
  |CaseBlock T_CASE NUM T_C St1 T_BR T_SC
  |
	;

DEF : T_DF T_C St1 T_BR T_SC
	|T_DF T_C St1
	;

St1 : St1 exp T_SC
	| exp T_SC
	;

exp :Assignment
	;

Assignment: T_ID T_EQL Assignment
	| T_ID T_PL Assignment
	| T_ID T_MIN Assignment
	| T_ID T_STAR Assignment
	| T_ID T_DIV Assignment
	| NUM T_PL Assignment
	| NUM T_MIN Assignment
	| NUM T_STAR Assignment
	| NUM T_DIV Assignment
	| T_OB Assignment T_CB
	| T_MIN NUM
	| T_MIN T_ID
	| NUM
	| T_ID
  ;
%%

int main(int argc,char *argv[])
{
  yyin = fopen("input.txt","r");
  if(!yyparse())  //yyparse-> 0 if success
  {
    printf("Parsing Complete\n");
  }
  else
  {
    printf("Parsing failed\n");
  }
  fclose(yyin);
  return 0;
}

void yyerror(char *s)
{
  printf("Error :%s at %d \n",s,yylineno);
}
