default: roj clean
roj: y.tab.c lex.yy.c 	
	gcc -o roj y.tab.c 
clean: 
	rm lex.yy.c
	rm y.tab.h
	rm y.tab.c

lex.yy.c: roj.l
	flex roj.l
y.tab.c: roj.y
	yacc -d roj.y

teste:	
	./roj < Codigo\ em\ ROJ/contapares.roj
	./roj < Codigo\ em\ ROJ/maior3.roj
	./roj < Codigo\ em\ ROJ/matrix.roj
	./roj < Codigo\ em\ ROJ/sort.roj
	./roj < Codigo\ em\ ROJ/sum.roj 
