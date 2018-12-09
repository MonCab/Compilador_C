%{
 /*archivo programa.y*/
 #include <stdbool.h>
 #include<stdio.h>
 #include<stdlib.h>
 #include"attributes.h"
 #include"symtab.h"
 extern int yylex();
 extern int yylineno;
 extern char *yytext;
 void yyerror(char *);
%}

%union{
	numero num;	
	char id[32];
	exp expresion;
	type tipo;
	struct{
	labels falses;
	labels trues;
	}booleanos;
	labels siguientes;
	struct{
	labels siguientes;
	bool ifelse;
	}siguientesp;
	int rel;
}
%token<id> ID
%token<num> NUM
%token ENT FLO DOB CARA VAC ESTR
%token FUNC  PYC MIEN HACER PARA 
%token RET SWI BREA PRIN CASE DEF DP PUNTO CADE
%token CHAR TRUE FALSE  
%right ASIGNACION
%left COMA
%left OR
%left AND
%left IGUAL DIFERENTEQUE
%left MAYORQUE MENORQUE MAYORIGUAL MENORIGUAL
%left MAS MENOS
%left MUL DIV MODULO
%right NOT
%left PARI PARD CORI CORD
%nonassoc LLAI LLAD 
%left SI
%left SINO
%%
programa: declaraciones funciones;
declaraciones: tipo lista PYC declaraciones 
		| ;
tipo:	 ENT
	|FLO
	|DOB
	|CARA
	|VAC
	|ESTR LLAI declaraciones LLAD ;

lista:	lista COMA ID arreglo 
	|ID arreglo;

arreglo: CORI NUM CORD arreglo 
	 | ;

funciones: FUNC tipo ID PARI argumentos PARD LLAI declaraciones sentencias LLAD funciones
	  | ;

argumentos: lista_argumentos
		|;

lista_argumentos: lista_argumentos COMA tipo ID parte_arreglo 
		  |tipo ID parte_arreglo ;

parte_arreglo: CORI CORD parte_arreglo
		| ;

sentencias: sentencias sentencia
		|sentencia;

sentencia:  
	SI PARI condicion PARD sentencia
	|SI PARI condicion PARD sentencia SINO sentencia 
	|MIEN PARI condicion PARD sentencia
	|HACER sentencia MIEN PARI condicion PARD PYC
	|PARA PARI sentencia PYC condicion PYC sentencia PARD sentencia
	|parte_izquierda ASIGNACION expresion PYC
	|RET expresion PYC
	|RET PYC
	|LLAI sentencia LLAD
	|SWI PARI expresion PARD LLAI casos predeterminado LLAD
	|BREA PYC
	|PRIN expresion PYC ;

casos: CASE DP NUM sentencia predeterminado
	| ;

predeterminado: DEF DP sentencia
		| ;

parte_izquierda: ID
		|var_arreglo
		|ID PUNTO ID ;

var_arreglo: ID CORI expresion CORD 
		|var_arreglo CORI expresion CORD;

expresion: expresion MAS expresion
		|expresion MENOS expresion
		|expresion MUL expresion
		|expresion DIV expresion
		|expresion MODULO expresion
		|var_arreglo
		|CADE
		|NUM
		|CHAR
		|ID PARI parametro PARD ;

parametro: 
		|lista_param;

lista_param: lista_param COMA expresion
		|expresion ;

condicion: condicion OR condicion
		|condicion AND condicion
		|NOT condicion
		|PARI condicion PARD
		|expresion relacional expresion
		|TRUE
		|FALSE;

relacional: MAYORQUE
		|MENORQUE
		|MAYORIGUAL
		|MENORIGUAL
		|DIFERENTEQUE
		|IGUAL ; 
%%
