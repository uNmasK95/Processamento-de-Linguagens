%{
#include <stdio.h>
#include <string.h>
char*  nomes[14];
int cont[14];

void addRegisto(char* nome){
	int found=0;
	int i;
	for(i=0;i<14 && nomes[i]!=NULL && found==0;i++){
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
^@[A-Za-z]+[{] {addRegisto(yytext+1);}
91[0-9]{7} {printf("%s\n",yytext);}
.|\n 	{;}

%%
int yywrap() {return 1;}
int main(){
	for(int i=0;i<14;i++){
		nomes[i]=NULL;
		cont[i]=0;
	}
	printf("Vou começar\n");
	/*addRegisto("OLA");
	addRegisto("OLA");
	addRegisto("OLA");
	addRegisto("OLA");
	addRegisto("OLA1");
	addRegisto("OLA2");*/
	for(int i=0;i<14;i++){
		printf("%s_%d\n",nomes[i],cont[i]);
		//cont[i]=0;
	}
	//yylex();
	return 0;
}
