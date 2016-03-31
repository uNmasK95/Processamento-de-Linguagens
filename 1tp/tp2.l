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

void registaAuthors(){
	char** aux = a;
	char* autor; 
	int i,j;
	
	numeroNomesAutores[numeroAutores]=n;
	for(i=0; i<=numeroAutores;i++){
		if(numeroAutores==0){
			if(tot==0){
				printf("author = { },\n");
			}else{
				if(tot==1){
					printf("author = { %s },\n",aux[0]);
				}else{
					printf("author = { %c. %s },\n",aux[0][0],aux[numeroNomesAutores[i]-1]);
				}
			}
		}else{
			if(i==0){
				printf("author = { %c. %s and\n",aux[0][0],aux[numeroNomesAutores[i]-1]);
			}else{
				if(i==numeroAutores){
					printf("\t%c. %s },\n",aux[0][0],aux[numeroNomesAutores[i]-1]);
				}else{
					printf("\t%c. %s and\n",aux[0][0],aux[numeroNomesAutores[i]-1]);
				}
			}
			aux=aux+numeroNomesAutores[i];
		}
	}
}

%}

%x author categoria title
%%
@[A-Za-z]+\{[A-Za-z0-9\:\+]+,				{
								BEGIN(categoria); 
								printf("%s\n",yytext);
								tot=0;
								bool=0;titleBOOL=0;authorBOOL=0;
								lixo[0]='\0';
							}

<categoria>[Aa][Uu][Tt][Hh][Oo][Rr][ \t]*=[ \t]*[\"\{]	{	
								BEGIN(author);
								numeroAutores=0;
								tot=0;n=0; 
								authorBOOL=1;
							}

<author>[ ]+[Aa][Nn][Dd][ ]+	{
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
											//printf("TESTECHAVETAS:%s\n",yytext );
											a[tot]=strdup(yytext);
											n++;tot++;
										}							

<author>[^ ,]+[^ \",\}]					{
											//printf("TESTE:%s\n",yytext );
											a[tot]=strdup(yytext);
											n++;tot++;
										}

<author>[ ]*[\"\}],						{
											BEGIN(categoria);
											registaAuthors();
										}
<author>.|\n							{;}


<categoria>[ \n\t][Tt][Ii][Tt][Ll][Ee][ \t]*=[ \t]*\"	{
															BEGIN(title); 
															if(authorBOOL){
																printf("%s",yytext);
															}else{
																strcat(lixo,yytext);
															}
															titleBOOL=1;
														}

<categoria>[ \n\t][Tt][Ii][Tt][Ll][Ee][ \t]*=[ \t]*\{ 	{
															BEGIN(title);
															if(authorBOOL){
																printf("%s",yytext);
															}else{
																strcat(lixo,yytext);
															}
															titleBOOL=1;
														}

<title>[^=]*\".? 		{	
								BEGIN(categoria);
								if(yytext[strlen(yytext)-1]==','){
									yytext[strlen(yytext)-2]='}';
								} else{
									yytext[strlen(yytext)-1]='}';
								}
								if(authorBOOL){
									printf("%s",yytext);
								}else{
									strcat(lixo,yytext);
								}
							}

<title>[^=]*\},?			{
								BEGIN(categoria);
								if(authorBOOL){
									printf("%s",yytext);
								}else{
									strcat(lixo,yytext);
								}
								
							}



<categoria>[ ]*=[ ]*\"		{ 
								if(titleBOOL && authorBOOL){
									printf(" = {");
								}else{
									strcat(lixo," = {");
								}
							}

<categoria>\",				{ 
								if(titleBOOL && authorBOOL){
									printf("},");
								}else{
									strcat(lixo,"},");
								}
							}



<categoria>.|\n 			{
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

<categoria>\}\n 	 		{	
								BEGIN(INITIAL);
								if(!(titleBOOL && authorBOOL)){
									printf("%s",lixo);
								}
								printf("}\n\n");
							}

.|\n 						{;}

%%

int yywrap() {return 1;}
int main(){

	yylex();

	return 0;
}

