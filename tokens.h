/*									Analizador léxico 							*/
/*										Examen 2 								*/
/*			Caballero Montaño Montserrat & De La Cruz Flores Hugo Alberto   	*/
/*			   Arenas OLguín José Gerardo & Cortés Reyes Tanya Cecilia      	*/

#ifndef TOKENS_H
#define TOKENS_H

#define ENT 1 //Tipo de dato entero
#define FLO 2 //Tipo de dato flotante
#define DOB 3 //Tipo de dato doble
#define CARA 4 //Tipo de dato caracter
#define VAC 5 //Tipo de dato void
#define ESTR 6 //Tipo de dato struct
#define PARI 7 // '('
#define PARD 8 // ')'
#define LLAI 9 // '{'
#define LLAD 10 // '}'
#define ID 11 //Identificador
#define NUM 12 //Numero
#define FUNC 13 //Palabra reservada para las funciones
#define SEPAR 14 // ','
#define TERM 15 // ';'
#define SI 16 // Palabra reservada para IF
#define SINO 17 // Palabra reservada para ELSE
#define MIEN 18 // Palabra reservada para WHILE
#define HACER 19 // Palabra reservada para DO
#define PARA 20 // Palabra reservada para FOR
#define RET 21 // Palabra reservada para RETURN
#define SWI 22 // Palabra reservada para SWITCH
#define BREA 23 // Palabra reservada para BREAK
#define PRIN 24 // Palabra reservada para PRINT
#define CASE 25 // Palabra reservada para CASE
#define DEF 26 // Palabra reservada para DEFAULT
#define DP 27 // ':'
#define PUNTO 28 // '.'
#define OPERA 29 // '+', '-', '*', '/', '%'
#define CADE 30 // Cadenas
#define CHAR 31 // Caracteres
#define OPERL 32 // '||', '&&', '!'
#define TRUE 33 // Palabra reservada para TRUE
#define FALSE 34 // Palabra reservada para FALSE
#define OPERR 35 // '<', '>', '>=', '<=', '!=', '=='

#endif