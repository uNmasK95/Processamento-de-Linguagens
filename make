rjaf:2TP rjaf$ make
yacc -d roj.y
flex roj.l
gcc -c hashtable.c
hashtable.c:65:17: error: expected expression
        printf("%s\n", );
                       ^
1 error generated.
make: *** [hashtable.o] Error 1
rjaf:2TP rjaf$ make
gcc -c hashtable.c
gcc  hashtable.o -o roj y.tab.c 
y.tab.c:1375:16: warning: implicit declaration of function 'yylex' is invalid in C99 [-Wimplicit-function-declaration]
      yychar = YYLEX;
               ^
y.tab.c:731:16: note: expanded from macro 'YYLEX'
# define YYLEX yylex ()
               ^
y.tab.c:1533:7: warning: implicit declaration of function 'yyerror' is invalid in C99 [-Wimplicit-function-declaration]
      yyerror (YY_("syntax error"));
      ^
2 warnings generated.
rm lex.yy.c
rm y.tab.h
rm y.tab.c
rjaf:2TP rjaf$ c



































rjaf:2TP rjaf$ more Codigo\ em\ ROJ/maior3.roj 
INICIO
        VAR a;
        VAR b;
        VAR c;
        VAR g;
        VAR b;
INSTINICIO
        g=-999;
        LER a;
        SE (a GG g) ENTAO
                g=a;
        SENAO
        FIMSE
        LER b;
        SE (b GG g) ENTAO
                g=b;
        SENAO
        FIMSE
        LER c;
        SE (c GG g) ENTAO
                g=c;
        SENAO
        FIMSE
        IMPRIMIR g;
INSTFIM
FIM
rjaf:2TP rjaf$ ./roj < Codigo\ em\ ROJ/maior3.roj 
antes aqui
olamundo
a
depois
tudo ok
depois aqui
a
antes aqui
olamundo
b
depois
tudo ok
Entreir aqui
Erro Sintático Multiple variable definitions
rjaf:2TP rjaf$ make
yacc -d roj.y
flex roj.l
gcc  hashtable.o -o roj y.tab.c 
y.tab.c:1375:16: warning: implicit declaration of function 'yylex' is invalid in C99 [-Wimplicit-function-declaration]
      yychar = YYLEX;
               ^
y.tab.c:731:16: note: expanded from macro 'YYLEX'
# define YYLEX yylex ()
               ^
y.tab.c:1533:7: warning: implicit declaration of function 'yyerror' is invalid in C99 [-Wimplicit-function-declaration]
      yyerror (YY_("syntax error"));
      ^
2 warnings generated.
rm lex.yy.c
rm y.tab.h
rm y.tab.c
rjaf:2TP rjaf$ ./roj < Codigo\ em\ ROJ/maior3.roj 
antes aqui
a
olamundo
a
depois
tudo ok
depois aqui
a
antes aqui
b
olamundo
b
depois
tudo ok
Entreir aqui
Erro Sintático Multiple variable definitions
rjaf:2TP rjaf$ ./roj 
INICIO
VAR a;
antes aqui
a
olamundo
a
depois
tudo ok
depois aqui
a
VAR b;
antes aqui
b
olamundo
b
depois
tudo ok
Entreir aqui
Erro Sintático Multiple variable definitions
rjaf:2TP rjaf$ make
yacc -d roj.y
flex roj.l
gcc -c hashtable.c
gcc  hashtable.o -o roj y.tab.c 
y.tab.c:1375:16: warning: implicit declaration of function 'yylex' is invalid in C99 [-Wimplicit-function-declaration]
      yychar = YYLEX;
               ^
y.tab.c:731:16: note: expanded from macro 'YYLEX'
# define YYLEX yylex ()
               ^
y.tab.c:1533:7: warning: implicit declaration of function 'yyerror' is invalid in C99 [-Wimplicit-function-declaration]
      yyerror (YY_("syntax error"));
      ^
2 warnings generated.
rm lex.yy.c
rm y.tab.h
rm y.tab.c
rjaf:2TP rjaf$ ./roj 
INICIO
VAR a;
antes aqui
->a
a
tudo ok
depois aqui
a
VAR b;
antes aqui
->b
b
tudo ok
Entreir aqui
Erro Sintático Multiple variable definitions
rjaf:2TP rjaf$ make
yacc -d roj.y
flex roj.l
gcc -c hashtable.c
gcc  hashtable.o -o roj y.tab.c 
y.tab.c:1375:16: warning: implicit declaration of function 'yylex' is invalid in C99 [-Wimplicit-function-declaration]
      yychar = YYLEX;
               ^
