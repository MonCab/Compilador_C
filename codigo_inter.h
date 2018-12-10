
#ifndef CODIGO_INTER_H
#define CODIGO_INTER_H
    
#define GOTO 1
#define IFF 2
#define LT 3
#define GT 4
#define LE 5
#define GE 6
#define EQ 7
#define NE 8
#define MA 9
#define MEN 10
#define ML 11
#define DV 12
#define LB 13
#define AS 14
#define MAX_CODE 1000
    
    typedef struct _cuadrupla{
        int op;
        char op1[32];
        char op2[32];
        char res[32];
    }cuadrupla;
    
     
    typedef struct _intremediate_code{
       cuadrupla c[MAX_CODE];
       int count;
    }ic;
    
    void create_code(ic*);
    int insert_cuad(ic*, cuadrupla);      
    void print_code(ic*);

#endif /* CODIGO_INTER_H */

