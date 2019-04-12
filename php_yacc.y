%{
  #include <stdio.h>
  #include <stdlib.h>
  #include <string.h>
  #define YYDEBUG 1
  //#define YYSTYPE char *
  int yylex();
  void yyerror(char *);
  void lookup(char *,int ,int ,int );
  void insert(char *,int ,int ,int );
  struct node *build_tree(char *,struct node *,struct node *);
  void search_id(char *,int );
  extern FILE *yyin;
  extern int yylineno;
  extern char *yytext;
  typedef struct symbol_table
  {
    int line;
    char name[31];
    int flag_array;
    char type[15];
  }ST;

  int struct_index = 0;
  ST st[10000];

%}
%code requires
{
  typedef struct node
  {
    struct node *left;
    struct node  *right;
    char *operand;
  }node;

  typedef struct data_type
  {
    char string[31];
    node *tree_node;
  }data_type;
}

%union
{
  data_type type;
}

%token <type> T_START T_END T_LE T_GE T_NEC T_NE T_EQC T_EXP T_AND
%token <type> T_OR T_XOR T_FE T_AS T_CASE T_BR T_DF NUM T_LT T_GT
%token <type> T_NOT T_OP T_CP T_OB T_CB T_SC T_C T_PL T_MIN T_STAR T_DIV T_MOD T_EQL
%token <type> T_EQ T_ID T_SW T_COM T_ARR T_STR T_ECH

%start Start
%%

Start :T_START Statements T_END {lookup($1.string,@1.last_line,0,0);lookup($3.string,@3.last_line,0,0);};
  ;

Statements: Statements Assignment T_SC {lookup($3.string,@3.last_line,0,5);};
  |Assignment T_SC  {lookup($2.string,@2.last_line,0,5);};
  |Statements Switch_Stat
  |Switch_Stat
  |Statements Foreach_Stat
  |Foreach_Stat
  |Statements Echo
  |Echo
  |Statements Array_stat
  |Array_stat
  ;

Echo:T_ECH T_STR T_SC {lookup($1.string,@1.last_line,0,0);lookup($2.string,@2.last_line,0,6);};
  ;

Array_stat:T_ID T_EQL T_ARR T_OB Data T_COM NUM T_CB T_SC {lookup($1.string,@1.last_line,1,4);lookup($2.string,@2.last_line,0,1);lookup($3.string,@3.last_line,0,0);lookup($4.string,@4.last_line,0,5);lookup($6.string,@6.last_line,0,5);lookup($7.string,@7.last_line,0,4);lookup($8.string,@8.last_line,0,5);lookup($9.string,@9.last_line,0,5);};
  |T_ID T_EQL T_ARR T_OB Data T_COM T_ID T_CB T_SC{lookup($1.string,@1.last_line,1,4);lookup($2.string,@2.last_line,0,1);lookup($3.string,@3.last_line,0,0);lookup($4.string,@4.last_line,0,5);lookup($6.string,@6.last_line,0,5);search_id($7.string,@7.last_line);lookup($7.string,@7.last_line,0,4);lookup($8.string,@8.last_line,0,5);lookup($9.string,@9.last_line,0,5);};
  ;

Foreach_Stat : T_FE T_OB T_ID T_AS T_ID T_CB T_OP Foreach_Blk T_CP {lookup($1.string,@1.last_line,0,0);lookup($2.string,@2.last_line,0,5);search_id($3.string,@3.last_line);lookup($3.string,@3.last_line,0,4);lookup($4.string,@4.last_line,0,0);lookup($5.string,@5.last_line,0,4);lookup($6.string,@6.last_line,0,5);lookup($7.string,@7.last_line,0,5);lookup($9.string,@9.last_line,0,5);};

Foreach_Blk : St1;

Switch_Stat : T_SW T_OB switch_exp T_CB T_OP Switch_Blk T_CP {lookup($1.string,@1.last_line,0,0);lookup($2.string,@2.last_line,0,5);lookup($4.string,@4.last_line,0,5);lookup($5.string,@5.last_line,0,5);lookup($7.string,@7.last_line,0,5);};

