%{
#include <stdio.h>
#include <string.h>
#include <ctype.h>

char*  nomesCategorias[30]; //guardar categorias
int contCategorias[30]; //guargar o numero de vezes de cada categoria correspondente á posição do array seguinte

char* a[500]; 
int n=0;
int tot=0;
int numeroAutores=0;
int numeroNomesAutores[100];
char lixo[5000];

int bool=0;
int titleBOOL=0;
int authorBOOL=0;

char* new[1000];


int nParceiros=0;
char* authorParceria[100];
char* authorProcura;


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
	for(i=0;i<30 && nomesCategorias[i]!=NULL && found==0;i++){
		if(!strcmp(nomesCategorias[i],nome)){
			found=1;
			contCategorias[i]++;
		}
	}
	if(nomesCategorias[i]==NULL && found==0){
		nomesCategorias[i] = strdup(nome);
		contCategorias[i]++;
	}
}
char* removeVirgula(char* name){
	if(name[strlen(name)-1]==','){
		name[strlen(name)-1]='\0';
	}
	return name;
}
char* retiraEnter(char* lixo){
	int i = 0;
	while(lixo[0]=='\n'){lixo++;}
	i=strlen(lixo);
	while(lixo[i-1]=='\n'){lixo[i-1]='\0';i--;}
	
	return lixo;
}
void registaAuthors(){
	char** aux = a;
	char* autor; 
	int i,j;
	char buf[100];
	
	FILE* fp = fopen("graf.dot","a+");
	FILE* fpAuthor = fopen("grafAuthor.dot","a+");

	numeroNomesAutores[numeroAutores]=n;
	for(i=0; i<=numeroAutores;i++){
		if(numeroAutores==0){
			//0 ou 1 autores
			if(tot==0){
				printf("author = { },\n");
			}else{
				if(tot==1){
					printf("author = { %s },\n",aux[0]);
					sprintf(buf,"%s",aux[0]);
				}else{
					if(aux[0][strlen(aux[0])-1]==','){
						printf("author = { %c. %s },\n",aux[1][0],removeVirgula(aux[0]));
						sprintf(buf,"%c. %s",aux[1][0],removeVirgula(aux[0]));
					}else{
						printf("author = { %c. %s },\n",aux[0][0],aux[numeroNomesAutores[i]-1]);
						sprintf(buf,"%c. %s",aux[0][0],aux[numeroNomesAutores[i]-1]);
					}
				}
			}
		}else{
			if(i==0){
				if(numeroNomesAutores[i]==1){
					printf("author = { \n\t%s and\n",aux[0]);
					sprintf(buf,"%s",aux[0]);
				}else{
					if(aux[0][strlen(aux[0])-1]==','){
						printf("author = { \n\t%c. %s and\n",aux[1][0],removeVirgula(aux[0]));
						sprintf(buf,"%c. %s",aux[1][0],removeVirgula(aux[0]));
					}else{
						printf("author = { \n\t%c. %s and\n",aux[0][0],aux[numeroNomesAutores[i]-1]);
						sprintf(buf,"%c. %s",aux[0][0],aux[numeroNomesAutores[i]-1]);
					}
				}
				
			}else{
				if(i==numeroAutores){
					if(numeroNomesAutores[i]==1){
						printf("\t%s },\n",aux[0]);
						sprintf(buf,"%s",aux[0]);
					}else{
						if(aux[0][strlen(aux[0])-1]==','){
							printf("\t%c. %s },\n",aux[1][0],removeVirgula(aux[0]));
							sprintf(buf,"%c. %s",aux[1][0],removeVirgula(aux[0]));			
						}else{
							printf("\t%c. %s },\n",aux[0][0],aux[numeroNomesAutores[i]-1]);
							sprintf(buf,"%c. %s",aux[0][0],aux[numeroNomesAutores[i]-1]);
						}
					}
					
				}else{
					if(numeroNomesAutores[i]==1){
						printf("\t%s and\n",aux[0]);
						sprintf(buf,"%s",aux[0]);
					}else{
						if(aux[0][strlen(aux[0])-1]==','){
							printf("\t%c. %s and\n",aux[1][0],removeVirgula(aux[0]));
							sprintf(buf,"%c. %s",aux[1][0],removeVirgula(aux[0]));			
						}else{
							printf("\t%c. %s and\n",aux[0][0],aux[numeroNomesAutores[i]-1]);
							sprintf(buf,"%c. %s",aux[0][0],aux[numeroNomesAutores[i]-1]);
						}
					}
					
				}
			}
			new[i]=strdup(buf);	
			aux=aux+numeroNomesAutores[i];
		}
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
}

%}
%x reservada categoria author title
%%
^[ ]*@		{BEGIN(reservada);}
<reservada>[A-Za-z]+  {
	printf("\n@%s",yytext);
	char* aux = lowerCASE(yytext);
	addRegisto(aux);
}

