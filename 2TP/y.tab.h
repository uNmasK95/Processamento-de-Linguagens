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
     INICIO = 258,
     FIM = 259,
     INSTINICIO = 260,
     INSTFIM = 261,
     VAR = 262,
     se = 263,
     entao = 264,
     senao = 265,
     fimse = 266,
     enquanto = 267,
     fimenquanto = 268,
     imprimir = 269,
     ler = 270,
     DIFF = 271,
     GG = 272,
     LL = 273,
     GE = 274,
     LE = 275,
     EQ = 276,
     AND = 277,
     OR = 278,
     NOT = 279,
     id = 280,
     num = 281
   };
#endif
/* Tokens.  */
#define INICIO 258
#define FIM 259
#define INSTINICIO 260
#define INSTFIM 261
#define VAR 262
#define se 263
#define entao 264
#define senao 265
#define fimse 266
#define enquanto 267
#define fimenquanto 268
#define imprimir 269
#define ler 270
#define DIFF 271
#define GG 272
#define LL 273
#define GE 274
#define LE 275
#define EQ 276
#define AND 277
#define OR 278
#define NOT 279
#define id 280
#define num 281




#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE
#line 10 "roj.y"
{int val; char* var;}
/* Line 1529 of yacc.c.  */
#line 103 "y.tab.h"
	YYSTYPE;
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
# define YYSTYPE_IS_TRIVIAL 1
#endif

extern YYSTYPE yylval;

