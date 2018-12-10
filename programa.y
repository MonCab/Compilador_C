%{
 /*archivo programa.y*/
 #include"tablasTipos.h"
 #include"stack.h"
 #include "backpatch.h"
 #include"codigo_inter.h"
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

// Variables para las etiquetas, indices y temporales
int temp = 0;
int label = 0;
int indice = 0;

/* Variable para el unico atributo heredado de sentencia prima*/
Stack *lfalses;

/* Variable papra guardar el código intermedio que se va generando */
ic codigo_intermedio;

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

int max(int t1, int t2);
char *ampliar(char *dir, int t1, int t2);
char *reducir(char *dir, int t1, int t2);

char *newTemp();
char *newLabel();
char *newIndex();



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
		Stack *falses;
		Stack *trues;
	}booleanos;
	Stack *siguientes;
	struct{
		Stack *siguientes;
		bool ifelse;
	}siguientesp;
	int rel;
}
%token<id> ID
%token<num> NUM
%token ENT FLO DOB CARA VAC ESTR
%token FUNC COMA PYC MIEN HACER PARA 
%token RET SWI BREA PRIN CASE DEF DP PUNTO CADE
%token CHAR TRUE FALSE  
%right ASIGNACION
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
%type<booleanos> condicion;
%type<siguientes> sentencia sentencias
%type<lista_argumentos> argumentos lista_argumentos
%type<expresion> expresion
%type<rel> relacional

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

sentencias: sentencias {
				cuadrupla c;
                c.op = LB;
                strcpy(c.op1, "");
                strcpy(c.op2, "");
                strcpy(c.res, get_first($1));
                insert_cuad(&codigo_intermedio, c);
			} 
			sentencia{
				char label[32];
                strcpy(label,newLabel());                                
                $$ = $3;                
                backpatch($1, label, &codigo_intermedio);
			}
		|sentencia{
			char label[32];
            strcpy(label, newLabel());
            $$ = $1;
            backpatch($1, label, &codigo_intermedio);
		};

sentencia:  
	SI PARI condicion PARD {
		cuadrupla c;
        c.op = LB;
        strcpy(c.op1, "");
        strcpy(c.op2, "");
        strcpy(c.res, get_first($3.trues));
        insert_cuad(&codigo_intermedio, c);
	} sentencia {cuadrupla c, c1;
                    c.op = GOTO;
                    strcpy(c.op1, "");
                    strcpy(c.op2, "");
                    strcpy(c.res, get_first($6));
                    push(lfalses, get_first($3.falses));
                    insert_cuad(&codigo_intermedio, c);}
	|SI PARI condicion PARD sentencia SINO sentencia 
	|MIEN PARI condicion PARD sentencia {
                char label[32], label2[32], temp[32];
                strcpy(label, newIndex());                
                strcpy(label2, newIndex());         
                strcpy(temp, newTemp());
                $$ = $3.falses;
                cuadrupla c1;
                c1.op = SI;
                strcpy(c1.op1, temp);
                strcpy(c1.op2, "GOTO");
                strcpy(c1.res, label);                
                insert_cuad(&codigo_intermedio, c1);
                backpatch($3.trues, label, &codigo_intermedio);
                backpatch($3.falses, label2, &codigo_intermedio);
     }
	|LLAI sentencia LLAD {
                char label[32];
                $$ = $2;                
                strcpy(label, newLabel());                
                backpatch($2, label, &codigo_intermedio);                                
                printf("S->{SS}\n");
    }
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

expresion: expresion MAS expresion {$$ =suma($1, $3);}
		|expresion MENOS expresion {$$ =resta($1, $3);}
		|expresion MUL expresion {$$ =multiplicacion($1, $3);}
		|expresion DIV expresion {$$ =division($1, $3);}
		|expresion MODULO expresion 
		|var_arreglo 
		|CADE
		|NUM {$$ = get_numero($1);}
		|CHAR
		|ID PARI parametro PARD ;
parametro: 
		|lista_param;

lista_param: lista_param COMA expresion
		|expresion ; 

