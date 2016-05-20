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
char* ler(char* op);
char* imprimir(char* op);
char* operacao(char* exp1, char* op, char* exp2);
char* atribuicao(char* var, char* val);
char* condicional(char* cond, char* then, char* els);
char* ciclo(char* cond, char* inst);
char* concat(char* exp1, char* exp2);
char* concatGlobal(char* exp);
int loadADDR=0;
int labelIF=0;
int labelWHILE=0;
char instGlobal[200000];

char* stackStrings[30];
int nivel=0;


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

%type <val>numero
%type <var>OpAdd
%type <var>OpMul
%type <var>Expressao
%type <var>Valor
%type <var>Variavel
%type <var>Fator
%type <var>Termo
%type <var>Output
%type <var>Input
%type <var>Endereco Instrucao Atribuicao OpLog Condicao Condicional Ciclo
%type <var>Instrucoes
%%


Programa	: INICIO Declaracoes Body FIM
		;

Declaracoes	:
		| Declaracoes Declaracao
		;

Declaracao	: VAR id ';' 									{ declaracao(1,$2,0,0); }
		| VAR id '=' numero ';' 							{ declaracao(1,$2,$4,0); }
		| VAR id '[' num ']' ';' 							{ declaracao($4,$2,0,1); }
		| VAR id '[' num ']''[' num ']'  ';'	{ declaracao(($4*$7),$2,0,$4); }
		;

Body 		:
		| INSTINICIO { fprintf(out_file,"start\n"); } Instrucoes INSTFIM { fprintf(out_file, "%s", instGlobal); fprintf(out_file,"stop\n"); }
		;

Instrucoes	:
		| Instrucoes Instrucao	{ $$=concatGlobal($2); }
		;

Instrucao 	: Atribuicao		{ $$ = $1; }
		| Condicional						{ $$ = $1; }
		| Input									{ $$ = $1; }
		| Output								{ $$ = $1; }
		| Ciclo									{ $$ = $1; }
		;

Atribuicao 	: Endereco '=' Condicao ';'		{ $$ = atribuicao($1,$3); }
		;

Condicao	: Expressao							{ $$ = $1; }
		| Expressao OpLog Expressao		{ $$ = operacao($1,$2,$3); }
		| NOT Expressao								{ $$ = operacao($2,"\tNOT\n",""); }
		;


OpLog		: AND				{ $$="\tmul\n"; } //multiplica os valor e tem de ser igual a 1 para ser verdade
		| OR						{ $$="\tadd\n"; }
		;

Expressao	: Termo								{ $$ = $1; }
		| Expressao OpAdd Termo			{ $$ = operacao($1,$2,$3); }
		;

OpAdd		: '+'		{ $$="\tadd\n"; }
		| '-'				{ $$="\tsub\n"; }
		| DIFF			{ $$ = "\tequal\n\tnot\n";}
		| GG				{ $$ = "\tsup\n"; }
		| LL				{ $$ = "\tinf\n"; }
		| GE				{ $$ = "\tsupeq\n"; }
		| LE				{ $$ = "\tinfeq\n"; }
		| EQ				{ $$ = "\tequal\n"; }
		;

Termo 		: Fator							{ $$ = $1;}
		| Termo OpMul Fator				{ $$ = operacao($1,$2,$3); }
		;

Fator		: Valor						{ $$ = $1; }
		| '(' Expressao ')'		{ $$ = $2; }
		;


OpMul		: '*'		{ $$ = "\tmul\n"; }
		| '/'				{ $$ = "\tdiv\n"; }
		| '%'				{ $$ = "\tmod\n"; }
		;

Condicional	: SE '(' Condicao ')' ENTAO Instrucoes SENAO Instrucoes FIMSE				{ $$=condicional($3,$6,$8); }
		;

Ciclo 		: ENQUANTO '(' Condicao ')' ENTAO Instrucoes FIMENQUANTO							{ $$=ciclo($3,$6); }
		;

Input		: LER Endereco ';'		{ $$ = ler($2); }
		;

Output 		: IMPRIMIR Valor ';'	{ $$ = imprimir($2); }
		;

numero 		: num 		{ $$=$1; }
		| '-' num 			{ $$=-1*$2; }
		;

Valor		: numero		{ $$ = pushNumero($1);}
		| Variavel			{ $$=$1; }
		;

Endereco	: id																	{ loadADDR = 1; $$ = pushVariavel($1); loadADDR=0;}
		| id '[' Expressao ']'											{ loadADDR = 1; $$ = pushArray1D($1,$3); loadADDR=0; }
		| id '[' Expressao ']''[' Expressao ']'			{ loadADDR = 1; $$ = pushArray2D($1,$3,$6); loadADDR=0; }
		;


