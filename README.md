# php_compiler
A simple compiler for php
### compilation steps
1)lex php_lex.l
2)yacc php_yacc.y
3)gcc lex.yyc y.tab.c -o run
4)./run