//build tree
switch_exp : T_ID T_PL Rightpart {search_id($1.string,@1.last_line);lookup($1.string,@1.last_line,0,4);lookup($2.string,@2.last_line,0,1);};
  | T_ID T_MIN Rightpart {search_id($1.string,@1.last_line);lookup($1.string,@1.last_line,0,4);lookup($2.string,@2.last_line,0,1);};
  | T_ID T_STAR Rightpart {search_id($1.string,@1.last_line);lookup($1.string,@1.last_line,0,4);lookup($2.string,@2.last_line,0,1);};
  | T_ID T_DIV Rightpart {search_id($1.string,@1.last_line);lookup($1.string,@1.last_line,0,4);lookup($2.string,@2.last_line,0,1);};
  | NUM T_PL Rightpart {lookup($1.string,@1.last_line,0,3);lookup($2.string,@2.last_line,0,1);};
  | NUM T_MIN Rightpart {lookup($1.string,@1.last_line,0,3);lookup($2.string,@2.last_line,0,1);};
  | NUM T_STAR Rightpart {lookup($1.string,@1.last_line,0,3);lookup($2.string,@2.last_line,0,1);};
  | NUM T_DIV Rightpart {lookup($1.string,@1.last_line,0,3);lookup($2.string,@2.last_line,0,1);};
  |NUM {lookup($1.string,@1.last_line,0,3);};
	|T_ID {search_id($1.string,@1.last_line);lookup($1.string,@1.last_line,0,4);};
  ;

Switch_Blk : CaseBlock
  | CaseBlock DEF {};
	;

CaseBlock :CaseBlock T_CASE NUM T_C St1 {lookup($2.string,@2.last_line,0,0);lookup($3.string,@3.last_line,0,3);lookup($4.string,@4.last_line,0,5);};
  |CaseBlock T_CASE NUM T_C St1 T_BR T_SC {lookup($2.string,@2.last_line,0,0);lookup($3.string,@3.last_line,0,3);lookup($4.string,@4.last_line,0,5);lookup($6.string,@6.last_line,0,0);lookup($7.string,@7.last_line,0,5);};
  |
	;

DEF : T_DF T_C St1 T_BR T_SC  {lookup($1.string,@1.last_line,0,0);lookup($2.string,@2.last_line,0,5);lookup($4.string,@4.last_line,0,0);lookup($5.string,@5.last_line,0,5);};
	|T_DF T_C St1  {lookup($1.string,@1.last_line,0,0);lookup($2.string,@2.last_line,0,5);};
	;

//build tree
St1 : St1 exp T_SC {lookup($3.string,@3.last_line,0,5);};
	| exp T_SC {lookup($2.string,@2.last_line,0,5);};
  |St1 T_ECH T_STR T_SC {lookup($2.string,@2.last_line,0,0);lookup($3.string,@3.last_line,0,6);lookup($4.string,@4.last_line,0,5);};
  |T_ECH T_STR T_SC {lookup($1.string,@1.last_line,0,0);lookup($2.string,@2.last_line,0,6);lookup($2.string,@2.last_line,0,5);};
  |St1 T_ID T_EQL T_ARR T_OB Data T_COM NUM T_CB T_SC {lookup($2.string,@2.last_line,1,4);lookup($3.string,@3.last_line,0,1);lookup($4.string,@4.last_line,0,0);lookup($5.string,@5.last_line,0,5);lookup($7.string,@7.last_line,0,5);lookup($8.string,@8.last_line,0,3);lookup($9.string,@9.last_line,0,5);lookup($10.string,@10.last_line,0,5);};
  |T_ID T_EQL T_ARR T_OB Data T_COM NUM T_CB T_SC {lookup($1.string,@1.last_line,1,4);lookup($2.string,@2.last_line,0,1);lookup($3.string,@3.last_line,0,0);lookup($4.string,@4.last_line,0,5);lookup($6.string,@6.last_line,0,5);lookup($7.string,@7.last_line,0,3);lookup($8.string,@8.last_line,0,5);lookup($9.string,@9.last_line,0,5);};
  |St1 T_ID T_EQL T_ARR T_OB Data T_COM T_ID T_CB T_SC {lookup($2.string,@2.last_line,1,4);lookup($3.string,@3.last_line,0,1);lookup($4.string,@4.last_line,0,0);lookup($5.string,@5.last_line,0,5);lookup($7.string,@7.last_line,0,5);search_id($8.string,@8.last_line);lookup($8.string,@8.last_line,0,4);lookup($9.string,@9.last_line,0,5);lookup($10.string,@10.last_line,0,5);};
  |T_ID T_EQL T_ARR T_OB Data T_COM T_ID T_CB T_SC {lookup($1.string,@1.last_line,1,4);lookup($2.string,@2.last_line,0,1);lookup($3.string,@3.last_line,0,0);lookup($4.string,@4.last_line,0,5);lookup($6.string,@6.last_line,0,5);search_id($7.string,@7.last_line);lookup($7.string,@7.last_line,0,4);lookup($8.string,@8.last_line,0,5);lookup($9.string,@9.last_line,0,5);};
  ;

