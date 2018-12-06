bison programa.y -yd
flex lex.l
gcc main.c lex.yy.c y.tab.c attributes.c  -o ejec

