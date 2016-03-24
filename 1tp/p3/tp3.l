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

%}




%x author categoria graf
%%


<author>[A-Za-z\\\.'\{\}\~]+\"?[A-Za-z\\\.'\{\}\~]+			{a[tot]=strdup(yytext);n++;tot++;}
<author>" and "												{numeroNomesAutores[numeroAutores]=n;numeroAutores++;n=0;}					
<author>[ ]													{;}
<author>[ ]*,[ ]*													{numeroNomesAutores[numeroAutores]=n;numeroAutores++;n=0;}
<author>[ ]*\",													{
																numeroNomesAutores[numeroAutores]=n;n=0;
																BEGIN(categoria);
																char** aux = a;
																char* autor; 

																
																FILE* fp = fopen("graf.dot","a+");

																char buf[100];
																int i,j,f=numeroNomesAutores[0];

																for(i=0; i<=numeroAutores;i++){
																	sprintf(buf,"%c. %s",aux[0][0],aux[numeroNomesAutores[i]-1]);
																	new[i]=strdup(buf);																	
																	aux=aux+numeroNomesAutores[i];
																}

																for(i=0;i<=numeroAutores;i++){
																	for(j=0;j<=numeroAutores;j++){
																		if(i!=j){
																			sprintf(buf,"\t\"%s\" -- \"%s\";\n",new[i],new[j]);
																			fprintf(fp,"%s",buf);

																			if(!strcmp(new[i],authorProcura)){
																				authorParceria[nParceiros]=strdup(new[j]);
																				nParceiros++;
																			}
																		}

																	}
																}
																fclose(fp);
															}
@[A-Za-z]+\{[A-Za-z0-9]+,[ ]*									{BEGIN(categoria);tot=0;}
<categoria>author[ ]*=[ ]*[\"] 								{numeroAutores=0;tot=0;n=0; BEGIN(author);}
<categoria>.|\n												{;}
<categoria>\}\n 											{BEGIN(INITIAL);}
.|\n 														{;}
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

	yylex();
	
	fp = fopen("graf.dot","a+");
	fprintf(fp,"}");
	fclose(fp);
	int j;
	for(j=0;j<nParceiros;j++){
		printf("PARCEIROS: %s\n",authorParceria[j]);
	}

	return 0;
}