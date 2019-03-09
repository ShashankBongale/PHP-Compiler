%{
  #include <stdio.h>
  #include <stdlib.h>
  #include <string.h>
  #define YYSTYPE char *
  int yylex();
  void yyerror(char *);
  void lookup(char *,int );
  void insert(char *,int );
  void search_id(char *,int );
  extern FILE *yyin;
  extern int yylineno;
  extern char *yytext;
  typedef struct symbol_table
  {
    int line;
    char name[31];
  }ST;
  int struct_index = 0;
  ST st[10000];
%}

%token T_START T_END T_LE T_GE T_NEC T_NE T_EQC T_EXP T_AND
%token T_OR T_XOR T_FE T_AS T_CASE T_BR T_DF NUM T_LT T_GT
%token T_NOT T_OP T_CP T_OB T_CB T_SC T_C T_PL T_MIN T_STAR T_DIV T_MOD T_EQL
%token T_EQ T_ID T_SW T_COM T_ARR

%start Start
%%

Start :T_START Statements T_END {lookup($1,@1.last_line);lookup($3,@3.last_line);};
  ;

Statements: Statements Assignment T_SC {lookup($3,@3.last_line);};
  |Assignment T_SC  {lookup($2,@2.last_line);};
  |Statements Switch_Stat
  |Switch_Stat
  |Statements Foreach_Stat
  |Foreach_Stat
  ;

Foreach_Stat : T_FE T_OB T_ID T_AS T_ID T_CB T_OP Foreach_Blk T_CP {lookup($1,@1.last_line);lookup($2,@2.last_line);lookup($3,@3.last_line);lookup($4,@4.last_line);lookup($5,@5.last_line);lookup($6,@6.last_line);lookup($7,@7.last_line);lookup($9,@9.last_line);};

Foreach_Blk : St1;

Switch_Stat : T_SW T_OB switch_exp T_CB T_OP Switch_Blk T_CP {lookup($1,@1.last_line);lookup($2,@2.last_line);lookup($4,@4.last_line);lookup($5,@5.last_line);lookup($7,@7.last_line);};
switch_exp : T_ID T_PL Rightpart {search_id($1,@1.last_line);lookup($1,@1.last_line);lookup($2,@2.last_line);};
  | T_ID T_MIN Rightpart {search_id($1,@1.last_line);lookup($1,@1.last_line);lookup($2,@2.last_line);};
  | T_ID T_STAR Rightpart {search_id($1,@1.last_line);lookup($1,@1.last_line);lookup($2,@2.last_line);};
  | T_ID T_DIV Rightpart {search_id($1,@1.last_line);lookup($1,@1.last_line);lookup($2,@2.last_line);};
  | NUM T_PL Rightpart {lookup($1,@1.last_line);lookup($2,@2.last_line);};
  | NUM T_MIN Rightpart {lookup($1,@1.last_line);lookup($2,@2.last_line);};
  | NUM T_STAR Rightpart {lookup($1,@1.last_line);lookup($2,@2.last_line);};
  | NUM T_DIV Rightpart {lookup($1,@1.last_line);lookup($2,@2.last_line);};
  |NUM {lookup($1,@1.last_line);};
	|T_ID {search_id($1,@1.last_line);lookup($1,@1.last_line);};
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
Assignment: T_ID T_EQL Rightpart {lookup($1,@1.last_line);lookup($2,@2.last_line);};

Rightpart:  T_ID T_PL Rightpart {search_id($1,@1.last_line);lookup($1,@1.last_line);lookup($2,@2.last_line);};
| T_ID T_MIN Rightpart  {search_id($1,@1.last_line);lookup($1,@1.last_line);lookup($2,@2.last_line);};
| T_ID T_STAR Rightpart {search_id($1,@1.last_line);lookup($1,@1.last_line);lookup($2,@2.last_line);};
| T_ID T_DIV Rightpart  {search_id($1,@1.last_line);lookup($1,@1.last_line);lookup($2,@2.last_line);};
| NUM T_PL Rightpart  {lookup($1,@1.last_line);lookup($2,@2.last_line);};
| NUM T_MIN Rightpart {lookup($1,@1.last_line);lookup($2,@2.last_line);};
| NUM T_STAR Rightpart  {lookup($1,@1.last_line);lookup($2,@2.last_line);};
| NUM T_DIV Rightpart {lookup($1,@1.last_line);lookup($2,@2.last_line);};
| T_OB Rightpart T_CB {lookup($2,@2.last_line);};
| T_ARR T_OB Data T_COM NUM T_CB {lookup($1,@1.last_line);lookup($2,@2.last_line);lookup($3,@3.last_line);lookup($4,@4.last_line);lookup($5,@5.last_line);};
| NUM  {lookup($1,@1.last_line);};
| T_ID {search_id($1,@1.last_line);lookup($1,@1.last_line);};

Data : NUM {lookup($1,@1.last_line);};
  |T_ID {search_id($1,@1.last_line);lookup($1,@1.last_line);};
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
      printf("%d Token %s Line number %d\n",i+1,st[i].name,st[i].line);
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
      if(st[i].line != line)
      {
        st[i].line = line;
      }
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
void search_id(char *token,int lineno)
{
  int flag = 0;
  for(int i = 0;i < struct_index;i++)
  {
    if(!strcmp(st[i].name,token))
    {
      flag = 1;
      return;
    }
  }
  if(flag == 0)
  {
    printf("Error at line %d : %s is not defined\n",lineno,token);
    exit(0);
  }
}
