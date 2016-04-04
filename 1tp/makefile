p1:
	flex tp1.l
	gcc -o tp1 lex.yy.c
	./tp1 < lib.bib
	more index.html 
p2:
	flex tp2.l
	gcc -o tp2 lex.yy.c
	./tp2 < lib.bib
	
p3:
	if [ -f "graf.dot" ]; then rm graf.dot; fi;
	if [ -f "grafAuthor.dot" ]; then rm grafAuthor.dot; fi;
	flex tp3.l
	gcc -o tp3 lex.yy.c
	./tp3 "${ARGS}" < lib.bib 

graph:
	if [ -f "graf.dot" ]; then dot -Tpng graf.dot -o graf.png; fi;
	if [ -f "grafAuthor.dot" ]; then dot -Tpng grafAuthor.dot -o grafAuthor.png; fi;
	
clear: 
	if [ -f "graf.dot" ]; then rm graf.dot; fi;
