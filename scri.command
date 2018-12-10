bison -yd programa.y 
flex lex.l
gcc  stack.c tablatipo.c backpatch.c codigo_inter.c lex.yy.c y.tab.c main.c  -o ejec