y.tab.c:731:16: note: expanded from macro 'YYLEX'
# define YYLEX yylex ()
               ^
y.tab.c:1533:7: warning: implicit declaration of function 'yyerror' is invalid in C99 [-Wimplicit-function-declaration]
      yyerror (YY_("syntax error"));
      ^
2 warnings generated.
rm lex.yy.c
rm y.tab.h
rm y.tab.c
rjaf:2TP rjaf$ ./roj 
INICIO
VAR a;
antes aqui
->a
a
tudo ok
depois aqui
a
VAR b;
antes aqui
->b
b
tudo ok
GET->a:b
Entreir aqui
Erro Sintático Multiple variable definitions
rjaf:2TP rjaf$ make
yacc -d roj.y
flex roj.l
gcc -c hashtable.c
hashtable.c:67:22: error: use of undeclared identifier 'au'
        printf("Return%s\n",au );
                            ^
1 error generated.
make: *** [hashtable.o] Error 1
rjaf:2TP rjaf$ ./roj 
INICIO
VAR a;
antes aqui
->a
a
tudo ok
depois aqui
a
VAR b;
antes aqui
->b
b
tudo ok
GET->a:b
Entreir aqui
Erro Sintático Multiple variable definitions
rjaf:2TP rjaf$ make
gcc -c hashtable.c
gcc  hashtable.o -o roj y.tab.c 
y.tab.c:1375:16: warning: implicit declaration of function 'yylex' is invalid in C99 [-Wimplicit-function-declaration]
      yychar = YYLEX;
               ^
y.tab.c:731:16: note: expanded from macro 'YYLEX'
# define YYLEX yylex ()
               ^
y.tab.c:1533:7: warning: implicit declaration of function 'yyerror' is invalid in C99 [-Wimplicit-function-declaration]
      yyerror (YY_("syntax error"));
      ^
2 warnings generated.
rm lex.yy.c
rm y.tab.h
rm y.tab.c
rjaf:2TP rjaf$ ./roj 
INICIO
VAR a;
antes aqui
->a
a
tudo ok
depois aqui
a
VAR b;
antes aqui
->b
b
tudo ok
GET->a:b
GETINI->a:b
depois aqui
b
VAR c;
antes aqui
->c
c
tudo ok
GET->a:c
GETINI->a:c
GETINI->b:c
depois aqui
c
VAR a;
antes aqui
->a
a
tudo ok
GET->a:a
REturn
Entreir aqui
Erro Sintático Multiple variable definitions
rjaf:2TP rjaf$ make
yacc -d roj.y
flex roj.l
gcc -c hashtable.c
gcc  hashtable.o -o roj y.tab.c 
y.tab.c:1375:16: warning: implicit declaration of function 'yylex' is invalid in C99 [-Wimplicit-function-declaration]
      yychar = YYLEX;
               ^
y.tab.c:731:16: note: expanded from macro 'YYLEX'
# define YYLEX yylex ()
               ^
y.tab.c:1533:7: warning: implicit declaration of function 'yyerror' is invalid in C99 [-Wimplicit-function-declaration]
      yyerror (YY_("syntax error"));
      ^
2 warnings generated.
rm lex.yy.c
rm y.tab.h
rm y.tab.c
rjaf:2TP rjaf$ make
yacc -d roj.y
flex roj.l
gcc -c hashtable.c
gcc  hashtable.o -o roj y.tab.c 
y.tab.c:1375:16: warning: implicit declaration of function 'yylex' is invalid in C99 [-Wimplicit-function-declaration]
      yychar = YYLEX;
               ^
y.tab.c:731:16: note: expanded from macro 'YYLEX'
# define YYLEX yylex ()
               ^
y.tab.c:1533:7: warning: implicit declaration of function 'yyerror' is invalid in C99 [-Wimplicit-function-declaration]
      yyerror (YY_("syntax error"));
      ^
