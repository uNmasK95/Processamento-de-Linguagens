#include <stdlib.h>
#include <stdio.h>
#include <string.h>

#define HASHSIZE 31

typedef char* Key;
 
typedef struct variavel
{       
	Key key;
	int addr;
	int size; 
	int type; // 0 int 1 array
}*Variavel,variavel;
 
typedef struct entry
{   
	Variavel var;
	struct entry *next;
}*Entry;
 
typedef Entry* HashTable;

HashTable createHashTable();
void insertVariavel(HashTable h, Variavel var);
Variavel getVariavel(HashTable h, Key key);

