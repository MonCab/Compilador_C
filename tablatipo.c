#include"tablasTipos.h"
#include<stdio.h>
#include<string.h>
#include<stdlib.h>


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
void insertTipo(TLista *Lista,int pos,char *tipo,int tam, int dim, TNodo tipoBase){
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

void mostrarSimbolos(SLista Lista){
	if(Lista==NULL){
		printf("!cola vacia!\n");
	}else{
		SNodo nodo=Lista;
		printf("Elementos de la lista:\n");
		do{
			printf("%d , %s \n",nodo->pos,nodo->id);
			nodo=nodo->next;
		}while(nodo);
		printf("\n");
	}
}

void mostrarTipos(TLista Lista){
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

void iniciarTipos(TLista *Lista){
	insertTipo(Lista,(getLastType(*Lista)+1),"char",1,-1,NULL);
	insertTipo(Lista,(getLastType(*Lista)+1),"int",4,-1,NULL);
	insertTipo(Lista,(getLastType(*Lista)+1),"float",4,-1,NULL);
	insertTipo(Lista,(getLastType(*Lista)+1),"double",8,-1,NULL);
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

int getLastSymbol(SLista Lista){
	if(Lista==NULL){
		return -1;
	}else{
		SNodo nodo=Lista,anterior;
		do{
			anterior=nodo;
			nodo=nodo->next;		
		}while(nodo);
		return anterior->pos;
	}
}
void Crear_tablaS(SLista *listaS){
	*listaS=NULL;
}
void Crear_tablaT(TLista *listaT){
	*listaT=NULL;
}
void Crear_tablaA(ALista *listaA){
	*listaA=NULL;
}


