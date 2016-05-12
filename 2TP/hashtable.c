#include <stdlib.h>
#include <stdio.h>
#include <string.h>
 
 
#define HASHSIZE 31  //numero primo
 
typedef struct variavel
{
	char* nome;
	int endereco;
	int size;
	int type; // 0 int 1 array
}Variavel;

typedef struct entry
{
    Variavel var;
    struct entry *next;
}Entry;
 
typedef Entry *HashTable[HASHSIZE];
 
 
int hash(Variavel v){
    return (strlen(v.nome)%HASHSIZE);
}
 
void initializeTable(HashTable h){
    int i;
    for(i=0;i<HASHSIZE;i++){
        h[i]->next = NULL;
    }
}
 
void clearTable(HashTable h){
    initializeTable(h);
}
 
void insertVariavel(HashTable h, KeyType k, Info inf) {
    int vhash=hash(k);
    Entry *aux,*novo;
 
    for (aux=h[vhash];(strcmp(aux->key,k)!=0);aux=aux->next){
        if(aux->next==NULL) break;
    }
    if (strcmp(aux->key,k)==0){
        aux->info=inf;
    }
    if (aux->next==NULL){
        novo=(Entry*)malloc(sizeof(Entry));
        strcpy(novo->key,k);
        novo->info=inf;
        novo->next=NULL;
        aux->next=novo;
    }
}
 
//apaga o elemento de chave k da tabela
void deleteTable_LP(HashTable h, KeyType k){
    int vhash=hash(k);
    Entry *aux,*aux2;
    for (aux=h[vhash];(strcmp(aux->key,k)!=0)&&aux!=NULL;aux=aux->next){
        aux2=aux;
    }
    if (strcmp(aux->key,k)==0){
        aux2->next=aux->next;
    }
}
 
//procura na tabela o elemento de chave k, e retorna o indice da tabela onde a chave se encontra(ou -1 caso k nao exista)
Entry* retrieveTable_LP(HashTable h, KeyType k){
    int vhash=hash(k);
    Entry *aux:
    for (aux=h[vhash];(strcmp(aux->key,k)!=0)&&aux!=NULL;aux=aux->next);
return aux
}
 
int main()
{   
 
    printf("%d\n",hash("ruifre") );
    return 0;
}
