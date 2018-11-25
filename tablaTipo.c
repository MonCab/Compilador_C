#include<stdio.h>
#include<string.h>
#include<stdlib.h>
typedef struct NodoA{
	char tipo[100];
	struct NodoA *next;
}TipoArgs;
typedef TipoArgs *ANodo;
typedef TipoArgs *ALista;
typedef struct NodoL{
	int pos;
	char id[100];
	int tipo;
	int dir;
	char var[20];
	ALista args;
	struct NodoL *next;
}TipoNodoL;
typedef TipoNodoL *TNodo;
typedef TipoNodoL *TLista;
void insertArg(ALista *Lista,char *arg);

int main(){
	
	return 0;
}
void insertArg(ALista *Lista,char *arg){
	ANodo nuevo,anterior;
	nuevo=(ANodo)malloc(sizeof(TipoArgs));
	strcpy(nuevo->tipo,arg);
	if(*Lista==NULL){		
		nuevo->next=*Lista;
		*Lista=nuevo;
	}else{
		anterior=*Lista;	
		while(anterior->next) anterior=anterior->next;
		nuevo->next=anterior->next;
		anterior->next=nuevo;	
	}
}
