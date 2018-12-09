/* 
 * File:   attributes.h
 * Author: Adrian Ulises Mercado Martínez ft Caballero , Arenas , Cortés , De La Cruz
 *
 * Created on 12/4/18
 */

#ifndef ATTRIBUTES_H
#define ATTRIBUTES_H


	typedef struct _type{
	int type;
	int dim;
	} type;

	typedef struct _exp{
	char dir[32];
	int type;
	} exp;

	typedef struct _numero{
	int type;
	char val[32];
	} numero;

	
	Stack initialize(); 
	void push(Stack *stack, char newLabel[32]);
	char *pop(Stack *stack);
	void destroy (Stack *stack);
	int isEmpty(Stack *stack);
	void peek(Stack *stack);
	void doublePeek(Stack *stack);
	int getSize (Stack *stack);
	void printStack (Element *top);
	




#endif /* ATTRIBUTES_H */

