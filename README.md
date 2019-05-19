# Mini Compiler for PHP
A simple mini-compiler for PHP(switch and foreach) with syntax analysis,semantic analysis,intermediate code genetation and abstract syntax tree functionality.
## Compilation steps
Make sure that input is stored in input.txt
* lex php_lex.l
* yacc php_yacc.y
* gcc lex.yyc y.tab.c -o run
* ./run
