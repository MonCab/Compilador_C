bison programa.y -yd
flex lex.l
gcc main.c  attributes.c  lex.yy.c y.tab.c  -o ejec

