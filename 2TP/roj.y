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
%token DIFF GG LL GE LE EQ AND OR NOT
%token <var>id
%token <val>num


//%type <val>Expressao
//%type <val>Condicao


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

Array 		: '[' Valor ']'
		| '[' Valor ']''[' Valor ']'
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
		| '%'
		;

Condicional	: SE '(' Condicao ')' ENTAO Instrucoes SENAO Instrucoes FIMSE
		;

Ciclo 		: ENQUANTO '(' Condicao ')' ENTAO Instrucoes FIMENQUANTO
		;

Input		: LER Variavel ';'
		;

Output 		: IMPRIMIR Variavel ';'
		;

Condicao 	: Valor
		| Valor DIFF Valor
		| Valor GG Valor
		| Valor LL Valor
		| Valor GE Valor
		| Valor LE Valor
		| Valor EQ Valor
		| Valor AND Valor
		| Valor OR Valor
		| NOT Condicao
		;

Valor		: num
		| '-' num
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
