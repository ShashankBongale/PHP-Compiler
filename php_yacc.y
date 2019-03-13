%{
  #include <stdio.h>
  #include <stdlib.h>
  #include <string.h>
  #define YYSTYPE char *
  int yylex();
  void yyerror(char *);
  void lookup(char *,int ,int );
  void insert(char *,int ,int );
  void search_id(char *,int );
  extern FILE *yyin;
  extern int yylineno;
  extern char *yytext;
  typedef struct symbol_table
  {
    int line;
    char name[31];
    int flag_array;
  }ST;
  int struct_index = 0;
  ST st[10000];
%}

%token T_START T_END T_LE T_GE T_NEC T_NE T_EQC T_EXP T_AND
%token T_OR T_XOR T_FE T_AS T_CASE T_BR T_DF NUM T_LT T_GT
%token T_NOT T_OP T_CP T_OB T_CB T_SC T_C T_PL T_MIN T_STAR T_DIV T_MOD T_EQL
%token T_EQ T_ID T_SW T_COM T_ARR T_STR T_ECH

%start Start
%%

Start :T_START Statements T_END {lookup($1,@1.last_line,0);lookup($3,@3.last_line,0);};
  ;

Statements: Statements Assignment T_SC {lookup($3,@3.last_line,0);};
  |Assignment T_SC  {lookup($2,@2.last_line,0);};
  |Statements Switch_Stat
  |Switch_Stat
  |Statements Foreach_Stat
  |Foreach_Stat
  |Statements Echo
  |Echo
  |Statements Array_stat
  |Array_stat
  ;

Echo:T_ECH T_STR T_SC {lookup($1,@1.last_line,0);lookup($2,@2.last_line,0);};
  ;

Array_stat:T_ID T_EQL T_ARR T_OB Data T_COM NUM T_CB T_SC {lookup($1,@1.last_line,1);lookup($2,@2.last_line,0);lookup($3,@3.last_line,0);lookup($4,@4.last_line,0);lookup($6,@6.last_line,0);lookup($7,@7.last_line,0);lookup($8,@8.last_line,0);};
  |T_ID T_EQL T_ARR T_OB Data T_COM T_ID T_CB T_SC{lookup($1,@1.last_line,1);lookup($2,@2.last_line,0);lookup($3,@3.last_line,0);lookup($4,@4.last_line,0);lookup($6,@6.last_line,0);search_id($7,@7.last_line);lookup($7,@7.last_line,0);lookup($8,@8.last_line,0);lookup($9,@9.last_line,0);};
  ;

Foreach_Stat : T_FE T_OB T_ID T_AS T_ID T_CB T_OP Foreach_Blk T_CP {lookup($1,@1.last_line,0);lookup($2,@2.last_line,0);search_id($3,@3.last_line);lookup($3,@3.last_line,0);lookup($4,@4.last_line,0);lookup($5,@5.last_line,0);lookup($6,@6.last_line,0);lookup($7,@7.last_line,0);lookup($9,@9.last_line,0);};

Foreach_Blk : St1;

Switch_Stat : T_SW T_OB switch_exp T_CB T_OP Switch_Blk T_CP {lookup($1,@1.last_line,0);lookup($2,@2.last_line,0);lookup($4,@4.last_line,0);lookup($5,@5.last_line,0);lookup($7,@7.last_line,0);};
switch_exp : T_ID T_PL Rightpart {search_id($1,@1.last_line);lookup($1,@1.last_line,0);lookup($2,@2.last_line,0);};
  | T_ID T_MIN Rightpart {search_id($1,@1.last_line);lookup($1,@1.last_line,0);lookup($2,@2.last_line,0);};
  | T_ID T_STAR Rightpart {search_id($1,@1.last_line);lookup($1,@1.last_line,0);lookup($2,@2.last_line,0);};
  | T_ID T_DIV Rightpart {search_id($1,@1.last_line);lookup($1,@1.last_line,0);lookup($2,@2.last_line,0);};
  | NUM T_PL Rightpart {lookup($1,@1.last_line,0);lookup($2,@2.last_line,0);};
  | NUM T_MIN Rightpart {lookup($1,@1.last_line,0);lookup($2,@2.last_line,0);};
  | NUM T_STAR Rightpart {lookup($1,@1.last_line,0);lookup($2,@2.last_line,0);};
  | NUM T_DIV Rightpart {lookup($1,@1.last_line,0);lookup($2,@2.last_line,0);};
  |NUM {lookup($1,@1.last_line,0);};
	|T_ID {search_id($1,@1.last_line);lookup($1,@1.last_line,0);};
  ;

Switch_Blk : CaseBlock
  | CaseBlock DEF {lookup($2,@2.last_line,0);};
	;

