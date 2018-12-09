#include"tablasTipos.h"
#include<stdio.h>
#include<string.h>
#include<stdlib.h>


int ExisteS(SLista Lista,char *id){
	if(Lista==NULL){
		return 0;
	}else{
		SNodo nodo=Lista;
		do{	
			if(strcmp(nodo->id,id)==0)
				return -1;
			else
				nodo=nodo->next;

		}while(nodo);
		return 0;
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
int Correct_Type(int tipo1, int tipo2){
	if(tipo1==tipo2)
		return 0;
	else
		return -1;

}

void iniciarTipos(TLista *Lista){
	insertTipo(Lista,(getLastType(*Lista)+1),"void",0,0,NULL);
	insertTipo(Lista,(getLastType(*Lista)+1),"char",1,1,NULL);
	insertTipo(Lista,(getLastType(*Lista)+1),"int",4,1,NULL);
	insertTipo(Lista,(getLastType(*Lista)+1),"float",4,1,NULL);
	insertTipo(Lista,(getLastType(*Lista)+1),"double",8,1,NULL);
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

int getTam(TLista Lista,int tipo){
	if(Lista==NULL){
		printf("Error, tabla Vacia\n");
		return -1;
	}else{
		TNodo nodo=Lista;
		do{
			if(nodo->pos==tipo)
				return nodo->tam*nodo->dim;
			nodo=nodo->next;
		}while(nodo);
	}
	return 0;	
}
TNodo getBase(TLista Lista,int tipo){
	if(Lista==NULL){
		printf("Error, tabla Vacia\n");
		return NULL;
	}else{
		TNodo nodo=Lista;
		do{
			if(nodo->pos==tipo)
				return nodo;
			nodo=nodo->next;
		}while(nodo);
	}
	return 0;
}
int Correct_Type(int tipo1, int tipo2);
void Crear_tablaS(SLista *listaS){
	*listaS=NULL;
}
void Crear_tablaT(TLista *listaT){
	*listaT=NULL;
	iniciarTipos(listaT);
}
void Crear_tablaA(ALista *listaA){
	*listaA=NULL;
}


