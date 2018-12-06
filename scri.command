bison -yd programa.y 
flex lex.l
gcc main.c  attributes.c tablatipo.c lex.yy.c y.tab.c  -o ejec

