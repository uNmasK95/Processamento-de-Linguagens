#include <stdlib.h>
#include <stdio.h>
#include <string.h>

#define HASHSIZE 7919

typedef struct function {
  char* label; // ver melhor isto pode ser o nome da função o key name
  int enableReturn;
  int argc;
}*Function;

typedef struct variavel {
  int addr;
  int dim;
  int size;
}*Variavel;

typedef struct definition{
  char* name;
  int type; //function ou variavel
  union {
    Variavel var;
    Function func;
  };
}*Definition;

typedef struct entry
{
  Definition def;
	struct entry *next;
}*Entry;

typedef Entry* HashTable;

HashTable createHashTable();
void insertVariavel(HashTable h, Definition var);
Definition getVariavel(HashTable h, char* name, int type);
