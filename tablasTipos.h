#ifndef TABLASTIPOS_H
#define TABLASTIPOS_H


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
	struct NodoT *tipoBase;
	struct NodoT *next;
}TipoTipo;
typedef TipoTipo *TNodo;
typedef TipoTipo *TLista;

void Crear_tablaS(SLista *listaS);
void Crear_tablaT(TLista *listaT);
void Crear_tablaA(ALista *listaA);
int getLastType(TLista Lista);
int getLastSymbol(SLista Lista);
void iniciarTipos(TLista *Lista);
void mostrarTipos(TLista Lista);
void mostrarSimbolos(SLista Lista);
void insertArg(ALista *Lista,char *arg);
void insertSimbol(SLista *Lista,int pos,char *id,int tipo,int dir,char *var,ALista *args);
void insertTipo(TLista *Lista,int pos,char *tipo,int tam, int dim, TNodo tipoBase);
char *getName(SLista Lista, int pos);

#endif /* TABLASTIPOS_H */