2 warnings generated.
rm lex.yy.c
rm y.tab.h
rm y.tab.c
rjaf:2TP rjaf$ ./roj 
INICIO
VAR a;
antes aqui
->a
HASHVALOR:a->0
tudo ok
depois aqui
HASHVALOR:a->0
VAR b;
antes aqui
->b
HASHVALOR:b->0
tudo ok
GET->a:b
GETINI->a:b
depois aqui
HASHVALOR:b->0
^C  
rjaf:2TP rjaf$ 
rjaf:2TP rjaf$ 
rjaf:2TP rjaf$ make
yacc -d roj.y
flex roj.l
gcc -c hashtable.c
gcc  hashtable.o -o roj y.tab.c 
y.tab.c:1375:16: warning: implicit declaration of function 'yylex' is invalid in C99 [-Wimplicit-function-declaration]
      yychar = YYLEX;
               ^
y.tab.c:731:16: note: expanded from macro 'YYLEX'
# define YYLEX yylex ()
               ^
y.tab.c:1533:7: warning: implicit declaration of function 'yyerror' is invalid in C99 [-Wimplicit-function-declaration]
      yyerror (YY_("syntax error"));
      ^
2 warnings generated.
rm lex.yy.c
rm y.tab.h
rm y.tab.c
rjaf:2TP rjaf$ ./roj 
INICIO
VAR a;
antes aqui
->a
HASHVALOR:a->97
tudo ok
depois aqui
HASHVALOR:a->97
VAR b;
antes aqui
->b
HASHVALOR:b->98
tudo ok
depois aqui
HASHVALOR:b->98
^C
rjaf:2TP rjaf$ make
yacc -d roj.y
flex roj.l
gcc -c hashtable.c
gcc  hashtable.o -o roj y.tab.c 
y.tab.c:1375:16: warning: implicit declaration of function 'yylex' is invalid in C99 [-Wimplicit-function-declaration]
      yychar = YYLEX;
               ^
y.tab.c:731:16: note: expanded from macro 'YYLEX'
# define YYLEX yylex ()
               ^
y.tab.c:1533:7: warning: implicit declaration of function 'yyerror' is invalid in C99 [-Wimplicit-function-declaration]
      yyerror (YY_("syntax error"));
      ^
2 warnings generated.
rm lex.yy.c
rm y.tab.h
rm y.tab.c
rjaf:2TP rjaf$ make
yacc -d roj.y
flex roj.l
gcc -c hashtable.c
gcc  hashtable.o -o roj y.tab.c 
y.tab.c:1375:16: warning: implicit declaration of function 'yylex' is invalid in C99 [-Wimplicit-function-declaration]
      yychar = YYLEX;
               ^
y.tab.c:731:16: note: expanded from macro 'YYLEX'
# define YYLEX yylex ()
               ^
y.tab.c:1533:7: warning: implicit declaration of function 'yyerror' is invalid in C99 [-Wimplicit-function-declaration]
      yyerror (YY_("syntax error"));
      ^
2 warnings generated.
rm lex.yy.c
rm y.tab.h
rm y.tab.c
rjaf:2TP rjaf$ ./roj < Codigo\ em\ ROJ/maior3.roj 
Erro Sintático Multiple variable definitions
rjaf:2TP rjaf$ ./roj < Codigo\ em\ ROJ/matrix.roj 
rjaf:2TP rjaf$ make
yacc -d roj.y
roj.y:86.86-87: $1 of `Expressao' has no declared type
roj.y:100.67-68: $$ of `Fator' has no declared type
roj.y:100.70-71: $1 of `Fator' has no declared type
roj.y:101.51-52: $$ of `Fator' has no declared type
roj.y:126.43-44: $$ of `Valor' has no declared type
roj.y:127.35-36: $$ of `Valor' has no declared type
roj.y:127.38-39: $1 of `Valor' has no declared type
make: *** [y.tab.c] Error 1
rjaf:2TP rjaf$ make
yacc -d roj.y
roj.y:89.86-87: $1 of `Expressao' has no declared type
make: *** [y.tab.c] Error 1
rjaf:2TP rjaf$ make
yacc -d roj.y
flex roj.l
gcc  hashtable.o -o roj y.tab.c 
y.tab.c:1376:16: warning: implicit declaration of function 'yylex' is invalid in C99 [-Wimplicit-function-declaration]
      yychar = YYLEX;
               ^
y.tab.c:732:16: note: expanded from macro 'YYLEX'
# define YYLEX yylex ()
               ^
