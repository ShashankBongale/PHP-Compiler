# php_compiler
A simple compiler for php
# compilation steps
1)lex php_lex.l
2)gcc lex.yy.c -ll -o run
3)./run < new.php
