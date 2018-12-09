bison -yd programa.y 
flex lex.l
gcc  stack.c tablatipo.c lex.yy.c y.tab.c main.c  -o ejec

