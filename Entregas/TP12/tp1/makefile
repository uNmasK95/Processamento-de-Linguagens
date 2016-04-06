default:	
	clear
	flex bib.l
	gcc -o bib lex.yy.c
	./bib "${ARGS}"< lib.bib
