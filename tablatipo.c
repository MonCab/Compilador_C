#include<stdio.h>
#include<string.h>
#include<stdlib.h>
typedef struct NodoA{
	char tipo[100];
	struct NodoA *next;
}TipoArgs;
typedef TipoArgs *ANodo;
typedef TipoArgs *ALista;
typedef struct NodoS{
	int pos;
	char id[100];
	int tipo;
	int dir;
	char var[20];
	ALista *args;
	struct NodoS *next;
}TipoSimbol;
typedef TipoSimbol *SNodo;
typedef TipoSimbol *SLista;
typedef struct NodoT{
	int pos;
	char tipo[50];
	int tam;
	int dim;
	int tipoBase;
	struct NodoT *next;
}TipoTipo;
typedef TipoTipo *TNodo;
typedef TipoTipo *TLista;
int getLastType(TLista Lista);
void iniciarTipos(TLista *Lista);
void mostrar(TLista Lista);
void insertArg(ALista *Lista,char *arg);
void insertSimbol(SLista *Lista,int pos,char *id,int tipo,int dir,char *var,ALista *args);
void insertTipo(TLista *Lista,int pos,char *tipo,int tam, int dim, int tipoBase);
int main(){
	SLista simbolos=NULL;
	TLista tipos=NULL;
	ALista args=NULL;
	iniciarTipos(&tipos);

	mostrar(tipos);
	
	return 0;
}
void iniciarTipos(TLista *Lista){
	insertTipo(Lista,(getLastType(*Lista)+1),"char",1,-1,-1);
	insertTipo(Lista,(getLastType(*Lista)+1),"int",4,-1,-1);
	insertTipo(Lista,(getLastType(*Lista)+1),"float",4,-1,-1);
	insertTipo(Lista,(getLastType(*Lista)+1),"double",8,-1,-1);
}
int getLastType(TLista Lista){
	if(Lista==NULL){
		return -1;
	}else{
		TNodo nodo=Lista,anterior;
		do{
			anterior=nodo;
			nodo=nodo->next;		
		}while(nodo);
		return anterior->pos;
	}

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

void insertSimbol(SLista *Lista,int pos,char *id,int tipo,int dir,char *var,ALista *args){
	SNodo nuevo,anterior;
	nuevo=(SNodo)malloc(sizeof(TipoSimbol));
	nuevo->pos=pos;
	strcpy(nuevo->id,id);
	nuevo->tipo=tipo;
	nuevo->dir=dir;
	strcpy(nuevo->var,var);
	nuevo->args=args;
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
void insertTipo(TLista *Lista,int pos,char *tipo,int tam, int dim, int tipoBase){
	TNodo nuevo,anterior;
	nuevo=(TNodo)malloc(sizeof(TipoTipo));
	nuevo->pos=pos;
	strcpy(nuevo->tipo,tipo);
	nuevo->tam=tam;
	nuevo->dim=dim;
	nuevo->tipoBase=tipoBase;
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
void mostrar(TLista Lista){
	if(Lista==NULL){
		printf("!cola vacia!\n");
	}else{
		TNodo nodo=Lista;
		printf("Elementos de la lista:\n");
		do{
			printf("%d , %s \n",nodo->pos,nodo->tipo);
			nodo=nodo->next;
		}while(nodo);
		printf("\n");
	}
}