exp :Assignment
  ;

//build tree
Assignment: T_ID T_EQL Rightpart {lookup($1.string,@1.last_line,0,4);lookup($2.string,@2.last_line,0,1);};

Rightpart:  T_ID T_PL Rightpart {search_id($1.string,@1.last_line);lookup($1.string,@1.last_line,0,4);lookup($2.string,@2.last_line,0,1);build_tree($2.string,$1,$3);};
| T_ID T_MIN Rightpart  {search_id($1.string,@1.last_line);lookup($1.string,@1.last_line,0,4);lookup($2.string,@2.last_line,0,1);};
| T_ID T_STAR Rightpart {search_id($1.string,@1.last_line);lookup($1.string,@1.last_line,0,4);lookup($2.string,@2.last_line,0,1);};
| T_ID T_DIV Rightpart  {search_id($1.string,@1.last_line);lookup($1.string,@1.last_line,0,4);lookup($2.string,@2.last_line,0,1);};
| NUM T_PL Rightpart  {lookup($1.string,@1.last_line,0,3);lookup($2.string,@2.last_line,0,1);};
| NUM T_MIN Rightpart {lookup($1.string,@1.last_line,0,3);lookup($2.string,@2.last_line,0,1);};
| NUM T_STAR Rightpart  {lookup($1.string,@1.last_line,0,3);lookup($2.string,@2.last_line,0,1);};
| NUM T_DIV Rightpart {lookup($1.string,@1.last_line,0,3);lookup($2.string,@2.last_line,0,1);};
| NUM  {lookup($1.string,@1.last_line,0,3);build_tree($1.string,NULL,NULL)};
| T_ID {search_id($1.string,@1.last_line);lookup($1.string,@1.last_line,0,4);build_tree($1.string,NULL,NULL)};
;

//purely for array elements as understood till now
Data :Data T_COM NUM {lookup($2.string,@2.last_line,0,5);lookup($3.string,@3.last_line,0,3);};
  |NUM {lookup($1.string,@1.last_line,0,3);};
  |Data T_COM T_ID {lookup($2.string,@2.last_line,0,5);search_id($3.string,@3.last_line);lookup($3.string,@3.last_line,0,4);};
  |T_ID {search_id($1.string,@1.last_line);lookup($1.string,@1.last_line,0,4);};
  ;

%%

int main(int argc,char *argv[])
{
/*
  #if YYDEBUG
    yydebug = 1;
  #endif
*/
  yyin = fopen("input.txt","r");
  if(!yyparse())  //yyparse-> 0 if success
  {
    printf("Parsing Complete\n");
    printf("-----------------------Symbol Table-----------------\n");
    for(int i = 0;i < struct_index;i++)
    {
      printf("%d Token %s Line number %d Is Array %d %s\n",i+1,st[i].name,st[i].line,st[i].flag_array,st[i].type);
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

void lookup(char *token,int line,int is_array,int type)
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
    insert(token,line,is_array,type);
  }
}
void insert(char *token,int line,int is_array,int type)
{
  strcpy(st[struct_index].name,token);
  st[struct_index].line = line;
  st[struct_index].flag_array = is_array;
  switch(type)
  {
    case 0:strcpy(st[struct_index].type,"Keyword");
           break;
    case 1:strcpy(st[struct_index].type,"Operator");
          break;
    case 2:strcpy(st[struct_index].type,"Rel_Op");
          break;
    case 3:strcpy(st[struct_index].type,"Number");
          break;
    case 4:strcpy(st[struct_index].type,"Identifier");
          break;
    case 5:strcpy(st[struct_index].type,"Punctuation");
        break;
    case 6:strcpy(st[struct_index].type,"Literal");
        break;
    default:strcpy(st[struct_index].type,"Error");
  }
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
struct node *build_tree(char *operand,struct node *left,struct node *right)
{
  printf("Build tree called\n");
  struct node *new_node = (struct node *)malloc(sizeof(struct node));
  char *new_operand = (char *)malloc(sizeof(char) * strlen(operand));
  new_node -> left = left;
  new_node -> right = right;
  new_node -> operand = new_operand;
  return new_node;
}
