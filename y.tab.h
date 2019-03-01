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
    T_FE = 269,
    T_AS = 270,
    T_CASE = 271,
    T_BR = 272,
    T_DF = 273,
    NUM = 274,
    T_LT = 275,
    T_GT = 276,
    T_NOT = 277,
    T_OP = 278,
    T_CP = 279,
    T_OB = 280,
    T_CB = 281,
    T_SC = 282,
    T_C = 283,
    T_PL = 284,
    T_MIN = 285,
    T_STAR = 286,
    T_DIV = 287,
    T_MOD = 288,
    T_EQL = 289,
    T_EQ = 290,
    T_ID = 291,
    T_SW = 292
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
#define T_FE 269
#define T_AS 270
#define T_CASE 271
#define T_BR 272
#define T_DF 273
#define NUM 274
#define T_LT 275
#define T_GT 276
#define T_NOT 277
#define T_OP 278
#define T_CP 279
#define T_OB 280
#define T_CB 281
#define T_SC 282
#define T_C 283
#define T_PL 284
#define T_MIN 285
#define T_STAR 286
#define T_DIV 287
#define T_MOD 288
#define T_EQL 289
#define T_EQ 290
#define T_ID 291
#define T_SW 292

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef int YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif

/* Location type.  */
#if ! defined YYLTYPE && ! defined YYLTYPE_IS_DECLARED
typedef struct YYLTYPE YYLTYPE;
struct YYLTYPE
{
  int first_line;
  int first_column;
  int last_line;
  int last_column;
};
# define YYLTYPE_IS_DECLARED 1
# define YYLTYPE_IS_TRIVIAL 1
#endif


extern YYSTYPE yylval;
extern YYLTYPE yylloc;
int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
