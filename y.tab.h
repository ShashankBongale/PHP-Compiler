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
    T_START = 258,
    T_END = 259,
    T_LE = 260,
    T_GE = 261,
    T_NEC = 262,
    T_NE = 263,
    T_EQC = 264,
    T_EXP = 265,
    T_AND = 266,
    T_OR = 267,
    T_XOR = 268,
    T_SW = 269,
    T_FE = 270,
    T_AS = 271,
    T_CASE = 272,
    T_BR = 273,
    T_DF = 274,
    NUM = 275,
    T_LT = 276,
    T_GT = 277,
    T_NOT = 278,
    T_OP = 279,
    T_CP = 280,
    T_OB = 281,
    T_CB = 282,
    T_SC = 283,
    T_C = 284,
    T_PL = 285,
    T_MIN = 286,
    T_STAR = 287,
    T_DIV = 288,
    T_MOD = 289,
    T_EQL = 290,
    T_EQ = 291,
    T_ID = 292
  };
#endif
/* Tokens.  */
#define T_START 258
#define T_END 259
#define T_LE 260
#define T_GE 261
#define T_NEC 262
#define T_NE 263
#define T_EQC 264
#define T_EXP 265
#define T_AND 266
#define T_OR 267
#define T_XOR 268
#define T_SW 269
#define T_FE 270
#define T_AS 271
#define T_CASE 272
#define T_BR 273
#define T_DF 274
#define NUM 275
#define T_LT 276
#define T_GT 277
#define T_NOT 278
#define T_OP 279
#define T_CP 280
#define T_OB 281
#define T_CB 282
#define T_SC 283
#define T_C 284
#define T_PL 285
#define T_MIN 286
#define T_STAR 287
#define T_DIV 288
#define T_MOD 289
#define T_EQL 290
#define T_EQ 291
#define T_ID 292

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef int YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