CaseBlock :CaseBlock T_CASE NUM T_C St1 {lookup($2,@2.last_line,0);lookup($3,@3.last_line,0);lookup($4,@4.last_line,0);};
  |CaseBlock T_CASE NUM T_C St1 T_BR T_SC {lookup($2,@2.last_line,0);lookup($3,@3.last_line,0);lookup($4,@4.last_line,0);lookup($6,@6.last_line,0);lookup($7,@7.last_line,0);};
  |
	;

DEF : T_DF T_C St1 T_BR T_SC  {lookup($1,@1.last_line,0);lookup($2,@2.last_line,0);lookup($3,@3.last_line,0);lookup($4,@4.last_line,0);lookup($5,@5.last_line,0);};
	|T_DF T_C St1  {lookup($1,@1.last_line,0);lookup($2,@2.last_line,0);};
	;

St1 : St1 exp T_SC {lookup($3,@3.last_line,0);};
	| exp T_SC {lookup($2,@2.last_line,0);};
  |St1 T_ECH T_STR T_SC {lookup($2,@2.last_line,0);lookup($3,@3.last_line,0);};
  |T_ECH T_STR T_SC {lookup($1,@1.last_line,0);lookup($2,@2.last_line,0);};
  |St1 T_ID T_EQL T_ARR T_OB Data T_COM NUM T_CB T_SC {lookup($2,@2.last_line,1);lookup($3,@3.last_line,0);lookup($4,@4.last_line,0);lookup($5,@5.last_line,0);lookup($7,@7.last_line,0);lookup($8,@8.last_line,0);lookup($9,@9.last_line,0);lookup($10,@10.last_line,0);};
  |T_ID T_EQL T_ARR T_OB Data T_COM NUM T_CB T_SC {lookup($1,@1.last_line,1);lookup($2,@2.last_line,0);lookup($3,@3.last_line,0);lookup($4,@4.last_line,0);lookup($6,@6.last_line,0);lookup($7,@7.last_line,0);lookup($8,@8.last_line,0);lookup($9,@9.last_line,0);};
  |St1 T_ID T_EQL T_ARR T_OB Data T_COM T_ID T_CB T_SC {lookup($2,@2.last_line,1);lookup($3,@3.last_line,0);lookup($4,@4.last_line,0);lookup($5,@5.last_line,0);lookup($7,@7.last_line,0);search_id($8,@8.last_line);lookup($8,@8.last_line,0);lookup($9,@9.last_line,0);lookup($10,@10.last_line,0);};
  |T_ID T_EQL T_ARR T_OB Data T_COM T_ID T_CB T_SC {lookup($1,@1.last_line,1);lookup($2,@2.last_line,0);lookup($3,@3.last_line,0);lookup($4,@4.last_line,0);lookup($6,@6.last_line,0);search_id($7,@7.last_line);lookup($7,@7.last_line,0);lookup($8,@8.last_line,0);lookup($9,@9.last_line,0);};
  ;

exp :Assignment
  ;

Assignment: T_ID T_EQL Rightpart {lookup($1,@1.last_line,0);lookup($2,@2.last_line,0);};

Rightpart:  T_ID T_PL Rightpart {search_id($1,@1.last_line);lookup($1,@1.last_line,0);lookup($2,@2.last_line,0);};
| T_ID T_MIN Rightpart  {search_id($1,@1.last_line);lookup($1,@1.last_line,0);lookup($2,@2.last_line,0);};
| T_ID T_STAR Rightpart {search_id($1,@1.last_line);lookup($1,@1.last_line,0);lookup($2,@2.last_line,0);};
| T_ID T_DIV Rightpart  {search_id($1,@1.last_line);lookup($1,@1.last_line,0);lookup($2,@2.last_line,0);};
| NUM T_PL Rightpart  {lookup($1,@1.last_line,0);lookup($2,@2.last_line,0);};
| NUM T_MIN Rightpart {lookup($1,@1.last_line,0);lookup($2,@2.last_line,0);};
| NUM T_STAR Rightpart  {lookup($1,@1.last_line,0);lookup($2,@2.last_line,0);};
| NUM T_DIV Rightpart {lookup($1,@1.last_line,0);lookup($2,@2.last_line,0);};
| NUM  {lookup($1,@1.last_line,0);};
| T_ID {search_id($1,@1.last_line);lookup($1,@1.last_line,0);};
;

Data :Data T_COM NUM {lookup($3,@3.last_line,0);};
  |NUM {lookup($1,@1.last_line,0);};
  |Data T_COM T_ID {search_id($3,@3.last_line);lookup($3,@3.last_line,0);};
  |T_ID {search_id($1,@1.last_line);lookup($1,@1.last_line,0);};
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
      printf("%d Token %s Line number %d Is Array %d\n",i+1,st[i].name,st[i].line,st[i].flag_array);
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

void lookup(char *token,int line,int is_array)
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
    insert(token,line,is_array);
  }
}
void insert(char *token,int line,int is_array)
{
  strcpy(st[struct_index].name,token);
  st[struct_index].line = line;
  st[struct_index].flag_array = is_array;
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
