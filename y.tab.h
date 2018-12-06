/* A Bison parser, made by GNU Bison 2.3.  */

/* Skeleton interface for Bison's Yacc-like parsers in C

   Copyright (C) 1984, 1989, 1990, 2000, 2001, 2002, 2003, 2004, 2005, 2006
   Free Software Foundation, Inc.

   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 2, or (at your option)
   any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program; if not, write to the Free Software
   Foundation, Inc., 51 Franklin Street, Fifth Floor,
   Boston, MA 02110-1301, USA.  */

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

/* Tokens.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
   /* Put the tokens into the symbol table, so that GDB and other debuggers
      know about them.  */
   enum yytokentype {
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
     DIFERENTEQUE = 289,
     IGUAL = 290,
     MENORIGUAL = 291,
     MAYORIGUAL = 292,
     MENORQUE = 293,
     MAYORQUE = 294,
     MENOS = 295,
     MAS = 296,
     MODULO = 297,
     DIV = 298,
     MUL = 299,
     NOT = 300,
     PARD = 301,
     PARI = 302,
     CORD = 303,
     CORI = 304,
     LLAD = 305,
     LLAI = 306
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
#define DIFERENTEQUE 289
#define IGUAL 290
#define MENORIGUAL 291
#define MAYORIGUAL 292
#define MENORQUE 293
#define MAYORQUE 294
#define MENOS 295
#define MAS 296
#define MODULO 297
#define DIV 298
#define MUL 299
#define NOT 300
#define PARD 301
#define PARI 302
#define CORD 303
#define CORI 304
#define LLAD 305
#define LLAI 306




#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE
#line 15 "programa.y"
{
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
}
/* Line 1529 of yacc.c.  */
#line 168 "y.tab.h"
	YYSTYPE;
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
# define YYSTYPE_IS_TRIVIAL 1
#endif

extern YYSTYPE yylval;

