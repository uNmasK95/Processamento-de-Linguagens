/*Linguagem de programção ROJ*/

%{
#include <stdio.h>
#include <string.h>


%}

%union{int val; char* var;}

%token INICIO FIM
%token INSTINICIO INSTFIM
%token VAR
%token SE ENTAO SENAO FIMSE
%token ENQUANTO FIMENQUANTO
%token IMPRIMIR LER
%token MOD
%token DIFF GG LL GE LE EQ AND OR NOT
%token <var>id
%token <val>num


%type <val>Expressao
%type <val>Condicao


%%


Programa	: INICIO Declaracoes Body FIM
		;

Declaracoes	: 
		| Declaracoes Declaracao
		;

Declaracao	: VAR id ';'
		| VAR id '=' num ';'	
		| VAR id Array ';'	
		;

Array 		: '[' num ']'
		| '[' num ']''[' num ']'
		; 

Body 		: 
		| INSTINICIO Instrucoes INSTFIM
		;

Instrucoes	: 
		| Instrucoes Instrucao
		;

Instrucao 	: Atribuicao 
		| Condicional
		| Input
		| Output
		| Ciclo
		;

Atribuicao 	: Variavel '=' Expressao ';'
		| Variavel '=' Condicao ';'
		;

Expressao 	: Valor
		| Valor Op Valor
		| '(' Expressao ')' Op Valor
		| Valor Op '(' Expressao ')'
		;

Op 		: '+'
		| '-'
		| '*'
		| '/'
		;

Condicional	: SE '(' Condicao ')' ENTAO Instrucoes SENAO Instrucoes FIMSE
		;

Ciclo 		: ENQUANTO '(' Condicao ')' ENTAO Instrucoes FIMENQUANTO
		;

Input		: LER Variavel ';'
		;

Output 		: IMPRIMIR Variavel ';'
		;

Condicao 	: Variavel
		| Variavel DIFF Variavel
		| Variavel GG Variavel
		| Variavel LL Variavel
		| Variavel GE Variavel
		| Variavel LE Variavel
		| Variavel EQ Variavel
		| Variavel AND Variavel
		| Variavel OR Variavel
		| NOT Condicao
		;

Valor		: num
		| Variavel
		; 

Variavel	: id
		| id Array
		;

%%
#include "lex.yy.c"

int yyerror(char * mensagem) {
	printf("Erro Sintático %s\n", mensagem);
	return 0;
}

int main() {
	
	yyparse();
	return 0;
}
