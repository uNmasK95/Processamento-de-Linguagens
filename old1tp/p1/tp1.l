%{
#include <stdio.h>
#include <string.h>
char*  nomes[30];
int cont[30];

void addRegisto(char* nome){
	int found=0;
	int i;
	for(i=0;i<30 && nomes[i]!=NULL && found==0;i++){
		if(!strcmp(nomes[i],nome)){
			found=1;
			cont[i]++;
		}
	}
	if(nomes[i]==NULL && found==0){
		nomes[i] = strdup(nome);
		cont[i]++;
	}
}

%}

%%
^@[A-Za-z]+ {addRegisto(yytext+1);}
.|\n 	{;}

%%
int yywrap() {return 1;}
int main(){
	//
	for(int i=0;i<30;i++){
		nomes[i]=NULL;
		cont[i]=0;
	}
	printf("Vou começar\n");
	yylex();

	FILE* fp =fopen("teste.html","w");

	fprintf(fp, "<html>\n<head>\n<title>EXERCICIO 1</title></head><body>\n <h2>Lista Exercico 1</h2>\n<ul>\n");

	for(int i=0;i<30 && nomes[i]!=NULL ;i++){

		fprintf(fp, "<li> %s -> %d </li>\n", nomes[i],cont[i]);
	}
	
	fprintf(fp, "</ul>\n</html>\n");
	printf("Acabei a lista\n");
	fclose(fp);

	return 0;
}
