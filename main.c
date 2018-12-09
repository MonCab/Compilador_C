#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "stack.h"
#include <stdbool.h>
#include"tablasTipos.h"
extern FILE *yyin ;
extern int yyparse();


/* Sección de código del usuario */
/* Aquí se realiza la apertura de ambos archivos (entrada y salida) */
int main(int argc, char  **argv){
	
//	FILE *f; /* Se genera un apuntador al archivo*/
//	if (argc < 2 ) return -1; /* Si no se ingresa el archivo de entrada via CommandLine, se genera error */
//	f = fopen(argv[1], "r"); /* Se intenta abrir el archivo ingresado */
//	if(!f) return -1; /* Si no existe o no puede ser abierto, se genera un error */
//	yyin = f;
//	yyparse();
//	fclose(f);
return 0;
}
