%{
#include <stdio.h>
#include <string.h>

#include <unistd.h>     /* chamadas ao sistema: defs e decls essenciais */
#include <fcntl.h>


char* a[500]; 
int n=0;
int tot=0;
int numeroAutores=0;
int numeroNomesAutores[100];
int bool=0;
char* new[1000];


int nParceiros=0;
char* authorParceria[100];
char* authorProcura;

void registaAuthors(){
	int i,j;
	char** aux = a;
	char buf[100];
	numeroNomesAutores[numeroAutores]=n;
	FILE* fp = fopen("graf.dot","a+");
	FILE* fpAuthor = fopen("grafAuthor.dot","a+");

	for(i=0; i<=numeroAutores;i++){
		//printf("%d\n",numeroNomesAutores[i]);
		if(numeroNomesAutores[i]==1){
			sprintf(buf,"%s",aux[0]);
		}else{
			sprintf(buf,"%c. %s",aux[0][0],aux[numeroNomesAutores[i]-1]);
		}
		new[i]=strdup(buf);					
		aux=aux+numeroNomesAutores[i];
	}
	for(i=0;i<=numeroAutores;i++){
		for(j=0;j<=numeroAutores;j++){
			if(i!=j){
				fprintf(fp,"\t\"%s\" -- \"%s\";\n",new[i],new[j]);
				if(!strcmp(new[i],authorProcura)){
					fprintf(fpAuthor,"\t\"%s\" -- \"%s\";\n",new[i],new[j]);
					authorParceria[nParceiros]=strdup(new[j]);
					nParceiros++;
				}
			}

		}
	}
	fclose(fp);
	fclose(fpAuthor);
	n=0;
}


%}

%x author categoria graf

%%
@[A-Za-z]+\{[A-Za-z0-9:\+]+,		{
										BEGIN(categoria);
										tot=0;
									}

<categoria>[Aa][Uu][Tt][Hh][Oo][Rr][ \t]*=[ \t]*[\"\{]  {
										BEGIN(author);
										numeroAutores=0;
										tot=0;n=0; 
									}

<author>[ ]+[Aa][Nn][Dd][ ]+			{
											numeroNomesAutores[numeroAutores]=n;
											numeroAutores++;
											n=0;
										}			
<author>[ ]+[Aa][Nn][Dd][ ]*\n?[ ]*		{
											numeroNomesAutores[numeroAutores]=n;
											numeroAutores++;
											n=0;
										}	
<author>[ ]*\n[ ]*[Aa][Nn][Dd][ ]+		{
											numeroNomesAutores[numeroAutores]=n;
											numeroAutores++;
											n=0;
										}

<author>\{[^ ,]+[^ \",(\",)\}]\}		{
											a[tot]=strdup(yytext);
											n++;tot++;
										}

<author>[^ ,]+[^ \",\}]					{	
											a[tot]=strdup(yytext);
											n++;tot++;
										}

<author>[ ]*[\"\}],?					{
											BEGIN(categoria);
											registaAuthors();						
										}

<author>.|\n							{;}

<categoria>.|\n							{;}
<categoria>\}\n 						{BEGIN(INITIAL);}
.|\n  									{;}

%%
int yywrap() {return 1;}
int main(int argc, char** argv){

	if(argc<=1){
		authorProcura=strdup("");
	}else{
		authorProcura=argv[1];
	}

	FILE* fp = fopen("graf.dot","a+");
	fprintf(fp,"strict graph authors {\n");
	fclose(fp);

	FILE* fpAuthor = fopen("grafAuthor.dot","a+");
	fprintf(fpAuthor,"strict graph authors {\n");
	fclose(fpAuthor);

	yylex();
	
	fp = fopen("graf.dot","a+");
	fprintf(fp,"}");
	fclose(fp);

	fpAuthor = fopen("grafAuthor.dot","a+");
	fprintf(fpAuthor,"}");
	fclose(fpAuthor);

	return 0;
}
