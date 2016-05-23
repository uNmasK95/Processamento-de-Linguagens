/*Linguagem de programção ROJ*/

%{
#include "hashtable.h"
#include <stdio.h>
#include <string.h>
FILE *out_file;
int currPointer=0;
int currPointerFuntion=0;

HashTable tabela;
HashTable tabelaFuntion;


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
char* condicional(char* cond);
char* ciclo(char* cond);
char* concat(char* exp1, char* exp2);
char* concatGlobal();
void push(char* inst);
char* pop();

void declaracaoFunction(char* nameFuntion, int retorno);
void functionProcedure(char* name);
void addArg(char* arg);
void initArgsFuntions();
char* makeCallFunction(char* nameFuntion);

int loadADDR=0;
int labelIF=0;
int labelWHILE=0;

char* stackStrings[30];
int aminhamentoNumeroInst[30];
int nivel=0;
int aninhamento=0;


//Functions
char* argsFuntions[10];
int argcFunctions=0;
int makeFunction=0; //diz-nos se estamos a escrever uma função

%}

%union{int val; char* var;}

%token INICIO FIM
%token INSTINICIO INSTFIM
%token VAR
%token SE ENTAO SENAO FIMSE
%token ENQUANTO FIMENQUANTO
%token IMPRIMIR LER
%token DIFF GG LL GE LE EQ AND OR NOT
%token VOID FUNCTION FIMFUNCTION CALL

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

//funçoes
%type <val>Return

%%


Programa	: INICIO Declaracoes Functions Body FIM
		;

Declaracoes	:
		| Declaracoes Declaracao
		;

Declaracao	: VAR id ';' 									{ declaracao(1,$2,0,0); }
		| VAR id '=' numero ';' 							{ declaracao(1,$2,$4,0); }
		| VAR id '[' num ']' ';' 							{ declaracao($4,$2,0,1); }
		| VAR id '[' num ']''[' num ']'  ';'	{ declaracao(($4*$7),$2,0,$4); }
		;

//assumir que não existe argumentos por enquanto

Functions	:
		| Return FUNCTION id '(' ')' { declaracaoFunction($3,$1); makeFunction=1; aninhamento++; } Declaracoes Instrucoes FIMFUNCTION		{ functionProcedure($3); makeFunction=0; tabelaFuntion = createHashTable(); }
		;

Return	:				{ $$=1; }		//caso não tenha nada o retorno é um inteiro
			| VOID 		{ $$=0; }   //não existe return
			;

Body 		:
		| INSTINICIO { fprintf(out_file,"start\n"); } Instrucoes INSTFIM { fprintf(out_file, "%s", concatGlobal()); fprintf(out_file,"stop\n"); }
		;

Instrucoes	:	{;}
		| Instrucoes Instrucao	{ push($2); aminhamentoNumeroInst[aninhamento]++; }
		;

Instrucao 	: Atribuicao		{ $$ = $1; }
		| Condicional						{ $$ = $1; }
		| Input									{ $$ = $1; }
		| Output								{ $$ = $1; }
		| Ciclo									{ $$ = $1; }
		| CALL id '('  ')' ';'	{ $$ = makeCallFunction($2); }
		;

Atribuicao 	: Endereco '=' Condicao ';'		{ $$ = atribuicao($1,$3); }
		;

Condicao	: Expressao							{ $$ = $1; }
		| Expressao OpLog Expressao		{ $$ = operacao($1,$2,$3); }
		| NOT Expressao								{ $$ = operacao($2,"\tnot\n",""); }
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
		| CALL id '('  ')'					{ /*só primitido chamar aqui as funçoes com return de variavel*/}
		;


OpMul		: '*'		{ $$ = "\tmul\n"; }
		| '/'				{ $$ = "\tdiv\n"; }
		| '%'				{ $$ = "\tmod\n"; }
		;

Condicional	: SE '(' Condicao ')' ENTAO { aninhamento++; } Instrucoes SENAO { aninhamento++; } Instrucoes FIMSE				{ $$=condicional($3); }
		;

Ciclo	: ENQUANTO '(' Condicao ')' ENTAO { aninhamento++; } Instrucoes FIMENQUANTO							{ $$=ciclo($3); }
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

void push(char* inst){
	stackStrings[nivel++]=strdup(inst);
}

char* pop(){
	char* aux = strdup(stackStrings[--nivel]);
	stackStrings[nivel]=NULL;
	return aux;
}