<reservada>\{[^,]+, {
	printf("%s\n",yytext);
	BEGIN(categoria); 
	titleBOOL=0;
	authorBOOL=0;
	bool=0;
	lixo[0]='\0';
}

<categoria>[ \n\t][Aa][Uu][Tt][Hh][Oo][Rr][ \t]*=[ \t]*[\"\{]	{	
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

<author>\{[^ ,]+[^ \"\}]\},? {
	a[tot]=strdup(yytext);
	n++;tot++;
}							

<author>[^ ,]+([^ \"\},\n]|[^ \"\}],) {
	a[tot]=strdup(yytext);
	n++;tot++;
}

<author>[ ]*[\"\}],?\n 	{
	BEGIN(categoria);
	registaAuthors();
	//registaAuthorsGraf();
}

<author>.|\n 	{;}
<categoria>[ \n\t][Tt][Ii][Tt][Ll][Ee][ \t]*=[ \t]*\"	{
	BEGIN(title); 
	if(authorBOOL){
		printf("title = {");
	}else{
		strcat(lixo,"title = {");
	}
	titleBOOL=1;
}

<categoria>[ \n\t][Tt][Ii][Tt][Ll][Ee][ \t]*=[ \t]*\{ 	{
	BEGIN(title);
	if(authorBOOL){
		printf("title = {");
	}else{
		strcat(lixo,"title = {");
	}
	titleBOOL=1;
}

<title>[^=]*\",? {	
	BEGIN(categoria);
	if(yytext[strlen(yytext)-1]==','){
		yytext[strlen(yytext)-2]='}';
	} else{
		yytext[strlen(yytext)-1]='}';
	}
	if(authorBOOL){
		printf("%s\n",yytext);
	}else{
		strcat(yytext,"\n");
		strcat(lixo,yytext);
	}
}

<title>[^=]*[^\n]\},? {
	BEGIN(categoria);
	if(authorBOOL){
		printf("%s",yytext);
	}else{
		strcat(yytext,"\n");
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

<categoria>\",		{ 
	if(titleBOOL && authorBOOL){
		printf("},");
	}else{
		strcat(lixo,"},");
	}
}

<categoria>\"\n		{ 
	if(titleBOOL && authorBOOL){
		printf("}");
	}else{
		strcat(lixo,"}");
	}
}

<categoria>.|\n {
	if(titleBOOL && authorBOOL ){
		if(!bool){
			printf("%s%s",retiraEnter(lixo),yytext);
			bool=1;
		}else{
			printf("%s",yytext);
		} 
	 }else{
	 	strcat(lixo,yytext);
 	} 
}

<categoria>\}\n {	
	BEGIN(INITIAL);
	if(!(titleBOOL && authorBOOL)){
		printf("%s",lixo);
	}
	printf("} \n");
}

.|\n {;}

%%
void initArrayCategorias(){
	int i;
	for(i=0;i<30;i++){
		nomesCategorias[i]=NULL;
		contCategorias[i]=0;
	}
}

void gerarHTML(){
	int i;
	FILE* fp =fopen("index.html","w");

	fprintf(fp, "<html>\n\t<head>\n\t\t<title>EXERCICIO 1</title>\n\t</head>\n\t<body>\n \t\t<h2>Lista Exercico 1</h2>\n\t\t\t<ul>\n");

	for(i=0;i<30 && nomesCategorias[i]!=NULL ;i++){

		fprintf(fp, "\t\t\t<li> %s -> %d </li>\n", nomesCategorias[i],contCategorias[i]);
	}
	
	fprintf(fp, "\t\t\t</ul>\n\t</body>\n</html>\n");
	fclose(fp);
}

int yywrap() {return 1;}
int main(int argc, char** argv){
	initArrayCategorias();

	if(argc<=1){
		authorProcura=strdup("");
	}else{
		authorProcura=argv[1];
	}

	FILE* fp = fopen("graf.dot","w");
	fprintf(fp,"strict graph authors {\n");
	fclose(fp);

	FILE* fpAuthor = fopen("grafAuthor.dot","w");
	fprintf(fpAuthor,"strict graph authors {\n");
	fclose(fpAuthor);


	yylex();
	
	fp = fopen("graf.dot","a+");
	fprintf(fp,"}");
	fclose(fp);

	fpAuthor = fopen("grafAuthor.dot","a+");
	fprintf(fpAuthor,"}");
	fclose(fpAuthor);

	gerarHTML();

	system("dot -Tpng graf.dot -o graf.png");
	system("dot -Tpng grafAuthor.dot -o grafAuthor.png");
	
	return 0;
}