Variavel	: id																	{ $$ = pushVariavel($1); }
		| id '[' Expressao ']'											{ $$ = pushArray1D($1,$3); }
		| id '[' Expressao ']''[' Expressao ']'			{ $$ = pushArray2D($1,$3,$6); }
		;

%%
#include "lex.yy.c"

push(char* inst){
	stackStrings[nivel++;]=strdup(inst);
}

char* pop(){
	return strdup(stackStrings[nivel--]);
}


void fatal_error(char *s){
    yyerror(s);
    fclose(out_file);
    exit(0);
}

char* concatGlobal(char* exp){
	sprintf(instGlobal,"%s%s",instGlobal,exp);
	return strdup(instGlobal);
}

char* concat(char* exp1, char* exp2){
	char instrucao[1000000];
	sprintf(instrucao,"%s%s",exp1,exp2);
	return strdup(instrucao);
}

char* condicional(char* cond, char* then, char* els){
	char instrucao[1000000];
	sprintf(instrucao,"%s\tjz labelif%d\n%s\tjumb labelfim%d\nlabelif%d:\n%slabelfim%d:\n",cond,labelIF,then,labelIF,labelIF,els,labelIF);
	labelIF++;
	return strdup(instrucao);
}
char* ciclo(char* cond, char* inst){
return NULL;
}

char* atribuicao(char* var, char* val){
	char instrucao[10000];
	sprintf(instrucao,"%s%s\tstore 0\n",var,val);
	return strdup(instrucao);
}

char* operacao(char* exp1, char* op, char* exp2){
	char instrucao[10000];
	sprintf(instrucao,"%s%s%s",exp1,exp2,op);
	return strdup(instrucao);
}

char* imprimir(char* op){
	char instrucao[10000];
	sprintf(instrucao,"%s\twritei\n",op);
	return strdup(instrucao);
}

//" READ ATOI STOR"
char* ler(char* op){
	char instrucao[1000];
	sprintf(instrucao,"%s\tread\n\tatoi\n\tstore 0\n",op);
	return strdup(instrucao);
}

char* pushNumero(int numero){
	char instrucao[100];
	sprintf(instrucao,"\tpushi %d\n",numero);
	return strdup(instrucao);
}

char* pushVariavel(char* var){
	char operacao[100];
	Definition def;
	if((def = getVariavel(tabela,var,1))==NULL){
		fatal_error("Variavel não defenida"); //ver isto que dá erro
	}else{
		if(loadADDR==1){
			//para colocar na stack o endereço
			sprintf(operacao,"\tpushgp\n\tpushi %d\n\tpadd\n",def->var->addr);
		}else{
			sprintf(operacao,"\tpushg %d\n",def->var->addr);
		}
	}
	return strdup(operacao);
}


char* pushArray1D(char* var, char* expCod){
	char operacao[1000];
	Definition def;
	if((def = getVariavel(tabela,var,1))==NULL){
		fatal_error("Variavel não defenida");
	}else{
		if(loadADDR==1){
			sprintf(operacao,"\tpushgp\n\tpushi %d\n\tpadd\n%s\tpadd\n",def->var->addr,expCod);
		}else{
			sprintf(operacao,"\tpushgp\n\tpushi %d\n\tpadd\n%s\tloadn\n",def->var->addr,expCod);
		}
	}
	return strdup(operacao);
}
//Isto não está bem ver melhor isto
char* pushArray2D(char* var, char* expCod1, char* expCod2){
	//colei a de cima só para não dar erro
	char operacao[1000];
	Definition def;
	if((def = getVariavel(tabela,var,1))==NULL){
		fatal_error("Variavel não defenida");
	}else{
		if(loadADDR==1){
			sprintf(operacao,"\tpushgp\n\tpushi %d\n\tpadd\n%s\tpushi %d\n\tmul\n%s\tadd\n\tpadd\n",def->var->addr,expCod1,(def->var->size/def->var->dim),expCod2);
		}else{
			sprintf(operacao,"\tpushgp\n\tpushi %d\n\tpadd\n%s\tpushi %d\n\tmul\n %s\tadd\n\tloadn\n",def->var->addr,expCod1,(def->var->size/def->var->dim),expCod2);
		}
	}
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
    if(tamanho>1){
        fprintf(out_file,"\tpushn %d\n", tamanho);
        currPointer+= tamanho;
    }
    else{
    		fprintf(out_file,"\tpushi %d\n",value);
        currPointer++;
    }
  }
}


int yyerror(char * mensagem) {
	printf("Erro Sintático %s\n", mensagem);
	return 0;
}

int main(int argc, char** argv) {
	if(argc>=1){
		instGlobal[0]='\0';
		out_file = fopen(argv[1],"w");
		tabela = createHashTable();
		yyparse();
	}else{
		printf("Nessecita de introduzir o ficheiro.roj\n");
	}
	return 0;
}