condicion: condicion OR {
                    cuadrupla c;
                    c.op = LB;
                    strcpy(c.op1, "");
                    strcpy(c.op2, "");
                    strcpy(c.res, get_first($1.falses));
                    insert_cuad(&codigo_intermedio, c);                    
                    
        } condicion { 
                char label[32];
                strcpy(label, newLabel());
                backpatch($1.falses, label, &codigo_intermedio);
                $$.trues = merge($1.trues, $4.trues);
                $$.falses = $4.falses;
         }
		|condicion AND {
                    cuadrupla c;
                    c.op = LB;
                    strcpy(c.op1, "");
                    strcpy(c.op2, "");
                    strcpy(c.res, get_first($1.trues));
                    insert_cuad(&codigo_intermedio, c);
        } condicion {
                char label[32];
                strcpy(label, newLabel());                        
                $$.falses = merge($1.falses, $4.falses);
                $$.trues = $4.trues;
                backpatch($1.trues, label, &codigo_intermedio);
         }
		|NOT condicion {
            $$.falses = $2.trues;
            $$.trues = $2.falses;
	    }
		|PARI condicion PARD {
            $$.trues = $2.trues;
            $$.falses = $2.falses;
            printf("B->(B)\n");
	    }
		|expresion relacional expresion {
            char i[32];
            char i2[32];
            char temp[32];
            strcpy(i, newIndex());
            strcpy(i2, newIndex());
            strcpy(temp, newTemp());
            $$.trues = create_list(i);
            $$.falses = create_list(i2);
            cuadrupla c, c1, c2;
            c.op = $2 ;
            strcpy(c.op1, $1.dir);
            strcpy(c.op2, $3.dir);
            strcpy(c.res, temp);            
            
            c1.op = IFF;
            strcpy(c1.op1, temp);
            strcpy(c1.op2, "GOTO");
            strcpy(c1.res, i);            
            
            c2.op = GOTO;
            strcpy(c2.op1, "");
            strcpy(c2.op2, "");
            strcpy(c2.res, i2);
            
            insert_cuad(&codigo_intermedio, c);
            insert_cuad(&codigo_intermedio, c1);
            insert_cuad(&codigo_intermedio, c2);
	   }
		|TRUE {
            char i[32];
            strcpy(i, newIndex());
            $$.trues = create_list(i);
            cuadrupla c;
            c.op = GOTO;
            strcpy(c.op1, "");
            strcpy(c.op2, "");
            strcpy(c.res, i);
            insert_cuad(&codigo_intermedio, c);
	   }
		|FALSE {
            char i[32];
            strcpy(i, newIndex());
            $$.falses = create_list(i);
            cuadrupla c;
            c.op = GOTO;
            strcpy(c.op1, "");
            strcpy(c.op2, "");
            strcpy(c.res, i);
            insert_cuad(&codigo_intermedio, c);
	   };

relacional: MAYORQUE {$$= GT;}
		|MENORQUE {$$= LT;}
		|MAYORIGUAL {$$= GE;}
		|MENORIGUAL {$$= LE;}
		|DIFERENTEQUE {$$= NE;}
		|IGUAL {$$= EQ;};
