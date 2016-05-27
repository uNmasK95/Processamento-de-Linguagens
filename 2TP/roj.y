/*Linguagem de programção ROJ*/

%{
#include "hashtable.h"
#include <stdio.h>
#include <string.h>
FILE *out_file;
int currPointer=0;

HashTable tabela;
HashTable tabelaFuntion;


void declaracao(int tamanho, char* identficador, int value, int dim);
void fatal_error(char *s);
char* pushNumero(int numero);
char* pushVariavel(char* var);
char* pushArray1D(char* var, char* expCod);
char* pushArray2D(char* var, char* expCod1, char* expCod2);
void ler(char* op);
void imprimir(char* op);
char* operacao(char* exp1, char* op, char* exp2);
char* atribuicao(char* var, char* val);


void declaracaoFunction(char* nameFuntion, int retorno);
void functionCall(char* nameFuntion, int needReturn);

void endCiclo();
void initCiclo();
void thenCiclo();

void initIF();
void thenIF();
void elseIF();
void endIF();

int loadADDR=0;

//Functions

int makeFunction=0; //diz-nos se estamos a escrever uma função

int stackLabels[10000];
int stackNivel=0;
int createLabelNum=0;


%}

%union{int val; char* var;}

%token INICIO FIM
%token INSTINICIO INSTFIM
%token VAR
%token SE ENTAO SENAO FIMSE
%token ENQUANTO FIMENQUANTO
%token IMPRIMIR LER
%token DIFF GG LL GE LE EQ AND OR NOT
%token VOID FUNCTION FIMFUNCTION RETURN

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
%type <var>Endereco Atribuicao OpLog Condicao Condicional Ciclo

//funçoes
%%


Programa	: INICIO Declaracoes { fprintf(out_file,"\tjump main\n"); } Functions Body FIM
		;

Declaracoes	:
		| Declaracoes Declaracao
		;

Declaracao	: VAR id ';' 									{ declaracao(1,$2,0,0); }
		| VAR id '=' numero ';' 							{ declaracao(1,$2,$4,0); }
		| VAR id '[' num ']' ';' 							{ declaracao($4,$2,0,1); }
		| VAR id '[' num ']''[' num ']'  ';'	{ declaracao(($4*$7),$2,0,$4); }
		;

Functions	:
		| Functions Function
		;

Function : FUNCTION id '('   ')' { currPointer=0; declaracaoFunction($2,1); makeFunction=1; } Declaracoes Instrucoes RETURN Expressao FIMFUNCTION { fprintf(out_file,"\treturn\n"); makeFunction=0; tabelaFuntion = createHashTable(); }
		| VOID FUNCTION id '('   ')' { currPointer=0; declaracaoFunction($3,0); makeFunction=1; } Declaracoes Instrucoes FIMFUNCTION { fprintf(out_file,"\treturn\n"); makeFunction=0; tabelaFuntion = createHashTable(); }
		| FUNCTION id '(' VAR id ',' VAR id ')' FIMFUNCTION 	{ fprintf(out_file, "Func Prof"); }
		| VOID FUNCTION id '(' VAR id ',' VAR id ')' FIMFUNCTION 	{ fprintf(out_file, "Func Prof sem return"); }
		;

Body	: INSTINICIO { fprintf(out_file,"start\nmain:\n"); } Instrucoes INSTFIM { fprintf(out_file,"stop\n"); }
		;

Instrucoes	:
		| Instrucoes Instrucao
		;

Instrucao 	: Atribuicao
		| Condicional
		| Input
		| Output
		| Ciclo
		| id '(' Args ')' ';'		{ functionCall($1,1); }
		;

Args :
		| Args Arg
		;

Arg : Expressao	{ fprintf(out_file,"%s",$1); }
		;

Atribuicao 	: Endereco { fprintf(out_file,"%s",$1); }'=' Condicao ';'		{ fprintf(out_file,"\tstore 0\n"); }
		;

Condicao	: Expressao							{ fprintf(out_file,"%s",$1); }
		| Expressao OpLog Expressao		{ fprintf(out_file,"%s%s%s",$1,$3,$2); }
		| NOT Expressao								{ fprintf(out_file, "%s\tnot\n",$2); }
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
		| id '(' Args ')'			{ functionCall($1,1); }
		;

