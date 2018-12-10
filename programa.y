%{
 /*archivo programa.y*/
 #include"tablasTipos.h"
 #include"attributes.h"
 #include <stdbool.h>
 #include<stdio.h>
 #include<string.h>
 #include<stdlib.h>


 extern int yylex();
 extern int yylineno;
 extern char *yytext;
 //void yyerror(char *);

//simbolo que va entrar a la tabla de simbolos
symbol simbolo_control;

/* Funciones para el manejo de errores */
void yyerror(char *);

// variables de conteo y tipos
int dim=0, tipo=0;
int dir = 0;
int tipo_func;

//funciones para la insercion en tablas
void insert(char *id, int dir, int tipo, char*var,int args[], int num);
struct _dir_stack{
    int dir[20];
    int count;
};

typedef struct _dir_stack  dir_stack;

dir_stack dirStack;

exp suma(exp e1, exp e2);
exp resta(exp e1, exp e2);
exp multiplicacion(exp e1, exp e2);
exp division(exp e1, exp e2);
exp mod(exp e1,exp e2);
exp get_numero(numero);
int max(int t1, int t2);

%}

%union{
	numero num;	
	char id[32];
	exp expresion;
	type tipo;
        struct{
        int args[30];
        int count;
        }lista_argumentos;
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
%type<tipo> tipo arreglo
%type<lista_argumentos> argumentos lista_argumentos

%start programa
%%
programa: {	iniciar();
		dirStack.count = 0;
		crear_tabla_simbolos();
		crear_tabla_tipos();
		} declaraciones funciones;

declaraciones: tipo {tipo=$1.type;dim=$1.dim;} lista PYC declaraciones 
		| ;
tipo:	 ENT {$$.type = 2; $$.dim = 4;}
	|FLO {$$.type =3; $$.dim = 4;}
	|DOB {$$.type= 4; $$.dim = 8;}
	|CARA {$$.type= 1; $$.dim =1 ;}
	|VAC {$$.type= 0; $$.dim = 0;};

lista:	lista COMA ID arreglo{  insert($3, dir, tipo, "var", NULL, -1);
				dir = dir + dim;
				}
	|ID arreglo{  insert($1, dir, tipo, "var", NULL, -1);
				dir = dir + dim;
				};

arreglo: CORI NUM CORD arreglo { _tipo t;
				if($2.type==2){
					strcpy(t.tipo,"array");
					t.base=$4.type;
					t.tam=atoi($2.val);
					t.dim=$4.dim;
					$$.type=insertar_tipo(t);
					$$.dim=$4.dim*atoi($2.val);
				}else{
           				yyerror("La dimensión debe de ser un valor entero");
        			}
				} | {	$$.type=tipo;
					$$.dim=dim;
					};

funciones: FUNC tipo ID PARI{
		tipo_func=$2.type;
		crear_tabla_simbolos();
		crear_tabla_tipos();
		dirStack.count++;
		dirStack.dir[dirStack.count] = dir;
		dir = 0;		
	}argumentos PARD LLAI declaraciones sentencias LLAD{
		borrar_tabla_simbolos();
		borrar_tabla_tipos();
		dir = dirStack.dir[dirStack.count];
       		dirStack.count--;    
		insert($3, -1 , tipo_func, "func", $6.args, $6.count); 
	}funciones
	  | ;

argumentos: lista_argumentos{
			$$ = $1;
		}
		|{
			$$.count=-1;
		};

lista_argumentos: lista_argumentos COMA tipo ID parte_arreglo {
				       insert($4, dir, $3.type, "arg", NULL, -1); 
				       dir = dir + $3.dim;
				       $1.count++;
				       $1.args[$1.count] = $3.type;
				       $$ = $1;
		}
		  |tipo ID parte_arreglo{    
				       insert($2, dir, $1.type, "arg", NULL, -1); 
				       dir = dir + $1.dim;
				       $$.count= 0;
				       $$.args[$$.count] = $1.type;
		}; ;

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

casos: CASE NUM DP sentencias casos
	| ;

predeterminado: DEF DP sentencias
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
		|IGUAL; 
%%
void yyerror(char *s){
    printf("%s: en la línea %d\n",s, yylineno);
}
void insert(char *id, int dir, int tipo, char*var,int args[], int num){    
    int i;
    strcpy(simbolo_control.id, id);
    simbolo_control.dir = dir;
    simbolo_control.tipo = tipo;
    strcpy(simbolo_control.var,var);
    if(num != -1){
       for(i=0 ; i<num+1; i++){
           simbolo_control.args[i]=args[i];
        }
    }
    simbolo_control.numArgs = num;
    if(insertar_simbolo(simbolo_control, PilaSimbolos.sp)==0)
	yyerror("Id duplicado\n");
}

