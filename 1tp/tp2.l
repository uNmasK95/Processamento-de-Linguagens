%{
#include <stdio.h>
#include <string.h>


char* a[500]; 
int n=0;
int tot=0;
int numeroAutores=0;
int numeroNomesAutores[100];
%}




%x author
%%

author[ ]*=[ ]*[\"] 										{printf("Estou\n");numeroAutores=0;tot=0;n=0; BEGIN(author);}
<author>[A-Za-z\\\.'\{\}\~]+\"?[A-Za-z\\\.'\{\}\~]+			{a[tot]=strdup(yytext);n++;tot++;}
<author>" and "												{numeroNomesAutores[numeroAutores]=n;numeroAutores++;n=0;}					
<author>,													{numeroNomesAutores[numeroAutores]=n;numeroAutores++;n=0;}
<author>\",													{BEGIN(INITIAL);
																int i,j,f=numeroNomesAutores[0];
																for(i=0,j=0;i<tot;i++){
																	
																	printf("%s_", a[i]);
																	if(i==f-1){
																		f+=numeroNomesAutores[j];
																		j++;
																		printf("\n");
																	}
																}
															}
<author>.|\n 												{;}
.|\n 	{;}
%%

int yywrap() {return 1;}
int main(){
	printf("Vou começar\n");
	yylex();
	printf("Acabei \n");

	return 0;
}

