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
int authorBOOL=0;
%}

%x author categoria title
%%


<author>[ ]+[Aa][Nn][Dd][ ]+				{
								numeroNomesAutores[numeroAutores]=n;
								numeroAutores++;
								n=0;
							}					
<author>[ ]+[Aa][Nn][Dd][ ]*\n?[ ]*			{
								numeroNomesAutores[numeroAutores]=n;
								numeroAutores++;
								n=0;
							}	
<author>[ ]*\n[ ]*[Aa][Nn][Dd][ ]+			{
								numeroNomesAutores[numeroAutores]=n;
								numeroAutores++;
								n=0;
							}
<author>,						{
								numeroNomesAutores[numeroAutores]=n;
								numeroAutores++;
								n=0;
							}


<author>[^ ,]+[^ \",(\",)]				{
								a[tot]=strdup(yytext);
								n++;tot++;
							}
<author>[ ]*[\"\}],					{
								BEGIN(categoria);
								char** aux = a;
								char* autor; 
								int i,j;
							
								numeroNomesAutores[numeroAutores]=n;

								for(i=0; i<=numeroAutores;i++){
									if(numeroAutores==0){
										if(tot==0){
											printf("    author = {},\n");
										}else{
											printf("    author = {%c. %s},\n",aux[0][0],aux[numeroNomesAutores[i]-1]);
										}
									}else{
										if(i==0){
											printf("    author = {%c. %s,\n",aux[0][0],aux[numeroNomesAutores[i]-1]);
										}else{
											if(i==numeroAutores-1){
												printf("        %c. %s and\n",aux[0][0],aux[numeroNomesAutores[i]-1]);
											}else{
												if(i==numeroAutores){
													printf("        %c. %s},\n",aux[0][0],aux[numeroNomesAutores[i]-1]);
												}else{
													printf("        %c. %s,\n",aux[0][0],aux[numeroNomesAutores[i]-1]);
												}
											}
										}
										aux=aux+numeroNomesAutores[i];
									}
								}
							}
<author>.|\n						{;}
@[A-Za-z]+\{[A-Za-z0-9\:]+,				{
								BEGIN(categoria); 
								printf("%s\n",yytext);
								tot=0;
								bool=0;titleBOOL=0;authorBOOL=0;
							}
<categoria>[Aa][Uu][Tt][Hh][Oo][Rr][ ]*=[ ]*[\"\{]	{	
								BEGIN(author);
								numeroAutores=0;
								tot=0;n=0; 
								authorBOOL=1;
							}
<categoria>[Tt][Ii][Tt][Ll][Ee][ ]*=[ ]*[\"]		{
								BEGIN(title); 
								printf("    title = {");
							}
<categoria>\}\n 					{	
								BEGIN(INITIAL);
								printf("}\n");
							}
<title>.*\",? 						{	
								if(yytext[strlen(yytext)-1]==','){
									yytext[strlen(yytext)-2]='}';
								} else{
									yytext[strlen(yytext)-1]='}';
								}
									printf("%s",yytext); titleBOOL=1; 
								BEGIN(categoria);
							}
<categoria>[Aa][Uu][Tt][Hh][Oo][Rr][ ]*=[ ]*[\{] 	{
								tot=1;
								printf("%s",yytext);
							}
<categoria>[Tt][Ii][Tt][Ll][Ee][ ]*=[ ]*[\{] 		{
								printf("%s",yytext);
								titleBOOL=1;
							}
<categoria>[ ]*=[ ]*\"					{ 
								if(titleBOOL && authorBOOL){
									printf(" = {");
								}else{
									strcat(lixo," = {");
								}
							}
<categoria>\",						{ 
								if(titleBOOL && authorBOOL){
									printf("},");
								}else{
									strcat(lixo,"},");
								}
							}								
<categoria>\"\n						{ 
								if(titleBOOL && authorBOOL){
									printf("}\n");
								}else{
									strcat(lixo,"}\n");
								}
							}							
<categoria>.|\n 					{
								if(titleBOOL && authorBOOL ){
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
\n 							{printf("%s",yytext);}
%%

int yywrap() {return 1;}
int main(){

	yylex();

	return 0;
}

