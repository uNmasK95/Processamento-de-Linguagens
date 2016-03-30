run2:
	if [ -f "graf.dot" ]; then rm graf.dot; fi;
	flex tp2.l
	gcc -o tp2 lex.yy.c -I /usr/local/include/graphviz/
	./tp2 < ../lib2.bib 
run1:
	if [ -f "graf.dot" ]; then rm graf.dot ;fi;
	flex tp2.l
	gcc -o tp2 lex.yy.c -I /usr/local/include/graphviz/
	./tp2 < ../lib.bib  
