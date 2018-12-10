#ifndef BACKPATCH_H
#define BACKPATCH_H

#include "stack.h"
#include "codigo_inter.h"
    
    Stack *create_list(char*);
    Stack *create_empty_list();
    Stack *merge(Stack* ls1, Stack* ls2);
    void backpatch(Stack* ls, char* l, ic* code);
    char *get_first(Stack* ls);

#endif /* BACKPATCH_H */

