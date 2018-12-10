#include"tablasTipos.h"
#include<stdio.h>
#include<string.h>
#include<stdlib.h>

void iniciar(){
     PilaSimbolos.sp = -1;
     PilaTipos.sp= -1;
}
int  insertar_simbolo(symbol sym, int table){    
    int cont = PilaSimbolos.tablas[table].count;
    if(buscar_simbolo(sym.id, table)==0 && PilaSimbolos.tablas[table].count<MAXSYM+1){
	sym.pos=cont;
        PilaSimbolos.tablas[table].symbols[cont] = sym;
	PilaSimbolos.tablas[table].count++;
	return 1;
    }
    return 0;
}
    
                                                                                                                                                                                                                                   
int buscar_simbolo(char *id, int table){
    int i;
    for( i= 0; i < PilaSimbolos.tablas[table].count+1; i++){
        if(strcmp(PilaSimbolos.tablas[table].symbols[i].id, id)==0){
            return 1;
        }
    }
    return 0;
}

int get_type(char *id, int table){
    int  i;
    int count = PilaSimbolos.tablas[table].count;
    //printf("buscando %s, en la tabla %d\n", id, table);
    for(i =0; i < count+1; i++){
        //printf("%s, tabla %d el id %s\n", symStack.tables[table].symbols[i].id, table,id);
        if(strcmp(PilaSimbolos.tablas[table].symbols[i].id, id)==0){
            //printf("coincide\n");
            return PilaSimbolos.tablas[table].symbols[i].tipo;
        }
    }
    return -1;
}

void imprimir_simbolos(int table, char *name){
    int i,j,k;
    printf("Tabla de Símbolos %s\n", name);
    printf("Pos\t Id\t Tipo\t Dir\t Var\tNArgs\n");
    for(i=0; i < PilaSimbolos.tablas[table].count; i++){
        printf("%d\t %s\t %d\t %d\t %s\t %d\n", 
                PilaSimbolos.tablas[table].symbols[i].pos,
		PilaSimbolos.tablas[table].symbols[i].id, 
                PilaSimbolos.tablas[table].symbols[i].tipo,
		PilaSimbolos.tablas[table].symbols[i].dir,
                PilaSimbolos.tablas[table].symbols[i].var,
		PilaSimbolos.tablas[table].symbols[i].numArgs);
    }	
}
void crear_tabla_simbolos(){
    PilaSimbolos.sp++;    
    PilaSimbolos.tablas[PilaSimbolos.sp].count = 0;    
}
void borrar_tabla_simbolos(){
    PilaSimbolos.tablas[PilaSimbolos.sp].count = 0;
    PilaSimbolos.sp--;    
}
int insertar_tipo(_tipo t){
    int sp = PilaTipos.sp;
    int cont = PilaTipos.tablas[sp].count;  
    strcpy(PilaTipos.tablas[sp].types[cont].tipo, t.tipo);
    PilaTipos.tablas[sp].types[cont].pos= cont;
    PilaTipos.tablas[sp].types[cont].dim = t.dim;
    PilaTipos.tablas[sp].types[cont].base = t.base;
    PilaTipos.tablas[sp].count++;
	return PilaTipos.tablas[sp].types[cont].pos;
}


void crear_tabla_tipos(){    
    PilaTipos.sp++;
    int sp = PilaTipos.sp;
    PilaTipos.tablas[sp].count = 0;
    
    strcpy(PilaTipos.tablas[sp].types[0].tipo, "void");
    PilaTipos.tablas[sp].types[0].pos=PilaTipos.tablas[sp].count;
    PilaTipos.tablas[sp].types[0].tam = 0;
    PilaTipos.tablas[sp].types[0].dim = 1;
    PilaTipos.tablas[sp].types[0].base = -1;
    PilaTipos.tablas[sp].count++;

    strcpy(PilaTipos.tablas[sp].types[1].tipo, "char");
    PilaTipos.tablas[sp].types[1].pos=PilaTipos.tablas[sp].count;
    PilaTipos.tablas[sp].types[1].tam = 1;
    PilaTipos.tablas[sp].types[1].dim = 1;
    PilaTipos.tablas[sp].types[1].base = -1;
    PilaTipos.tablas[sp].count++;
   
    strcpy(PilaTipos.tablas[sp].types[2].tipo, "int");
    PilaTipos.tablas[sp].types[2].pos=PilaTipos.tablas[sp].count;
    PilaTipos.tablas[sp].types[2].tam = 4;
    PilaTipos.tablas[sp].types[2].dim = 1;
    PilaTipos.tablas[sp].types[2].base = -1;
    PilaTipos.tablas[sp].count++;
    
    strcpy(PilaTipos.tablas[sp].types[3].tipo, "float");
    PilaTipos.tablas[sp].types[3].pos=PilaTipos.tablas[sp].count;
    PilaTipos.tablas[sp].types[3].tam = 4;
    PilaTipos.tablas[sp].types[3].dim = 1;
    PilaTipos.tablas[sp].types[3].base = -1;
    PilaTipos.tablas[sp].count++;
    
    strcpy(PilaTipos.tablas[sp].types[4].tipo, "double");
    PilaTipos.tablas[sp].types[4].pos=PilaTipos.tablas[sp].count;
    PilaTipos.tablas[sp].types[4].tam = 8;
    PilaTipos.tablas[sp].types[4].dim = 1;
    PilaTipos.tablas[sp].types[4].base = -1;
    PilaTipos.tablas[sp].count++;	

}
void borrar_tabla_tipos(){
    PilaTipos.sp--;
}

void imprimir_tipos(int table){
    int i;
    printf("pos\ttipo\ttam\tdim\tbase\n");
    for(i=0; i < PilaTipos.tablas[table].count; i++){
        printf("%d\t%s\t%d\t %d\t%d\n",PilaTipos.tablas[table].types[i].pos, PilaTipos.tablas[table].types[i].tipo,
               PilaTipos.tablas[table].types[i].tam,PilaTipos.tablas[table].types[i].dim,
		PilaTipos.tablas[table].types[i].base);        
    }
}
