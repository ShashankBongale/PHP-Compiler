typedef struct symbol_table
{
  int line;
  char name[31];
}ST;
void lookup(char *,int );
void insert(char *,int );
void search_id(char *,int );
