%{
#include <stdio.h>
#include <string.h>
#include <ctype.h>

char*  nomes[30];
int cont[30];

char* lowerCASE(char * str){
	int i;
	for(i = 0; str[i]!='\0'; i++){
  		str[i] = tolower(str[i]);
	}
	return str;
}

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
%x reservada
%%
^[ ]*@		{BEGIN(reservada);}
<reservada>[A-Za-z]+  {char* aux = lowerCASE(yytext);addRegisto(aux);BEGIN(INITIAL);}
.|\n 	{;}

%%
int yywrap() {return 1;}
int main(){
	int i;
	for(i=0;i<30;i++){
		nomes[i]=NULL;
		cont[i]=0;
	}
	yylex();

	FILE* fp =fopen("index.html","w");

	fprintf(fp, "<html>\n\t<head>\n\t\t<title>EXERCICIO 1</title>\n\t</head>\n\t<body>\n \t\t<h2>Lista Exercico 1</h2>\n\t\t\t<ul>\n");

	for(i=0;i<30 && nomes[i]!=NULL ;i++){

		fprintf(fp, "\t\t\t<li> %s -> %d </li>\n", nomes[i],cont[i]);
	}
	
	fprintf(fp, "\t\t\t</ul>\n\t</body>\n</html>\n");
	fclose(fp);

	return 0;
}
