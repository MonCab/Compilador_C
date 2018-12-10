#include "backpatch.h"
#include "stack.h"
#include "codigo_inter.h"
#include <stdio.h>
#include <string.h>

Stack *create_list(char * l){
    Stack *s = initialize();
    push(s, l);
    return s;
}


Stack *create_empty_list(){
    Stack *s = initialize();    
    return s;
}


Stack *  merge(Stack* ls1, Stack* ls2){
    Stack *s = initialize();
    Element * aux;

    aux = ls2 -> top;
    while(!(aux->next == NULL)){
        aux = aux->next;
    }

    s -> top = ls1 -> top;

    s -> top -> next = aux;

    s -> top = ls2 -> top;

    return s;
}

void backpatch(Stack* ls, char* l, ic* code){
    int j;
    Element * aux = ls -> top;

    do{
        for(j=code->count-1; j>=0; j--){
            if(strcmp(code->c[j].res, aux->label)==0){
                strcpy(code->c[j].res, l);
            }
        }
        aux = aux -> next;
    }while(!(aux == ls->top));
}


char *get_first(Stack* ls){
    Element * aux;

    aux = ls -> top;
    while (!(aux ->next == NULL)){
        aux = aux ->next;
    }
    return aux -> label;
}
