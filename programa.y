%{
 /*archivo programa.y*/
 #include<stdio.h>
%}
%token ENT FLO DOB CARA VAC ESTR PARI 
%token ID NUM FUNC COMA TR FL IG
%token PYCOMA SI SINO MIEN HACER PARA 
%token RET SWI BREA PRIN CASE DEF DP 
%token PUNTO CADE CHAR OPERL TRUE FALSE 
%token OPERR
%left MAS
%left MENOS
%left MUL
%left DIV
%left POR
%left MEN
%left MAY
%left MENIG
%left MAYIG
%left DIF
%left IGUAL
%nonassoc PARI PARD LLAI LLAD CORI CORD
%start programa 

%%
/*1.-programa -> declaraciones funciones*/
programa: declaraciones funciones;

/*2.-declaraciones-> tipo lista; | epsilon*/
declaraciones: tipo lista PYCOMA | ;

/*3.-tipo-> int|float|double|char|void|struct{declaraciones}*/
tipo: ENT|FLO|DOB|CARA|VAC|ESTR LLAI declaraciones LLAD;

/*4.-lista-> lista, id arreglo | id arreglo*/
lista: lista COMA ID arreglo | ID arreglo;

/*5.-arreglo->[numero] arreglo | epsilon*/
arreglo: CORI NUM CORD arreglo | ;

/*6.-funciones-> func tipo id(argumentos){declaraciones sentencia} funciones|epsilon*/
funciones: FUNC tipo ID PARI argumentos PARD LLAI declaraciones sentencia LLAD funciones | ;

/*7.-argumentos->lista_argumentos|epsilon*/
argumentos: lista_argumentos | ;

/*8.-lista_argumentos->lista_argumentos,tipo id parte_arreglo | tipo id parte_arreglo*/
lista_argumentos: lista_argumentos, tipo ID parte_arreglo | tipo ID parte_arreglo;

/*9.-parte_arreglo->[]parte_arreglo|epsilon*/
parte_arreglo: CORI CORD parte_arreglo| ;

/*10.-sentencia->sentencia sentencia | if(condicion) sentencia | if (condicion) sentencia else sentencia | while(condicion) sentencia | do sentencia while(condicion); | for(sentencia;condicion;sentencia) sentencia | parte_izquierda=expresion; | return expresion; | return; | {sentencia} | switch(expresion){casos predeterminado}| break;| print expresion; */
sentencia: sentencia sentencia | SI PARI condicion PARD sentencia | SI PARI condicion PARD sentencia SINO sentencia | MIEN PARI condicion PARD sentencia | HACER sentencia MIEN PARI condicion PARD PYCOMA | PARA PARI sentencia PYCOMA sentencia PYCOMA sentencia PARD sentencia | parte_izquierda IG expresion PYCOMA | RET expresion PYCOMA | RET PYCOMA | LLAI expresion LLAD | SWI PARI expresion PARD LLAI casos predeterminado LLAD | BREA PYCOMA | PRIN expresion PYCOMA ;

/*11.-casos->case: numero sentencia predeterminado | epsilon */
casos: CASE NUM sentencia predeterminado | ;

/*12-predeterminado->default: sentencia| epsilon*/
predeterminado: default DP sentencia | ;

/*13.-parte_izquierda->id|var_arreglo|id.id*/
parte_izquierda: ID | var_arreglo | ID PUNTO ID;

/*14.-var_arreglo->id[expresion]|var_arreglo[expresion] */
var_arreglo: ID CORI expresion CORD | var_arreglo CORI expresion CORD;

/*15.-expresion->expresion + expresion|expresion - expresion| expresion * expresion| expresion / expresion| expresion % expresion | var_arreglo |cadenas | numero | caracter| id(parametros)*/
expresion: expresion MAS expresion| expresion MENOS expresion | expresion MUL expresion | expresion DIV expresion | expresion POR expresion | var_arreglo | CADE | NUM | CHAR | ID PARI parametros PARD;
/*16.-parametros->epsilon|lista_param*/
parametros: | lista_param;

/*17.-lista_param->lista_param,expresion|expresion*/
lista_param: lista_param COMA expresion | expresion;

/*18.-condicion-> condicion || condicion | condicion && condicion | !condicion | (condicion) | expresion relacional expresion
| true | false*/
condicion: condicion OR condicion | condicion AND condicion | NOT condicion | PARI condicion PARD | expresion relacional expresion | TR | FL ;

/*19.-relacional-> <|>|<=|>=|!=|==*/
relacional: MEN | MAY | MENIG | MAYIG | DIF | IGUAL;

%%
