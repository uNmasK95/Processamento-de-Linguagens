#include "hashtable.h" 
 
#define HASHSIZE 31  //numero primo

int hash(Key key){
	return (strlen(key)%HASHSIZE);
}



void initializeTable(HashTable h){
	int i;
	for(i=0;i<HASHSIZE;i++){
		h[i]=(Entry)malloc(sizeof(struct entry));
		h[i]->var=NULL;
		h[i]->next=NULL;
    	}
}

HashTable createHashTable(){
	HashTable h = (HashTable)malloc(sizeof(Entry)*HASHSIZE);
	initializeTable(h);
	return h;
}
 
void clearTable(HashTable h){
    initializeTable(h);
}

void insertVariavel(HashTable h, Variavel var) {
    	int vhash=hash(var->key);
    	Entry aux,novo;
	aux=h[vhash];
	if(aux->var==NULL){
		aux->var=var;	
	}else{		
    		for (;(strcmp(aux->var->key,var->key)!=0);aux=aux->next){
        		if(aux->next==NULL) break;
   	 	}
		
    		if (strcmp(aux->var->key,var->key)==0){
        		aux->var=var;
   	 	}
    		if (aux->next==NULL){
        		novo=(Entry)malloc(sizeof(Entry));
        		novo->var=var;
        		novo->next=NULL;
        		aux->next=novo;
    		}
	} 
}

Variavel getVariavel(HashTable h, Key key){
	int vhash=hash(key);
	Entry aux;
	for(aux=h[vhash]; strcmp(aux->var->key,key)!=0 ; aux=aux->next){
		if(aux->next==NULL) { return NULL; }
	}
	return aux->var;
}

int main()
{  
	printf("ola;"); 
	HashTable h = (HashTable)malloc(sizeof(Entry)*HASHSIZE);
	printf("2");
	initializeTable(h);
	printf("1");
	Variavel v1 = (Variavel)malloc(sizeof(variavel));
	v1->key=strdup("a");
	v1->addr=0;
	v1->size=1;
	v1->type=0;
	printf("ola1\n");
	insertVariavel(h,v1);	
 
	//printf("%d\n",hash("ruifre") );	

	Variavel v2 = getVariavel(h,"a");
	printf("%s\n",v2->key);
	
    	return 0;
}
