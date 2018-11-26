%{
 /*archivo programa.y*/
 #include<stdio.h>
 extern int yylex();
 extern int yylineno;
 void yyerror(char *);
%}
%token ENT FLO DOB CARA VAC ESTR
%token ID NUM FUNC  PYCOMA SI SINO MIEN HACER PARA 
%token RET SWI BREA PRIN CASE DEF DP PUNTO CADE
%token CHAR  TRUE FALSE  
%left COMA
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
%right SI
%right SINO

%start prog 
%%
/*1.-programa -> declaraciones funciones*/
prog: decl func ;

/*2.-declaraciones-> tipo lista; | epsilon*/
decl: tipo lista PYCOMA | ;

/*3.-tipo-> int|float|double|char|void|struct{declaraciones}*/
tipo: ENT | FLO | DOB | CARA | VAC | ESTR LLAI decl LLAD ;

/*4.-lista-> lista, id arreglo | id arreglo*/
lista: lista COMA ID arreglo | ID arreglo;

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

void yyerror(char *s){printf ("\n\t Error : en %d %s \n " ,yylineno, s);} 