OpMul		: '*'		{ $$ = "\tmul\n"; }
		| '/'				{ $$ = "\tdiv\n"; }
		| '%'				{ $$ = "\tmod\n"; }
		;

Condicional	: SE { initIF(); } '(' Condicao ')' ENTAO { thenIF(); } Instrucoes SENAO { elseIF(); } Instrucoes FIMSE	{ endIF(); }
					;

Ciclo	: ENQUANTO { initCiclo(); } '(' Condicao ')' { thenCiclo(); } ENTAO Instrucoes FIMENQUANTO	{ endCiclo(); }
			;

Input		: LER Endereco ';'		{ ler($2); }
		;

Output 		: IMPRIMIR Valor ';'	{ imprimir($2); }
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

void initIF(){
	stackLabels[stackNivel++]=createLabelNum; //fazer push para a stack de labels
	createLabelNum++;
}

void thenIF(){
	fprintf(out_file,"\tjz labelif%d\n",stackLabels[stackNivel-1]);
}

void elseIF(){
	fprintf(out_file,"\tjump labelIFfim%d\nlabelif%d:\n",stackLabels[stackNivel-1],stackLabels[stackNivel-1]);
}

void endIF(){
	fprintf(out_file,"labelIFfim%d:\n",stackLabels[stackNivel-1]);
	stackNivel--;
}

void initCiclo(){
	stackLabels[stackNivel++]=createLabelNum; //fazer push para a stack de labels
	fprintf(out_file,"labelWH%d:\n",stackLabels[stackNivel-1]);
	createLabelNum++;
}

void thenCiclo(){
	fprintf(out_file,"\tjz labelWHfim%d\n",stackLabels[stackNivel-1]);
}


void endCiclo(){
	fprintf(out_file,"\tjump labelWH%d\nlabelWHfim%d:\n",stackLabels[stackNivel-1],stackLabels[stackNivel-1]);
	stackNivel--;
}

void functionCall(char* nameFuntion, int needReturn){
	Definition def;
	if((def = getDefinition(tabela,nameFuntion,0))==NULL){
        fatal_error("Function not exist. Need to be declared");
    }else{
			if(needReturn==def->func->enableReturn==1){
				fprintf(out_file,"\tnop\n\tpusha %s\n\tcall\n",def->func->label);
			}else{
				if(needReturn==1){
					fatal_error("Function return a value. Call error");
				}else{
					fatal_error("Function not return a value. Call error");
				}
			}
	  }
}

