#include "hashtable.h"

int hash(char*name, int type){
	//printf("VHASH:%lu\n", (strlen(name)%HASHSIZE)+type);
	return (strlen(name)%HASHSIZE)+type;
}

void initializeTable(HashTable h){
	int i;
	for(i=0;i<HASHSIZE;i++){
		h[i]=(Entry)malloc(sizeof(struct entry));
		h[i]->def=NULL;
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

void insertVariavel(HashTable h, Definition def) {
	int vhash=hash(def->name,def->type);
	Entry aux,novo;
	aux=h[vhash];
	if(aux->def==NULL){
		aux->def=def;
	}else{
		for (;(strcmp(aux->def->name,def->name)!=0 && aux->def->type!=def->type);aux=aux->next){
	  		if(aux->next==NULL) break;
		}
		if (strcmp(aux->def->name,def->name)==0 && aux->def->type!=def->type){
			aux->def=def;
		}
		if (aux->next==NULL){
			novo=(Entry)malloc(sizeof(Entry));
			novo->def=def;
			novo->next=NULL;
			aux->next=novo;
		}
	}
}

 Definition getVariavel(HashTable h, char* name, int type){
	int vhash=hash(name,type);
	Entry aux;
	for(aux=h[vhash]; strcmp(aux->def->name,name)!=0 && aux->def->type!=type; aux=aux->next){
		if(aux->next==NULL) { return NULL; }
	}
	return aux->def;
}
/*
int main()
{
	printf("ola;");
	HashTable h = (HashTable)malloc(sizeof(Entry)*HASHSIZE);
	printf("2");
	initializeTable(h);
	printf("1");
	Definition def1 = (Definition)malloc(sizeof(struct definition));
	def1->name=strdup("compare");
	def1->type=FUNC;
	def1->func=(Function)malloc(sizeof(struct function));
	def1->func->label="compare";
	def1->func->enableReturn=3;
	def1->func->argc=2;
	printf("ola1\n");
	insertVariavel(h,def1);

	Definition def2 = getVariavel(h,"compare",FUNC);
	printf("%s\n",def2->name);
	printf("%d\n",def2->type);
	printf("%d\n",def2->func->enableReturn);
	printf("%d\n",def2->func->argc);

    	return 0;
}*/
