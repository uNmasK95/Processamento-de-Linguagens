%{
#include <stdio.h>
#include <string.h>


char* a[500]; 
int n=0;
int tot=0;
int numeroAutores=0;
int numeroNomesAutores[100];
char lixo[5000];
int bool=0;

int titleBOOL=0;
%}




%x author categoria title
%%


<author>[A-Za-z(\\\")/\\\.'\{\}\~\-\´\`]+\"?[A-Za-z/\\\.'\{\}\~\-\´\`]+			{
																a[tot]=strdup(yytext);
																n++;tot++;
															}
<author>[ ]+"and"[ ]+										{
																numeroNomesAutores[numeroAutores]=n;
																numeroAutores++;
																n=0;
															}					
<author>[ ]+"and"[ ]*\n?[ ]*								{
																numeroNomesAutores[numeroAutores]=n;
																numeroAutores++;
																n=0;
															}	
<author>[ ]*\n[ ]*"and"[ ]+									{
																numeroNomesAutores[numeroAutores]=n;
																numeroAutores++;
																n=0;
															}

<author>[ ]*,[ ]*											{
																numeroNomesAutores[numeroAutores]=n;
																numeroAutores++;
																n=0;
															}
<author>[ ]*[\"\}],												{
																BEGIN(categoria);
																char** aux = a;
																char* autor; 
																int i,j;
																
																numeroNomesAutores[numeroAutores]=n;

																for(i=0; i<=numeroAutores;i++){
																	if(numeroAutores==0){
																			printf("author = {%c. %s},\n",aux[0][0],aux[numeroNomesAutores[i]-1]);
																		}else{
																			if(i==0){
																				printf("author = {%c. %s,\n",aux[0][0],aux[numeroNomesAutores[i]-1]);
																			}else{
																				if(i==numeroAutores-1){
																					printf("    %c. %s and\n",aux[0][0],aux[numeroNomesAutores[i]-1]);
																					}else{
																						if(i==numeroAutores){
																							printf("    %c. %s},\n",aux[0][0],aux[numeroNomesAutores[i]-1]);
																							}else{
																								printf("    %c. %s,\n",aux[0][0],aux[numeroNomesAutores[i]-1]);
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
@[A-Za-z]+\{[A-Za-z0-9\:]+,									{BEGIN(categoria); printf("%s\n",yytext);tot=0;titleBOOL=0;}
<categoria>[Aa][Uu][Tt][Hh][Oo][Rr][ ]*=[ ]*[\"\{]			{numeroAutores=0;tot=0;n=0; BEGIN(author);}
<categoria>[Tt][Ii][Tt][Ll][Ee][ ]*=[ ]*[\"]				{BEGIN(title); printf("    title = {");}
<categoria>\}\n 											{BEGIN(INITIAL);printf("}\n");}
<title>.*\",? 												{if(yytext[strlen(yytext)-1]==','){
																yytext[strlen(yytext)-2]='}';
																} else{
																	yytext[strlen(yytext)-1]='}';
																}
																printf("%s",yytext); titleBOOL=1; BEGIN(categoria);
															}
<categoria>[Aa][Uu][Tt][Hh][Oo][Rr][ ]*=[ ]*[\{]			
															{
																tot=1;
																printf("%s",yytext);
															}
<categoria>[Tt][Ii][Tt][Ll][Ee][ ]*=[ ]*[\{] 				{
																printf("Teste:%s",yytext);
																titleBOOL=1;
															}


<categoria>[ ]*=[ ]*\"										{printf(" = {");}
<categoria>\",												{printf("},");}
<categoria>\"\n												{printf("}\n");}
<categoria>.|\n 											{if(titleBOOL && tot>=1 ){
																if(!bool){
																	printf("%s%s",lixo,yytext);
																	bool=1;
																	}else{
																		printf("%s",yytext);
																	} 
															 }else{
															 	strcat(lixo,yytext);
															 	} 
															}
\n 															{printf("%s",yytext);}
%%

int yywrap() {return 1;}
int main(){

	yylex();

	return 0;
}

