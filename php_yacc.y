%{
  #include <stdio.h>
  #include <stdlib.h>
  #include <string.h>
  #define YYSTYPE char *
  int yylex();
  void yyerror(char *);
  void lookup(char *,int );
  void insert(char *,int );
  extern FILE *yyin;
  extern int yylineno;
  extern char *yytext;
  typedef struct symbol_table
  {
    int line;
    char name[32];
  }ST;
  int struct_index = 0;
  ST st[10000];
%}

%token T_START T_END T_LE T_GE T_NEC T_NE T_EQC T_EXP T_AND
%token T_OR T_XOR T_FE T_AS T_CASE T_BR T_DF NUM T_LT T_GT
%token T_NOT T_OP T_CP T_OB T_CB T_SC T_C T_PL T_MIN T_STAR T_DIV T_MOD T_EQL
%token T_EQ T_ID T_SW

%start Start
%%

Start :T_START Statements T_END {lookup($1,@1.last_line);lookup($3,@3.last_line);};
  ;

Statements: Statements Assignment T_SC
  |Assignment T_SC
  |Statements Switch_Stat
  |Switch_Stat
  ;

Switch_Stat : T_SW T_OB switch_exp T_CB T_OP Switch_Blk T_CP {lookup($1,@1.last_line);lookup($2,@2.last_line);lookup($4,@4.last_line);lookup($5,@5.last_line);lookup($7,@7.last_line);};
switch_exp : T_ID T_PL Assignment {lookup($1,@1.last_line);lookup($2,@2.last_line);};
  | T_ID T_MIN Assignment {lookup($1,@1.last_line);lookup($2,@2.last_line);};
  | T_ID T_STAR Assignment {lookup($1,@1.last_line);lookup($2,@2.last_line);};
  | T_ID T_DIV Assignment {lookup($1,@1.last_line);lookup($2,@2.last_line);};
  | NUM T_PL Assignment {lookup($1,@1.last_line);lookup($2,@2.last_line);};
  | NUM T_MIN Assignment {lookup($1,@1.last_line);lookup($2,@2.last_line);};
  | NUM T_STAR Assignment {lookup($1,@1.last_line);lookup($2,@2.last_line);};
  | NUM T_DIV Assignment {lookup($1,@1.last_line);lookup($2,@2.last_line);};
  |NUM {lookup($1,@1.last_line);};
	|T_ID {lookup($1,@1.last_line);};
  ;

Switch_Blk : CaseBlock
  | CaseBlock DEF {lookup($2,@2.last_line);};
	;

CaseBlock :CaseBlock T_CASE NUM T_C St1 {lookup($2,@2.last_line);lookup($3,@3.last_line);lookup($4,@4.last_line);};
  |CaseBlock T_CASE NUM T_C St1 T_BR T_SC {lookup($2,@2.last_line);lookup($3,@3.last_line);lookup($4,@4.last_line);lookup($6,@6.last_line);lookup($7,@7.last_line);};
  |
	;

DEF : T_DF T_C St1 T_BR T_SC  {lookup($1,@1.last_line);lookup($2,@2.last_line);lookup($3,@3.last_line);lookup($4,@4.last_line);lookup($5,@5.last_line);};
	|T_DF T_C St1  {lookup($1,@1.last_line);lookup($2,@2.last_line);};
	;

St1 : St1 exp T_SC {lookup($3,@3.last_line);};
	| exp T_SC {lookup($2,@2.last_line);};
	;

exp :Assignment
	;

Assignment: T_ID T_EQL Assignment {lookup($1,@1.last_line);lookup($2,@2.last_line);};
	| T_ID T_PL Assignment {lookup($1,@1.last_line);lookup($2,@2.last_line);};
	| T_ID T_MIN Assignment  {lookup($1,@1.last_line);lookup($2,@2.last_line);};
	| T_ID T_STAR Assignment {lookup($1,@1.last_line);lookup($2,@2.last_line);};
	| T_ID T_DIV Assignment  {lookup($1,@1.last_line);lookup($2,@2.last_line);};
	| NUM T_PL Assignment  {lookup($1,@1.last_line);lookup($2,@2.last_line);};
	| NUM T_MIN Assignment {lookup($1,@1.last_line);lookup($2,@2.last_line);};
	| NUM T_STAR Assignment  {lookup($1,@1.last_line);lookup($2,@2.last_line);};
	| NUM T_DIV Assignment {lookup($1,@1.last_line);lookup($2,@2.last_line);};
	| T_OB Assignment T_CB {lookup($2,@2.last_line);};
	| T_MIN NUM  {lookup($2,@2.last_line);};
	| T_MIN T_ID {lookup($2,@2.last_line);};
	| NUM  {lookup($1,@1.last_line);};
	| T_ID {lookup($1,@1.last_line);};
  ;
%%

int main(int argc,char *argv[])
{
  yyin = fopen("input.txt","r");
  if(!yyparse())  //yyparse-> 0 if success
  {
    printf("Parsing Complete\n");
    printf("-----------------------Symbol Table-----------------\n");
    for(int i = 0;i < struct_index;i++)
    {
      printf("Token %s Line number %d\n",st[i].name,st[i].line);
    }
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
  printf("Error :%s at %d \n",yytext,yylineno);
}

void lookup(char *token,int line)
{
  //printf("Token %s line number %d\n",token,line);
  int flag = 0;
  for(int i = 0;i < struct_index;i++)
  {
    if(!strcmp(st[i].name,token))
    {
      flag = 1;
      break;
    }
  }
  if(flag == 0)
  {
    insert(token,line);
  }
}
void insert(char *token,int line)
{
  strcpy(st[struct_index].name,token);
  st[struct_index].line = line;
  struct_index++;
}
