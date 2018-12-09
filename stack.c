//
//  stack.c
//
//  
//
#include "stack.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h> 

int size;


Stack * initialize(){
	Stack *top;
	top = (Stack *) calloc(1,sizeof(Stack));
	if (top == NULL){
		printf("\nNot enough memory to initialize stack\n");
		exit(1);
	}
	size = 0;
	top -> top = NULL;
	return top;
} 

void destroy(Stack *stack){
	free(stack->top);
	stack->top = NULL;
}

int isEmpty(Stack *stack){
	if (stack->top == NULL)
		return 1;
	else
		return 0;
}


void push(Stack *stack, char newLabel[32] ){
	Element *newNode = (Element *) calloc (1,sizeof(Element));
	strcpy(newNode->label,newLabel);
	size += 1;
	newNode -> index = size;
	newNode -> next = stack -> top;
	stack -> top = newNode;
}


void peek(Stack *stack){
	if (isEmpty(stack) == 0 )
		printf("\n Tope de Pila : %s\n", stack->top->label);
	else 
		printf("\n\tError, la pila está vacia \n");
}

void doublePeek (Stack *stack){
	if (stack->top->next != NULL){
		printf("\n Penultimo elemento de la pila : %s\n", stack->top->next->label);
	}else
		printf("\n\tError, la pila solo tiene un elemento\n");
}

char * pop(Stack *stack){
	if (isEmpty(stack) == 0)	{
		char *info = stack -> top -> label;
		stack->top = stack->top -> next;
		size -= 1;
		return info;
	}
	printf("\n\tStack is empty\n");
	exit(1);
}

int getSize(Stack *stack){
	return stack -> top -> index ;
}

void printStack(Element *top){
	if(top == NULL)
		return;
	printf("\n\t%d\t%s\n", top->index, top->label);
	printStack(top->next);
}
/*
int main(void){
 	char * trash ;  
	Stack *s = initialize();
	push(s, "Et1");
	push(s, "Et2"); 
	push(s, "Et3"); 
	//printf("\n\t Tamaño %i \n",getSize(s));
	//doublePeek(s);
	//peek(s);
	//trash = pop(s);
	printStack(s->top);
	//printf("\n Último Pop %s\n", trash);
	return 0;
}
*/

