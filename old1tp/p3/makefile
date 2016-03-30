Eurun2:
	if [ -f "graf.dot" ]; then rm graf.dot; fi;
	flex tp3.l
	gcc -o tp3 lex.yy.c -I /usr/local/include/graphviz/
	./tp3 ${ARGS} < ../lib2.bib 
run1:
	if [ -f "graf.dot" ]; then rm graf.dot ;fi;
	flex tp3.l
	gcc -o tp3 lex.yy.c -I /usr/local/include/graphviz/
	./tp3 ${ARGS} < ../lib.bib  
