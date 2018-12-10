#ifndef TABLASTIPOS_H
#define TABLASTIPOS_H

#define MAXSYM 1000
#define MAXTYP 50
#define MAXTAB 50

struct _symbol{
	int pos;
	char id[100];
	int tipo;
	int dir;
	char var[20];
	char args[100];
	int numArgs;
};

typedef struct _symbol symbol;

struct _tabla_simbolos{
	symbol symbols[MAXSYM];
	int count;
};

typedef struct _tabla_simbolos tabla_simb;

struct pila_simb{
	tabla_simb tablas[MAXTAB];
	int sp;
};

typedef struct pila_simb pila_simbolos;

pila_simbolos PilaSimbolos;

struct __type{
	int pos;
	char tipo[50];
	int tam;
	int dim;
	int base;
};
typedef struct __type _tipo;

struct _tabla_tipos{
	_tipo types[MAXTYP];
	int count;
};

typedef struct _tabla_tipos tabla_tipo;

typedef struct _type_stack{
	tabla_tipo tablas[MAXTAB];
	int sp;
} pila_tipos;

pila_tipos PilaTipos;

void iniciar();
int insertar_simbolo(symbol sym, int table);    
int buscar_simbolo(char *id, int table);
int get_type(char *id, int table);
void imprimir_simbolos(int table, char* name);
void crear_tabla_simbolos();
void borrar_tabla_simbolos();
void crear_tabla_tipos();
int insertar_tipo(_tipo t);
void borrar_tabla_tipos();
void imprimir_tipos(int table);

#endif /* TABLASTIPOS_H */
