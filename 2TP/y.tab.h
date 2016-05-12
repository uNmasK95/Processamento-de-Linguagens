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
     SE = 263,
     ENTAO = 264,
     SENAO = 265,
     FIMSE = 266,
     ENQUANTO = 267,
     FIMENQUANTO = 268,
     IMPRIMIR = 269,
     LER = 270,
     MOD = 271,
     DIFF = 272,
     GG = 273,
     LL = 274,
     GE = 275,
     LE = 276,
     EQ = 277,
     AND = 278,
     OR = 279,
     NOT = 280,
     id = 281,
     num = 282
   };
#endif
/* Tokens.  */
#define INICIO 258
#define FIM 259
#define INSTINICIO 260
#define INSTFIM 261
#define VAR 262
#define SE 263
#define ENTAO 264
#define SENAO 265
#define FIMSE 266
#define ENQUANTO 267
#define FIMENQUANTO 268
#define IMPRIMIR 269
#define LER 270
#define MOD 271
#define DIFF 272
#define GG 273
#define LL 274
#define GE 275
#define LE 276
#define EQ 277
#define AND 278
#define OR 279
#define NOT 280
#define id 281
#define num 282




#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE
#line 10 "roj.y"
{int val; char* var;}
/* Line 1529 of yacc.c.  */
#line 105 "y.tab.h"
	YYSTYPE;
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
# define YYSTYPE_IS_TRIVIAL 1
#endif

extern YYSTYPE yylval;

