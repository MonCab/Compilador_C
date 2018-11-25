/*									Analizador léxico 						*/
/*										Proyecto Final							*/
/*			Caballero Montaño Montserrat & De La Cruz Flores Hugo Alberto   	*/
/*			   Arenas OLguín José Gerardo & Cortés Reyes Tanya Cecilia      	*/

/* Seccion de declaraciones */
%{ 
	#include <stdio.h>
	#include <stdlib.h>
	#include "tokens.h" /* Biblioteca con el valor de nuestros terminales */
	int yycolumn = 1; /* variable global para almacenar y mostrar el numero de columna */
	#define YY_USER_ACTION yycolumn += yyleng; /* Se define una macro para ejecutarse cada que se encuentra un token */
	int comment_aux = 0 ;											
%}
  /*Opcion yylineno para detectar el numero de linea en que se generan errores. */ 
%option yylineno 
%x comment 
%%
 /* Seccion de reglas gramaticales */


"/*"		{BEGIN(comment); comment_aux = yylineno;}
<comment>[^*\n]*	   /* Ignora todo lo que no sea  '*' */
<comment>[\n]	   		 /* Ignora todo lo que no sea  '*' */ 
<comment>"*"+[^*/\n]*   /* Ignora todo lo que no sea la cadena de fin de comentario  */
<comment><<EOF>>   	{printf("\n\nError Lexico, comentario sin cerrar en la linea : %d .\n\n",comment_aux );exit(-1);}
<comment>"*"+"/"	   BEGIN(INITIAL);



[ ]									{yycolumn += 1;} 
 /* Tras cada salto de linea se reinicia yycolumn */
[\n]								{yycolumn = 1;}
  /*Tipos de datos */
float 								{ return FLO;}
int									{ return ENT;}
double								{ return DOB;}
char								{ return CARA;}
void								{ return VAC;}
struct 								{ return ESTR;}

	/* PARENTESIS Y LLAVES */

\(									{return PARI;}
\)									{return PARD;}
\{									{return LLAI;}
\}									{return LLAD;}
"["									{return CORI;}
"]"									{return CORD;}

	/* PALABRAS RESERVADAS */

func								{return FUNC;}
if									{return SI;}
else								{return SINO;}
while								{return MIEN;}
do									{return HACER;}
for									{return PARA;}
return								{return RET;}
switch								{return SWI;}
break								{return BREA;}
print								{return PRIN;}
case								{return CASE;}
default								{return DEF;}
true								{return TR;}
false								{return FL;}

	/* SIGNOS PUNTUACION */

\,									{return COMA;}
\;									{return PYCOMA;}
\:									{return DP;}
\.									{return PUNTO;}

	/* OPERADORES */

\=						{return IG;}
\+						{return MAS;}
\-						{return MENOS;}
\*						{return MUL;}	
\/						{return DIV;}
\%						{return POR;}
"||"						{return OR;}
"&&"						{return AND;}
"!"						{return NOT;}
"<"						{return MEN;}
">"						{return MAY;}
">="						{return MAYIG;}
"<="						{return MENIG;}
"!="						{return DIF;}
"=="						{return IGUAL;}


	/* CONSTANTES */
([a-zA-Z]|"_")([a-zA-Z0-9]|"_")*	{return ID;}
([0-9])+(.([0-9])+)?				{return NUM;}
\'.\'								{return CHAR;}
\".+\"								{return CADE;}
.									{printf("Error léxico en la línea %d, columna %d,  causado por : %s \n", yylineno,yycolumn,yytext);}							
<<EOF>>								{exit(1);}

%% 
/* Sección de código del usuario */
/* Aquí se realiza la apertura de ambos archivos (entrada y salida) */
int main(int argc, char  **argv){
	int i,token;
	FILE *f; /* Se genera un apuntador al archivo*/
	if (argc < 2 ) return -1; /* Si no se ingresa el archivo de entrada via CommandLine, se genera error */
	f = fopen(argv[1], "r"); /* Se intenta abrir el archivo ingresado */
	if(!f) return -1; /* Si no existe o no puede ser abierto, se genera un error */
	yyin = f;
	token=yylex();
	while(token!=0){
		printf("%d\n",token);	
		token=yylex();
	}
	fclose(f);

}
int yywrap(){return 1;} /*Solo se aceptará un archivo de entrada */
