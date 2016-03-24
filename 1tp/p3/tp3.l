%{
#include <stdio.h>
#include <string.h>


char* a[500]; 
int n=0;
int tot=0;
int numeroAutores=0;
int numeroNomesAutores[100];
int bool=0;
char* new[1000];

%}




%x author categoria
%%


<author>[A-Za-z\\\.'\{\}\~]+\"?[A-Za-z\\\.'\{\}\~]+			{a[tot]=strdup(yytext);n++;tot++;printf("%s\n",yytext);}
<author>" and "												{numeroNomesAutores[numeroAutores]=n;numeroAutores++;n=0;}					
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
																		}
																	}
																}
																fclose(fp);


															}
@[A-Za-z]+\{[A-Za-z0-9]+,									{BEGIN(categoria);tot=0;}
<categoria>author[ ]*=[ ]*[\"] 								{numeroAutores=0;tot=0;n=0; BEGIN(author);}
<categoria>.|\n												{;}
<categoria>\}\n 											{BEGIN(INITIAL);}
.|\n 														{;}
%%

int yywrap() {return 1;}
int main(){
	
	FILE* fp = fopen("graf.dot","a+");
	fprintf(fp,"strict graph authors {\n");
	fclose(fp);

	yylex();
	
	fp = fopen("graf.dot","a+");
	fprintf(fp,"}");
	fclose(fp);


	return 0;
}