roj.y:90:41: error: expected ';' after expression
    { (yyval.var)=(yyvsp[(1) - (1)].var) }
                                        ^
                                        ;
roj.y:130:32: error: expected expression
    { (yyval.var) = pushNumero(int numero);}
                               ^
y.tab.c:1599:7: warning: implicit declaration of function 'yyerror' is invalid in C99 [-Wimplicit-function-declaration]
      yyerror (YY_("syntax error"));
      ^
2 warnings and 2 errors generated.
make: *** [roj] Error 1
rjaf:2TP rjaf$ make
yacc -d roj.y
gcc  hashtable.o -o roj y.tab.c 
y.tab.c:1376:16: warning: implicit declaration of function 'yylex' is invalid in C99 [-Wimplicit-function-declaration]
      yychar = YYLEX;
               ^
y.tab.c:732:16: note: expanded from macro 'YYLEX'
# define YYLEX yylex ()
               ^
roj.y:90:41: error: expected ';' after expression
    { (yyval.var)=(yyvsp[(1) - (1)].var) }
                                        ^
                                        ;
y.tab.c:1599:7: warning: implicit declaration of function 'yyerror' is invalid in C99 [-Wimplicit-function-declaration]
      yyerror (YY_("syntax error"));
      ^
2 warnings and 1 error generated.
make: *** [roj] Error 1
rjaf:2TP rjaf$ make
yacc -d roj.y
gcc  hashtable.o -o roj y.tab.c 
y.tab.c:1376:16: warning: implicit declaration of function 'yylex' is invalid in C99 [-Wimplicit-function-declaration]
      yychar = YYLEX;
               ^
y.tab.c:732:16: note: expanded from macro 'YYLEX'
# define YYLEX yylex ()
               ^
y.tab.c:1599:7: warning: implicit declaration of function 'yyerror' is invalid in C99 [-Wimplicit-function-declaration]
      yyerror (YY_("syntax error"));
      ^
2 warnings generated.
rm lex.yy.c
rm y.tab.h
rm y.tab.c
rjaf:2TP rjaf$ make
yacc -d roj.y
flex roj.l
gcc -c hashtable.c
gcc  hashtable.o -o roj y.tab.c 
y.tab.c:1379:16: warning: implicit declaration of function 'yylex' is invalid in C99 [-Wimplicit-function-declaration]
      yychar = YYLEX;
               ^
y.tab.c:735:16: note: expanded from macro 'YYLEX'
# define YYLEX yylex ()
               ^
y.tab.c:1617:7: warning: implicit declaration of function 'yyerror' is invalid in C99 [-Wimplicit-function-declaration]
      yyerror (YY_("syntax error"));
      ^
roj.y:162:43: error: too many arguments to function call, expected single argument 's', have 2 arguments
                fatal_error("Variavel %s não defenida",var);
                ~~~~~~~~~~~                            ^~~
