%{
 /*archivo programa.y*/
 #include <stdbool.h>
 #include<stdio.h>
 #include "tablasTipos.h"
 #include "attributes.h"
 extern int yylex();
 extern int yylineno;
 extern char *yytext;
 void yyerror(char *);

/* Variable para la tabla de símbolos*/
 SLista tabla_de_simbolos;

/* Variable para el conteo de direcciones */
int dir=0;

/* Variables para guardar el tipo y ancho actual */
int current_type;
int current_dim;

/* Funciones auxiliares al análisis semántico y generación de código intermedio */
void init();



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
%token  FUNC COMA  PYCOMA SI SINO MIEN HACER PARA 
%token RET SWI BREA PRIN CASE DEF DP PUNTO CADE
%token CHAR  TRUE FALSE  
%right ASIGNACION
%left OR
%left AND
%left IGUAL DIFERENTEQUE
%left MAYORQUE  MENORQUE MAYORIGUAL MENORIGUAL
%left MAS MENOS
%left MUL DIV MODULO
%right NOT
%left PARI PARD 
%nonassoc LLAI LLAD CORI CORD
%left SI
%left SINO



%type<tipo> tipo
%type<booleanos> cond
%type<siguientes> sent O
%type<expresion> exp
%type<rel> relacional




%start prog 
%%
/*1.-programa -> declaraciones funciones*/
prog:	{init();}	decl	{mostrarSimbolos(tabla_de_simbolos);}	func ;

/*2.-declaraciones-> tipo lista; | epsilon*/
decl: tipo {current_type = $1.type; current_dim = $1.dim;} lista PYCOMA | ;

/*3.-tipo-> int|float|double|char|void|struct{declaraciones}*/
tipo: ENT {$$.type=1; $$.dim=4;} | FLO {$$.type=2; $$.dim=4;}| DOB{$$.type=3; $$.dim=8;} | CARA{$$.type=0; $$.dim=1;} | VAC | ESTR LLAI decl LLAD ;

/*4.-lista-> lista, id arreglo | id arreglo*/
lista: lista COMA ID {insertSimbol(tabla_de_simbolos,(getLastSymbol(&Lista)+1));} arreglo | ID arreglo;

/*5.-arreglo->[numero] arreglo | epsilon*/
arreglo: CORI NUM CORD arreglo | ;

/*6.-funciones-> func tipo id(argumentos){declaraciones sentencia} funciones|epsilon*/
func: FUNC tipo ID PARI args PARD LLAI decl sent LLAD func | ;

/*7.-argumentos->lista_argumentos|epsilon*/
args: lista_args | ;

/*8.-lista_argumentos->lista_argumentos,tipo id parte_arreglo | tipo id parte_arreglo*/
lista_args: lista_args COMA tipo ID parte_arreglo | tipo ID parte_arreglo;

/*9.-parte_arreglo->[]parte_arreglo|epsilon*/
parte_arreglo: CORI CORD parte_arreglo| ;

/*10.-sentencia->sentencia sentencia | if(condicion) sentencia | if (condicion) sentencia else sentencia |
while(condicion) sentencia | do sentencia while(condicion); | for(sentencia;condicion;sentencia) sentencia |
parte_izquierda=expresion; | return expresion; | return; | {sentencia} | switch(expresion){casos predeterminado}
| break;| print expresion; */

sent: sent sent | SI PARI cond PARD sent | SI PARI cond PARD sent SINO sent | MIEN PARI cond PARD sent 
| HACER sent MIEN PARI cond PARD PYCOMA | PARA PARI sent PYCOMA cond PYCOMA sent PARD sent | parte_iz ASIGNACION exp PYCOMA 
| RET exp PYCOMA | RET PYCOMA | LLAI exp LLAD | SWI PARI exp PARD LLAI casos pred LLAD | BREA PYCOMA | PRIN exp PYCOMA ;

/*11.-casos->case: numero sentencia predeterminado | epsilon */
casos: CASE DP NUM sent pred | ;

/*12-predeterminado->default: sentencia| epsilon*/
pred: DEF DP sent | ;

/*13.-parte_izquierda->id|var_arreglo|id.id*/
parte_iz: ID | var_arreglo | ID PUNTO ID;

/*14.-var_arreglo->id[expresion]|var_arreglo[expresion] */
var_arreglo: ID CORI exp CORD | var_arreglo CORI exp CORD;

/*15.-expresion->expresion + expresion|expresion - expresion| expresion * expresion| expresion / expresion
| expresion % expresion | var_arreglo |cadenas | numero | caracter| id(parametros)*/
exp: exp MAS exp | exp MENOS exp | exp MUL exp | exp DIV exp | exp MODULO exp | var_arreglo | CADE | NUM | CHAR | ID PARI param PARD;

/*16.-parametros->epsilon|lista_param*/
param: lista_param | ;

/*17.-lista_param->lista_param,expresion|expresion*/
lista_param: lista_param COMA exp | exp;

/*18.-condicion-> condicion || condicion | condicion && condicion | !condicion | (condicion) | expresion relacional expresion
| true | false*/
cond: cond OR cond | cond AND cond | NOT cond | PARI cond PARD | exp relacional exp | TRUE | FALSE ;

/*19.-relacional-> <|>|<=|>=|!=|==*/
relacional: MAYORQUE | MENORQUE | MAYORIGUAL | MENORIGUAL| DIFERENTEQUE | IGUAL ;
%%
void init(){    
    Crear_tablaS(&tabla_de_simbolos);  
}
void yyerror(char *s){
	printf ("\n\tError sintactico en la linea : %d \n\tProvocado después de: %s \n " ,yylineno, yytext);
	} 