/*Linguagem de programção ROJ*/

%{
#include <stdio.h>
#include <string.h>


%}

%union{int val; char* var;}

%token INICIO FIM
%token INSTINICIO INSTFIM
%token VAR
%token se entao senao fimse
%token enquanto fimenquanto
%token imprimir ler
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

Condicional	: se '(' Condicao ')' entao Instrucoes senao Instrucoes fimse
		;

Ciclo 		: enquanto '(' Condicao ')' entao Instrucoes fimenquanto
		;

Input		: ler Variavel ';'
		;

Output 		: imprimir Variavel ';'
		;

Condicao 	: Variavel DIFF Variavel
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
