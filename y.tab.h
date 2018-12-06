/* A Bison parser, made by GNU Bison 3.0.4.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015 Free Software Foundation, Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

#ifndef YY_YY_Y_TAB_H_INCLUDED
# define YY_YY_Y_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    ID = 258,
    NUM = 259,
    ENT = 260,
    FLO = 261,
    DOB = 262,
    CARA = 263,
    VAC = 264,
    ESTR = 265,
    FUNC = 266,
    COMA = 267,
    PYCOMA = 268,
    SI = 269,
    SINO = 270,
    MIEN = 271,
    HACER = 272,
    PARA = 273,
    RET = 274,
    SWI = 275,
    BREA = 276,
    PRIN = 277,
    CASE = 278,
    DEF = 279,
    DP = 280,
    PUNTO = 281,
    CADE = 282,
    CHAR = 283,
    TRUE = 284,
    FALSE = 285,
    ASIGNACION = 286,
    OR = 287,
    AND = 288,
    IGUAL = 289,
    DIFERENTEQUE = 290,
    MAYORQUE = 291,
    MENORQUE = 292,
    MAYORIGUAL = 293,
    MENORIGUAL = 294,
    MAS = 295,
    MENOS = 296,
    MUL = 297,
    DIV = 298,
    MODULO = 299,
    NOT = 300,
    PARI = 301,
    PARD = 302,
    LLAI = 303,
    LLAD = 304,
    CORI = 305,
    CORD = 306
  };
#endif
/* Tokens.  */
#define ID 258
#define NUM 259
#define ENT 260
#define FLO 261
#define DOB 262
#define CARA 263
#define VAC 264
#define ESTR 265
#define FUNC 266
#define COMA 267
#define PYCOMA 268
#define SI 269
#define SINO 270
#define MIEN 271
#define HACER 272
#define PARA 273
#define RET 274
#define SWI 275
#define BREA 276
#define PRIN 277
#define CASE 278
#define DEF 279
#define DP 280
#define PUNTO 281
#define CADE 282
#define CHAR 283
#define TRUE 284
#define FALSE 285
#define ASIGNACION 286
#define OR 287
#define AND 288
#define IGUAL 289
#define DIFERENTEQUE 290
#define MAYORQUE 291
#define MENORQUE 292
#define MAYORIGUAL 293
#define MENORIGUAL 294
#define MAS 295
#define MENOS 296
#define MUL 297
#define DIV 298
#define MODULO 299
#define NOT 300
#define PARI 301
#define PARD 302
#define LLAI 303
#define LLAD 304
#define CORI 305
#define CORD 306

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED

union YYSTYPE
{
#line 30 "programa.y" /* yacc.c:1909  */

	numero num;	
	char id[32];
	exp expresion;
	type tipo;
	struct{
	labels falses;
	labels trues;
	}booleanos;
	labels siguientes;
	struct{
	labels siguientes;
	bool ifelse;
	}siguientesp;
	int rel;

#line 173 "y.tab.h" /* yacc.c:1909  */
};

typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