void fatal_error(char *s){
    yyerror(s);
    fclose(out_file);
    exit(0);
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

void imprimir(char* op){
	fprintf(out_file, "%s\twritei\n",op);
}

//" READ ATOI STOR"
void ler(char* op){
	fprintf(out_file,"%s\tread\n\tatoi\n\tstore 0\n",op );
}

char* pushNumero(int numero){
	char instrucao[100];
	sprintf(instrucao,"\tpushi %d\n",numero);
	return strdup(instrucao);
}

char* pushVariavel(char* var){
	char operacao[100];
	Definition def;

	if(makeFunction==1){ //estamos a defenir variaveis de uma função
		def = getDefinition(tabelaFuntion,var,1);
		if(def==NULL){
			fatal_error("Variavel não defenida"); //ver isto que dá erro
		}else{
			if( loadADDR==1 ) { //para colocar na stack o endereço
				sprintf(operacao,"\tpushfp\n\tpushi %d\n\tpadd\n",def->var->addr);
			}else{
				sprintf(operacao,"\tpushl %d\n",def->var->addr);
			}
		}
	}else{ //varaivel global
		def = getDefinition(tabela,var,1);
		if(def==NULL){
			fatal_error("Variavel não defenida"); //ver isto que dá erro
		}else{
			if( loadADDR==1 ) { //para colocar na stack o endereço
				sprintf(operacao,"\tpushgp\n\tpushi %d\n\tpadd\n",def->var->addr);
			}else{
				sprintf(operacao,"\tpushg %d\n",def->var->addr);
			}
		}
	}



	return strdup(operacao);
}


char* pushArray1D(char* var, char* expCod){
	char operacao[1000];
	Definition def;

	if(makeFunction==1){ //estamos a defenir variaveis de uma função
		def = getDefinition(tabelaFuntion,var,1);
		if(def==NULL){
			fatal_error("Variavel não defenida");
		}else{
			if(loadADDR==1){
				sprintf(operacao,"\tpushfp\n\tpushi %d\n\tpadd\n%s\tpadd\n",def->var->addr,expCod);
			}else{
				sprintf(operacao,"\tpushfp\n\tpushi %d\n\tpadd\n%s\tloadn\n",def->var->addr,expCod);
			}
		}
	}else{ //varaivel global
		def = getDefinition(tabela,var,1);
		if(def==NULL){
			fatal_error("Variavel não defenida");
		}else{
			if(loadADDR==1){
				sprintf(operacao,"\tpushgp\n\tpushi %d\n\tpadd\n%s\tpadd\n",def->var->addr,expCod);
			}else{
				sprintf(operacao,"\tpushgp\n\tpushi %d\n\tpadd\n%s\tloadn\n",def->var->addr,expCod);
			}
		}
	}
	return strdup(operacao);
}
//Isto não está bem ver melhor isto
char* pushArray2D(char* var, char* expCod1, char* expCod2){
	//colei a de cima só para não dar erro
	char operacao[1000];
	Definition def;

	if(makeFunction==1){ //estamos a defenir variaveis de uma função
		def = getDefinition(tabelaFuntion,var,1);
		if( def==NULL ){
			fatal_error("Variavel não defenida");
		}else{
			if(loadADDR==1){
				sprintf(operacao,"\tpushfp\n\tpushi %d\n\tpadd\n%s\tpushi %d\n\tmul\n%s\tadd\n\tpadd\n",def->var->addr,expCod1,(def->var->size/def->var->dim),expCod2);
			}else{
				sprintf(operacao,"\tpushfp\n\tpushi %d\n\tpadd\n%s\tpushi %d\n\tmul\n %s\tadd\n\tloadn\n",def->var->addr,expCod1,(def->var->size/def->var->dim),expCod2);
			}
		}
	}else{ //varaivel global
		def = getDefinition(tabela,var,1);
		if( def==NULL ){
			fatal_error("Variavel não defenida");
		}else{
			if(loadADDR==1){
				sprintf(operacao,"\tpushgp\n\tpushi %d\n\tpadd\n%s\tpushi %d\n\tmul\n%s\tadd\n\tpadd\n",def->var->addr,expCod1,(def->var->size/def->var->dim),expCod2);
			}else{
				sprintf(operacao,"\tpushgp\n\tpushi %d\n\tpadd\n%s\tpushi %d\n\tmul\n %s\tadd\n\tloadn\n",def->var->addr,expCod1,(def->var->size/def->var->dim),expCod2);
			}
		}
	}
	return strdup(operacao);
}

void declaracaoFunction(char* nameFuntion, int retorno/*0 se for void 1 se nao tiver nada*/){
	char* name = strdup(nameFuntion);
	char label[100];
	if(getDefinition(tabela,name,0)!=NULL){
        fatal_error("Multiple funtions definitions");
    }else{
	    Definition def1 = (Definition)malloc(sizeof(struct definition));
			def1->name=name;
			def1->type=0; //dizer que é uma função
			def1->func = (Function)malloc(sizeof(struct function));
			sprintf(label,"labelFunction_%s",name);
			def1->func->label=strdup(label);
			def1->func->enableReturn=retorno;
			def1->func->argc=0;
			insertDefinition(tabela,def1);
			fprintf(out_file,"%s: nop\n", label);
	  }
}

void declaracao(int tamanho, char* identficador, int value, int dim){
	char* name =strdup(identficador);
	Definition def;

	if(makeFunction==1){ //estamos a defenir variaveis de uma função
		def = getDefinition(tabelaFuntion,name,1);
	}else{ //varaivel global
		def = getDefinition(tabela,name,1);
	}

	if(def!=NULL){
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
		if(makeFunction==1){
			insertDefinition(tabelaFuntion,def1);
		}else{
			insertDefinition(tabela,def1);
		}
		if(tamanho>1){
				fprintf(out_file,"\tpushn %d\n", tamanho);
				currPointer+= tamanho;
		}else{
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
	if(argc>=2){
		out_file = fopen(argv[1],"w");
		tabela = createHashTable();
		tabelaFuntion = createHashTable();
		yyparse();
	}else{
		printf("Nessecita de introduzir o ficheiro de output\n");
	}
	return 0;
}
