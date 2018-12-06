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

	typedef struct _labels{
	char label[1000][32];
	int count;
	} labels;
	
	char *pop_label(labels* ls);
	void push_label(labels* ls, char *l);
	
	char *get_top_label(labels* ls);	
	char *get_top_label_previous(labels* ls);
	void create_labels(labels* ls);
	void print_stack_labels(labels* ls);
	void print_list_labels(labels* ls);
	





#endif /* ATTRIBUTES_H */

