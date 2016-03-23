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

author[ ]*=[ ]*[\"] 										{numeroAutores=0;tot=0;n=0; BEGIN(author);}
<author>[A-Za-z\\\.'\{\}\~]+\"?[A-Za-z\\\.'\{\}\~]+			{a[tot]=strdup(yytext);n++;tot++;}
<author>" and "												{numeroNomesAutores[numeroAutores]=n;numeroAutores++;n=0;}					
<author>,													{numeroNomesAutores[numeroAutores]=n;numeroAutores++;n=0;}
<author>\",													{BEGIN(INITIAL);
																char** aux = a;
																char* autor; 
																int i,j,f=numeroNomesAutores[0];
																
																for(i=0; i<=numeroAutores;i++){
																	if(numeroAutores==0){
																			printf("\tauthor = {%c. %s},\n",aux[0][0],aux[numeroNomesAutores[i]-1]);
																		}else{
																			if(i==0){
																				printf("\tauthor = {%c. %s, ",aux[0][0],aux[numeroNomesAutores[i]-1]);
																			}else{
																				if(i==numeroAutores-1){
																					printf("%c. %s and ",aux[0][0],aux[numeroNomesAutores[i]-1]);
																					}else{
																						if(i==numeroAutores){
																							printf("%c. %s},\n",aux[0][0],aux[numeroNomesAutores[i]]);
																							}else{
																								printf("%c. %s, ",aux[0][0],aux[numeroNomesAutores[i]-1]);
																							}
																					}
																			}
																			//printf("Nn=%d\n",numeroNomesAutores[i]);
																			aux=aux+numeroNomesAutores[i];
																		}
																	
																	
																}
																/*
																for(i=0;i<tot;i++){
																	printf("%s\n",a[i]);
																}*/
									
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