char* makeCallFunction(char* nameFuntion){
	char* name = strdup(nameFuntion);
	char instrucao[1000];
	Definition def;

	if((def = getDefinition(tabela,name,0))==NULL){
        fatal_error("Function not exist. Need to be declared");
    }else{
			sprintf(instrucao,"\tcall %s\n",def->func->label);
	  }
	return strdup(instrucao);
}

void functionProcedure(char* name){
	char instrucoesFuncao[100000];
	char* nameNew = strdup(name);
	int i,nInst;
	//mudar isto para fprintf tudo
	//label já foi colocada e as declarações tambem por isso é só realizar o print das isntruçoes e depois o return
	nInst = aminhamentoNumeroInst[aninhamento];
	for(i=0;i<nInst;i++){
		char* aux = strdup(instrucoesFuncao);
		sprintf(instrucoesFuncao,"%s%s",pop(),aux);
	}

	fprintf(out_file,"%s\treturn\n",instrucoesFuncao);

	aminhamentoNumeroInst[aninhamento]=0;
	aninhamento--;
}

void addArg(char* arg){
	argsFuntions[argcFunctions++]=strdup(arg);
}


void fatal_error(char *s){
    yyerror(s);
    fclose(out_file);
    exit(0);
}

char* concatGlobal(){
	char instrucao[1000000];
	int i;
	instrucao[0]='\0';
	for(i=0;i<nivel;i++){
		sprintf(instrucao,"%s%s",instrucao,stackStrings[i]);
	}
	return strdup(instrucao);
}

char* concat(char* exp1, char* exp2){
	char instrucao[1000000];
	sprintf(instrucao,"%s%s",exp1,exp2);
	return strdup(instrucao);
}

char* condicional(char* cond){
	char instrucao[1000000];
	char then[10000];
	char ifELSE[10000];
	int i, nInst;

	then[0]='\0';
	ifELSE[0]='\0';


	nInst = aminhamentoNumeroInst[aninhamento];
	for(i=0;i<nInst;i++){
		char* aux = strdup(ifELSE);
		sprintf(ifELSE,"%s%s",pop(),aux);
	}
	aminhamentoNumeroInst[aninhamento]=0;
	aninhamento--;


	nInst = aminhamentoNumeroInst[aninhamento];
	for(i=0;i<nInst;i++){
		char* aux = strdup(then);
		sprintf(then,"%s%s",pop(),aux);
	}
	aminhamentoNumeroInst[aninhamento]=0;
	aninhamento--;

	sprintf(instrucao,"%s\tjz labelif%d\n%s\tjump labelIFfim%d\nlabelif%d:\n%slabelIFfim%d:\n",cond,labelIF,then,labelIF,labelIF,ifELSE,labelIF);
	labelIF++;
	return strdup(instrucao);
}

char* ciclo(char* cond){
	char instrucao[1000000];
	char then[10000];
	int i, nInst;

	then[0]='\0';
	nInst = aminhamentoNumeroInst[aninhamento];
	for(i=0;i<nInst;i++){
		char* aux = strdup(then);
		sprintf(then,"%s%s",pop(),aux);
	}

	sprintf(instrucao,"labelWH%d:\n%s\tjz labelWHfim%d\n%s\tjump labelWH%d\nlabelWHfim%d:\n",labelWHILE,cond,labelWHILE,then,labelWHILE,labelWHILE);
	labelWHILE++;
	aminhamentoNumeroInst[aninhamento]=0;
	aninhamento--;
	return strdup(instrucao);
}


void initArgsFuntions(){
	int i;
	for(i=0;i>argcFunctions;i++){
		argsFuntions[i]=NULL;
	}
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

	if(makeFunction==1){ //estamos a defenir variaveis de uma função
		def = getDefinition(tabelaFuntion,var,1);
	}else{ //varaivel global
		def = getDefinition(tabela,var,1);
	}

	if(def==NULL){
		fatal_error("Variavel não defenida"); //ver isto que dá erro
	}else{
		if( loadADDR==1 ) { //para colocar na stack o endereço
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

	if(makeFunction==1){ //estamos a defenir variaveis de uma função
		def = getDefinition(tabelaFuntion,var,1);
	}else{ //varaivel global
		def = getDefinition(tabela,var,1);
	}

	if(def==NULL){
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

	if(makeFunction==1){ //estamos a defenir variaveis de uma função
		def = getDefinition(tabelaFuntion,var,1);
	}else{ //varaivel global
		def = getDefinition(tabela,var,1);
	}

	if( def==NULL ){
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
			fprintf(out_file,"%s", label);
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


void init(){
	int i,max=30;
	for(i=0;i<30;i++){
		stackStrings[i]=NULL;
		aminhamentoNumeroInst[i]=0;
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
