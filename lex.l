/*									Analizador léxico 						*/
/*										Proyecto Final							*/
/*			Caballero Montaño Montserrat & De La Cruz Flores Hugo Alberto   	*/
/*			   Arenas OLguín José Gerardo & Cortés Reyes Tanya Cecilia      	*/

/* Seccion de declaraciones */
%{ 
	#include <stdio.h>
	#include <stdlib.h>
	#include <stdbool.h>
	#include "stack.h"
	#include "y.tab.h" /* Biblioteca con el valor de nuestros terminales */
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
[\t]								{}
[\r]								{yycolumn = 1;}
[\b]								{yycolumn -= 1;}
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
true								{return TRUE;}
false								{return FALSE;}

	/* SIGNOS PUNTUACION */

\,									{return COMA;}
\;									{return PYCOMA;}
\:									{return DP;}
\.									{return PUNTO;}

	/* OPERADORES */

\=							{return ASIGNACION;}
\+							{return MAS;}
\-							{return MENOS;}
\*							{return MUL;}	
\/							{return DIV;}
\%							{return MODULO;}
"||"						{return OR;}
"&&"						{return AND;}
"!"							{return NOT;}
"<"							{return MENORQUE;}
">"							{return MAYORQUE;}
">="						{return MAYORIGUAL;}
"<="						{return MENORIGUAL;}
"!="						{return DIFERENTEQUE;}
"=="						{return IGUAL;}


	/* CONSTANTES */
([a-zA-Z]|"_")([a-zA-Z0-9]|"_")*	{strcpy(yylval.id, yytext);
										return ID;}
-?[0-9]+							{strcpy(yylval.num.val, yytext);
										yylval.num.type = 1;
										return NUM;}
-?[0-9]*"."[0-9]+[fF]				{strcpy(yylval.num.val, yytext);
										yylval.num.type = 2;
										return NUM;}
-?[0-9]*"."[0-9]					{strcpy(yylval.num.val, yytext);
										yylval.num.type = 3;
										return NUM;}					
\'.\'								{return CHAR;}
\".+\"								{return CADE;}
.									{printf("\n\tError léxico en la línea %d, columna %d,  causado por : %s \n", yylineno,yycolumn,yytext);}							
<<EOF>>								{exit(1);}

%% 

int yywrap(){return 1;} /*Solo se aceptará un archivo de entrada */
