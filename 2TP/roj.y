/*Linguagem de programção ROJ*/

%{
#include <stdio.h>
#include <string.h>
FILE *out_file;
int currPointer=0;

void declaracao(int tamanho, char* identficador, int value);


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
%type <val>numero

%%


Programa	: INICIO Declaracoes Body FIM
		;

Declaracoes	: 
		| Declaracoes Declaracao
		;

Declaracao	: VAR id ';' 						{declaracao(0,$2,0);}
		| VAR id '=' numero ';' 				{declaracao(0,$2,$4);}
		| VAR id '[' num ']' ';' 				{declaracao($4,$2,0);}	
		| VAR id '[' num ']''[' num ']'  ';'	{declaracao(($4*$7),$2,0);}
		;

Body 		: 
		| INSTINICIO {fprintf(out_file,"START\n");} Instrucoes INSTFIM {fprintf(out_file,"STOP\n");} 
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

Atribuicao 	: Variavel '=' Condicao ';' // { atribuicao($1,$2); } // a variavel te de vir com o enderesso de memoria 
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

numero 		: num {$$=$1;}
		| '-' num {$$=-1*$2;}
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


void declaracao(int tamanho, char* identficador, int value){
	char* name =strdup(identficador);
	//if(var_hash_get(&varHash, name) != NULL)
	if(0)
        fatal_error("Multiple variable definitions");
    else{
        if(tamanho>0){
            fprintf(out_file,"PUSHN %d\n", tamanho);
            //var_hash_put(&varHash, name, currPointer, size, array_var, currFunc);
            currPointer+= tamanho;
        }
        else{
        	if(value!=0){
        		fprintf(out_file,"PUSHI %d\n",value);
        	}else{
        		fprintf(out_file,"PUSHI 0\n");
        	}
            
            //var_hash_put(&varHash, name, currPointer, 0, int_var, currFunc);
            currPointer++;
        }
    }
}


int yyerror(char * mensagem) {
	printf("Erro Sintático %s\n", mensagem);
	return 0;
}

int main() {
	out_file = fopen("teste.txt","w");
	yyparse();
	return 0;
}
