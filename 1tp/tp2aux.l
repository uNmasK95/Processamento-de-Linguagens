%{
#include <stdio.h>
#include <string.h>

int parse(char process[], char* ret[], const char delim[]){
   char *token,*aux;
   int i=0;
   //printf("ola\n");
   token = strtok(process,delim);
   //printf("ola\n");
   while(token != NULL ){
   		if(i>0){
   			ret[i]=strdup(token+1);
   		}else{
   			ret[i]=strdup(token);
   		}
      
      //printf("TTT->%s\n",token);
      token = strtok(NULL, delim);
      i++;
   }
   if(delim[0]==','){
   		int stop=0;
	   int j=0;
	   char* aux1=NULL;
	   //printf("1\n");
	   while(ret[i-1][j]!='\0' && !stop){
	//printf("%c\n",ret[i-1][j]);
	   		if(ret[i-1][j]==' ' && ret[i-1][j+1]=='a' && ret[i-1][j+2]=='n' && ret[i-1][j+3]=='d' && ret[i-1][j+4]==' '){
	   			aux1=ret[i-1]+j+5;
	   			ret[i-1][j]='\0';
	   			stop=1;
	   		}
	   		j++;
	   }
	   if(stop){
	   		ret[i]=strdup(aux1);
	   		i++;
	   }
   }
  
   //printf("%s\n",ret[i] );
  
   return i;
}


void normalize(char* linha){
	char* ret[10];
	int i;
	printf("%s\n", linha);
	int n = parse(linha,ret,",");

	for(i=0;i<n;i++){
		printf("%s\n",ret[i]);
	}

	for(i=0;i<n;i++){
		//int nn = parse()
	}


}


%}




%x author interior
%%

author[ ]*=[ ]*[\"] {BEGIN(author);}
<author>[A-Za-z\\\.'\{\}\~ ]+[^a][^n][^d][^,][^"],				{ printf("%s\n",yytext); yytext[strlen(yytext)-1]='\0';}
<author>[A-Za-z\\\.'\{\}\~ ]+[^a][^n][^d][^,][^"][ ]and			{ printf("%s\n",yytext); yytext[strlen(yytext)-1]='\0';}
<author>[A-Za-z\\\.'\{\}\~ ]+[^a][^n][^d][^,][^"][^ ]\"			{ printf("%s\n",yytext); yytext[strlen(yytext)-1]='\0';BEGIN(INITIAL);}
<author>.|\n 							{;}
.|\n 	{;}
%%
int yywrap() {return 1;}
int main(){
	//<author>[A-Za-z \'\\]+[(and),]	{printf("%s\n",yytext);}
	printf("Vou começar\n");
	yylex();

	//<author>.+[^(and),"][(and),]	{printf("TEXTO = %s\n",yytext);}
	//<author>[\"\n][,] {printf("ola\n");BEGIN(INITIAL);} 
	printf("Acabei \n");

	return 0;
}

