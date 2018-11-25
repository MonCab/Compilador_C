#include<stdio.h>
#include<stdlib.h>
typedef struct NodoL{
	char tipo[100];
	struct Nodo *next;
}TipoArgs;
typedef TipoArgs *pNodo;
typedef TipoArgs *Lista;
typedef struct Nodo{
	int pos;
	char id[100];
	int tipo;
	int dir;
	char var[20];
	Lista args;
}TipoNodoL;

int main(){
	
	return 0;
}
