//
//  stack.c
//
//  
//
#include <stdio.h>
#include <stdlib.h>
#include <string.h>


typedef int Element;

typedef struct {
    Element *content;
    int current_size;
    int top;
} Stack;

void initialize(Stack *stack){
    Element *content;
    content = (Element *) calloc(2, sizeof(Element));

    if (content == NULL){
        fprintf(stderr, "Not enough memory to initialize stack\n");
        exit(1);
    }

    stack->content = content;
    stack->current_size = 2;
    stack->top = -1;
}

void destroy(Stack *stack){
    free(stack->content);
    stack->content = NULL;
    stack->current_size = 0;
    stack->top = -1;
}

void resize(Stack *stack){
    Element *resized_content;
    resized_content = (Element *) calloc(stack->current_size * 2, sizeof(Element));
    memcpy(resized_content, stack->content, sizeof(Element) * stack->top + 1);
    free(stack->content);
    stack->content = resized_content;
    stack->current_size = stack->current_size * 2;
}

int is_empty(Stack *stack){
    if (stack->top < 0)
        return 1;
    else
        return 0;
}

int is_full(Stack *stack){
    if (stack->top == stack->current_size - 1)
        return 1;
    else
        return 0;
}

void push(Stack *stack, Element data){
    if (is_full(stack) == 1)
        resize(stack);
    
    stack->top = stack->top + 1;
    stack->content[stack->top] = data;
}

Element peek(Stack *stack){
    return stack->content[stack->top];
}

Element pop(Stack *stack){
    if (is_empty(stack) == 0)    {
        Element data = stack->content[stack->top];
        stack->top = stack->top - 1;
        return data;
    }
    
    fprintf(stderr, "Stack is empty\n");
    exit(1);
}
int main(void){
 
   Stack *s;
    initialize(s); 
    for (int i = 0; i < 13; i++) {
        push(s, i);
    }   
    //push(s,'h');
    //printf("%i\n", peek(s));  
    while (1) {
        printf("%i\n", pop(s));
    }
    
    return 0;
}


