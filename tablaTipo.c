#include<stdio.h>
#include<stdlib.h>
typedef struct NodoL{
	char tipo[100];
	struct Nodo *next;
}TipoArgs;
typedef TipoArgs *ANodo;
typedef TipoArgs *ALista;
typedef struct Nodo{
	int pos;
	char id[100];
	int tipo;
	int dir;
	char var[20];
	Lista args;
}TipoNodoL;
typedef TipoNodoL *TNodo;
typedef TipoNodoL *TLista;
void insertArg(Lista *lista,char *arg);

int main(){
	
	return 0;
}
