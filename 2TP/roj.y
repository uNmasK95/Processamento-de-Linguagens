/*Linguagem de programção ROJ*/

%{
#include "hashtable.h"
#include <stdio.h>
#include <string.h>
FILE *out_file;
int currPointer=0;

HashTable tabela;

void declaracao(int tamanho, char* identficador, int value, int dim);
void fatal_error(char *s);
char* pushNumero(int numero);
char* pushVariavel(char* var);
char* pushArray1D(char* var, char* expCod);
char* pushArray2D(char* var, char* expCod1, char* expCod2);


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
%type <var>OpAdd
%type <var>OpMul
%type <var>Expressao
%type <var>Valor
%type <var>Variavel
%type <var>Fator
%type <var>Termo

%%


Programa	: INICIO Declaracoes Body FIM
		;

Declaracoes	:
		| Declaracoes Declaracao
		;

Declaracao	: VAR id ';' 						{declaracao(1,$2,0,0);}
		| VAR id '=' numero ';' 				{declaracao(1,$2,$4,0);}
		| VAR id '[' num ']' ';' 				{declaracao($4,$2,0,1);}
		| VAR id '[' num ']''[' num ']'  ';'	{declaracao(($4*$7),$2,0,2);}
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

Expressao	: Termo								{ $$=$1; }
		| Expressao OpAdd Termo			{ }
		;

OpAdd		: '+'		{ $$="\tADD\n"; }
		| '-'				{ $$="\tSUB\n"; }
		| AND				{ $$="\tMUL\n"; } //multiplica os valor e tem de ser igual a 1 para ser verdade
		| OR				{ $$="\tADD\n"; }
		;

Termo 		: Fator
		| Termo OpMul Fator
		;

Fator		: Valor						{ $$=$1; }
		| '(' Expressao ')'		{ $$ = $2; }
		;


OpMul		: '*'		{ $$="\tMUL\n"; }
		| '/'				{ $$="\tDIV\n"; }
		| '%'				{ $$="\tMOD\n"; }
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

Valor		: numero		{ $$ = pushNumero($1);}
		| Variavel			{ $$=$1; }
		;

Variavel	: id																	{ $$ = pushVariavel($1); }
		| id '[' Expressao ']'											{ $$ = pushArray1D($1,$3); }
		| id '[' Expressao ']''[' Expressao ']'			{ $$ = pushArray2D($1,$3,$6); }
		;

%%
#include "lex.yy.c"


void fatal_error(char *s){
    yyerror(s);
    fclose(out_file);
    exit(0);
}

char* pushNumero(int numero){
	char instrucao[100];
	sprintf(instrucao,"\tPUSHI %d",numero);
	return strdup(instrucao);
}

char* pushVariavel(char* var){
	char operacao[20];
	Definition def;
	if((def = getVariavel(tabela,var,1))==NULL){
		fatal_error("Variavel não defenida"); //ver isto que dá erro
	}else{
		sprintf(operacao,"PUSHG %d\n",def->var->addr);
	}
	return strdup(operacao);
}


char* pushArray1D(char* var, char* expCod){
	char operacao[100];
	Definition def;
	if((def = getVariavel(tabela,var,1))==NULL){
		fatal_error("Variavel não defenida");
	}else{
		sprintf(operacao,"%s PUSHG %d\n ADD\n PUSHG",expCod, def->var->addr);
	}
	return strdup(operacao);
}
char* pushArray2D(char* var, char* expCod1, char* expCod2){
	//colei a de cima só para não dar erro
	char operacao[100];

	return strdup(operacao);
}

void declaracao(int tamanho, char* identficador, int value, int dim){
	char* name =strdup(identficador);

	if(getVariavel(tabela,name,1)!=NULL){
        fatal_error("Multiple variable definitions");
    }
    else{
    	Definition def1 = (Definition)malloc(sizeof(struct definition));
		def1->name=name;
		def1->type=1;
		def1->var = (Variavel)malloc(sizeof(struct variavel));
		def1->var->addr=currPointer;
		def1->var->dim= dim;
		def1->var->size=tamanho;
		insertVariavel(tabela,def1);
        if(tamanho>0){
            fprintf(out_file,"PUSHN %d\n", tamanho);
            currPointer+= tamanho;
        }
        else{
        	if(value!=0){
        		fprintf(out_file,"PUSHI %d\n",value);
        	}else{
        		fprintf(out_file,"PUSHI 0\n");
        	}
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
	tabela = createHashTable();
	yyparse();
	return 0;
}