%%
void yyerror(char * s){
	printf("\n\nError sintactico en la linea : %d \nProvocado alrededor de : %s " , yylineno, yytext);
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

exp suma(exp e1, exp e2){
    exp e;
    cuadrupla c;
    e.type = max(e1.type, e2.type);
    if( e.type==-1) yyerror("Error de tipos");
    else{
        char t[32];
        strcpy(t,newTemp());
        strcpy(e.dir, t);
        c.op = MA;
        strcpy(c.op1, ampliar(e1.dir, e1.type, e.type));
        strcpy(c.op2, ampliar(e2.dir, e2.type, e.type));
        strcpy(c.res, t);
        insert_cuad(&codigo_intermedio, c);
    }
    return e;    
}

exp resta(exp e1, exp e2){
    exp e;
    cuadrupla c;
    char t[32];
    e.type = max(e1.type, e2.type);
    
    if( e.type==-1) yyerror("Error de tipos");
    else{
        strcpy(t,newTemp());
        strcpy(e.dir, t);
        c.op = MEN;
        strcpy(c.op1, ampliar(e1.dir, e1.type, e.type));
        strcpy(c.op2, ampliar(e2.dir, e2.type, e.type));
        strcpy(c.res, t);
        insert_cuad(&codigo_intermedio, c);
    }
    return e;    
}

exp multiplicacion(exp e1, exp e2){
    exp e;
    cuadrupla c;
    e.type = max(e1.type, e2.type);
    if( e.type==-1) yyerror("Error de tipos");
    else{
        char t[32];
        strcpy(t,newTemp());
        strcpy(e.dir, t);
        c.op = ML;
        strcpy(c.op1, ampliar(e1.dir, e1.type, e.type));
        strcpy(c.op2, ampliar(e2.dir, e2.type, e.type));
        strcpy(c.res, t);
        insert_cuad(&codigo_intermedio, c);
    }
    return e;    
}

exp division(exp e1, exp e2){
    exp e;
    cuadrupla c;
    e.type = max(e1.type, e2.type);
    if( e.type==-1) yyerror("Error de tipos");
    else{
        char t[32];
        strcpy(t,newTemp());
        strcpy(e.dir, t);
        c.op = DV;
        strcpy(c.op1, ampliar(e1.dir, e1.type, e.type));
        strcpy(c.op2, ampliar(e2.dir, e2.type, e.type));
        strcpy(c.res, t);
        insert_cuad(&codigo_intermedio, c);
    }
    return e;    
}

exp asignacion(char *id, exp e){
    exp e1;
    int tipo = get_type(id,0);
    if( tipo != -1){        
        e1.type = e.type;
        strcpy(e1.dir, id);
        cuadrupla c;
        c.op = AS;
        strcpy(c.op1, reducir(e.dir, tipo, e.type));
        strcpy(c.op2, "");
        strcpy(c.res, id);
        insert_cuad(&codigo_intermedio, c);  
        
    }else{
        yyerror("El identificador no fue declarado\n");
    }
    return e1;
}


exp get_numero(numero n){
    exp e;
    e.type = n.type;
    strcpy(e.dir, n.val);
    return e;
}

exp identificador(char *id){
    exp e;
    if(buscar_simbolo(id,0)!=-1){
        e.type = get_type(id,0);
        strcpy(e.dir, id);
    }else{
        yyerror("Error semantico: el identificador no existe");
    }
    return e;
}


int max(int t1, int t2){
    if( t1==t2) return t1;
    if( t1 ==0 && t2 == 1) return 1;
    if( t1 ==1 && t2 == 0) return 1;    
    if( t1 ==0 && t2 == 2) return 2;
    if( t1 ==2 && t2 == 0) return 2;
    if( t1 ==2 && t2 == 1) return 2;
    if( t1 ==1 && t2 == 2) return 2;
    else return -1;
}

char *ampliar(char *dir, int t1, int t2){
    cuadrupla c;
    char *t= (char*) malloc(32*sizeof(char));
    
    if( t1==t2) return dir;
    if( t1 ==0 && t2 == 1){
        c.op = EQ;
        strcpy(c.op1, "(float)");
        strcpy(c.op2, dir);
        strcpy(t, newTemp());
        strcpy(c.res, t);
        insert_cuad(&codigo_intermedio, c);
        return t;
    }        
    if( t1 ==0 && t2 == 2){
        c.op = EQ;
        strcpy(c.op1, "(double)");
        strcpy(c.op2, dir);
        strcpy(t, newTemp());
        strcpy(c.res, t);
        insert_cuad(&codigo_intermedio, c);
        return t;
    }        
    
    if( t1 ==1 && t2 == 2) {
        c.op = EQ;
        strcpy(c.op1, "(double)");
        strcpy(c.op2, dir);
        strcpy(t, newTemp());
        strcpy(c.res, t);
        insert_cuad(&codigo_intermedio, c);
        return t;
    }   
    return NULL;         
}


char *reducir(char *dir, int t1, int t2){
    cuadrupla c;
    char *t= (char*) malloc(32*sizeof(char));
    
    if( t1==t2) return dir;
    if( t1 ==0 && t2 == 1){
        c.op = EQ;
        strcpy(c.op1, "(int)");
        strcpy(c.op2, dir);
        strcpy(t, newTemp());
        strcpy(c.res, t);
        insert_cuad(&codigo_intermedio, c);
        printf("perdida de información se esta asignando un float a un int\n");
        return t;
    }        
    if( t1 ==0 && t2 == 2){
        c.op = EQ;
        strcpy(c.op1, "(int)");
        strcpy(c.op2, dir);
        strcpy(t, newTemp());
        strcpy(c.res, t);
        insert_cuad(&codigo_intermedio, c);
        printf("perdida de información se esta asignando un double a un int\n");
        return t;
    }        
    
    if( t1 ==1 && t2 == 2) {
        c.op = EQ;
        strcpy(c.op1, "(float)");
        strcpy(c.op2, dir);
        strcpy(t, newTemp());
        strcpy(c.res, t);
        insert_cuad(&codigo_intermedio, c);
        printf("perdida de información se esta asignando un double a un float\n");
        return t;
    } 
    return NULL;           
}

char* newTemp(){
	char *temporal= (char*) malloc(32*sizeof(char));
	strcpy(temporal , "t");
	char num[30];
	sprintf(num, "%d", temp);
	strcat(temporal, num);
	temp++;
	return temporal;
}
char* newLabel(){
	char *temporal= (char*) malloc(32*sizeof(char));
	strcpy(temporal , "L");
	char num[30];
	sprintf(num, "%d", label);
	strcat(temporal, num);
	label++;
	return temporal;
}
char* newIndex(){
	char *temporal= (char*) malloc(32*sizeof(char));
	strcpy(temporal , "I");
	char num[30];
	sprintf(num, "%d", indice);
	strcat(temporal, num);
	indice++;
	return temporal;
}