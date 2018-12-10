/* 
 * File:   attributes.h
 * Author: Adrian Ulises Mercado Martínez ft Caballero , Arenas , Cortés , De La Cruz
 *
 * Created on 12/4/18
 */

#ifndef STACK_H
#define STACK_H

	struct Element{
		int index;
		char  label[1000];
		struct Element *next;
	};
	typedef struct Element Element;

	typedef struct {
		Element *top;
	}Stack;



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

	
	Stack * initialize(); 
	void push(Stack *stack, char newLabel[32]);
	char *pop(Stack *stack);
	void destroy (Stack *stack);
	int isEmpty(Stack *stack);
	void peek(Stack *stack);
	void doublePeek(Stack *stack);
	int getSize (Stack *stack);
	void printStack (Element *top);
	




#endif /* STACK_H */