roj.y:146:1: note: 'fatal_error' declared here
void fatal_error(char *s){
^
roj.y:174:43: error: too many arguments to function call, expected single argument 's', have 2 arguments
                fatal_error("Variavel %s não defenida",var);
                ~~~~~~~~~~~                            ^~~
roj.y:146:1: note: 'fatal_error' declared here
void fatal_error(char *s){
^
2 warnings and 2 errors generated.
make: *** [roj] Error 1
rjaf:2TP rjaf$ make
yacc -d roj.y
gcc  hashtable.o -o roj y.tab.c 
y.tab.c:1379:16: warning: implicit declaration of function 'yylex' is invalid in C99 [-Wimplicit-function-declaration]
      yychar = YYLEX;
               ^
y.tab.c:735:16: note: expanded from macro 'YYLEX'
# define YYLEX yylex ()
               ^
y.tab.c:1617:7: warning: implicit declaration of function 'yyerror' is invalid in C99 [-Wimplicit-function-declaration]
      yyerror (YY_("syntax error"));
      ^
roj.y:148:2: warning: implicit declaration of function 'va_start' is invalid in C99 [-Wimplicit-function-declaration]
        va_start(ap, s);
        ^
roj.y:166:43: error: too many arguments to function call, expected single argument 's', have 2 arguments
                fatal_error("Variavel %s não defenida",var);
                ~~~~~~~~~~~                            ^~~
roj.y:146:1: note: 'fatal_error' declared here
void fatal_error(char *s){
^
roj.y:178:43: error: too many arguments to function call, expected single argument 's', have 2 arguments
                fatal_error("Variavel %s não defenida",var);
                ~~~~~~~~~~~                            ^~~
roj.y:146:1: note: 'fatal_error' declared here
void fatal_error(char *s){
^
3 warnings and 2 errors generated.
make: *** [roj] Error 1
rjaf:2TP rjaf$ make
yacc -d roj.y
gcc  hashtable.o -o roj y.tab.c 
y.tab.c:1379:16: warning: implicit declaration of function 'yylex' is invalid in C99 [-Wimplicit-function-declaration]
      yychar = YYLEX;
               ^
y.tab.c:735:16: note: expanded from macro 'YYLEX'
# define YYLEX yylex ()
               ^
y.tab.c:1617:7: warning: implicit declaration of function 'yyerror' is invalid in C99 [-Wimplicit-function-declaration]
      yyerror (YY_("syntax error"));
      ^
roj.y:146:6: error: conflicting types for 'fatal_error'
void fatal_error(char *s,...){
     ^
roj.y:13:6: note: previous declaration is here
void fatal_error(char *s);
     ^
roj.y:148:2: warning: implicit declaration of function 'va_start' is invalid in C99 [-Wimplicit-function-declaration]
        va_start(ap, s);
        ^
roj.y:166:43: error: too many arguments to function call, expected single argument 's', have 2 arguments
                fatal_error("Variavel %s não defenida",var);
                ~~~~~~~~~~~                            ^~~
roj.y:13:1: note: 'fatal_error' declared here
void fatal_error(char *s);
^
roj.y:178:43: error: too many arguments to function call, expected single argument 's', have 2 arguments
                fatal_error("Variavel %s não defenida",var);
                ~~~~~~~~~~~                            ^~~
roj.y:13:1: note: 'fatal_error' declared here
void fatal_error(char *s);
^
3 warnings and 3 errors generated.
make: *** [roj] Error 1
rjaf:2TP rjaf$ make
yacc -d roj.y
gcc  hashtable.o -o roj y.tab.c 
y.tab.c:1379:16: warning: implicit declaration of function 'yylex' is invalid in C99 [-Wimplicit-function-declaration]
      yychar = YYLEX;
               ^
y.tab.c:735:16: note: expanded from macro 'YYLEX'
# define YYLEX yylex ()
               ^
y.tab.c:1617:7: warning: implicit declaration of function 'yyerror' is invalid in C99 [-Wimplicit-function-declaration]
      yyerror (YY_("syntax error"));
      ^
roj.y:148:2: warning: implicit declaration of function 'va_start' is invalid in C99 [-Wimplicit-function-declaration]
        va_start(ap, s);
        ^
3 warnings generated.
Undefined symbols for architecture x86_64:
  "_pushArray2D", referenced from:
      _yyparse in y-04e40e.o
  "_va_start", referenced from:
      _fatal_error in y-04e40e.o
ld: symbol(s) not found for architecture x86_64
clang: error: linker command failed with exit code 1 (use -v to see invocation)
make: *** [roj] Error 1
rjaf:2TP rjaf$ make
yacc -d roj.y
gcc  hashtable.o -o roj y.tab.c 
y.tab.c:1379:16: warning: implicit declaration of function 'yylex' is invalid in C99 [-Wimplicit-function-declaration]
      yychar = YYLEX;
               ^
y.tab.c:735:16: note: expanded from macro 'YYLEX'
# define YYLEX yylex ()
               ^
y.tab.c:1617:7: warning: implicit declaration of function 'yyerror' is invalid in C99 [-Wimplicit-function-declaration]
      yyerror (YY_("syntax error"));
      ^
roj.y:162:43: error: too many arguments to function call, expected single argument 's', have 2 arguments
                fatal_error("Variavel %s não defenida",var);
                ~~~~~~~~~~~                            ^~~
roj.y:146:1: note: 'fatal_error' declared here
void fatal_error(char *s){
^
roj.y:174:43: error: too many arguments to function call, expected single argument 's', have 2 arguments
                fatal_error("Variavel %s não defenida",var);
                ~~~~~~~~~~~                            ^~~
roj.y:146:1: note: 'fatal_error' declared here
void fatal_error(char *s){
^
2 warnings and 2 errors generated.
make: *** [roj] Error 1
rjaf:2TP rjaf$ 
