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
		| VAR id '=' numero ';'
		| VAR id '[' num ']' ';'	
		| VAR id '[' num ']''[' num ']'  ';'	
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

Atribuicao 	: Variavel '=' Condicao ';'
		;

Condicao	: Expressao
		| Expressao OpRel Expressao
		| NOT Expressao
		;

OpRel		: DIFF
		| GG
		| LL
		| GE
		| LE
		| EQ
		;

Expressao	: Termo
		| Expressao OpAdd Termo
		;

OpAdd		: '+'
		| '-'
		| AND
		| OR
		;

Termo 		: Forma
		| Termo OpMul Forma
		;

Forma		: Valor 
		| '(' Expressao ')'
		; 


OpMul		: '*'
		| '/'
		| '%'
		;

Condicional	: SE '(' Condicao ')' ENTAO Instrucoes SENAO Instrucoes FIMSE
		;

Ciclo 		: ENQUANTO '(' Condicao ')' ENTAO Instrucoes FIMENQUANTO
		;

Input		: LER Valor ';'
		;

Output 		: IMPRIMIR Valor ';'
		;

numero 		: num
		| '-' num
		;

Valor		: numero
		| Variavel
		; 

Variavel	: id
		| id '[' Expressao ']'
		| id '[' Expressao ']''[' Expressao ']'
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
