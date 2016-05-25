default: roj clean
roj: y.tab.c lex.yy.c hashtable.o
	gcc  hashtable.o -o roj y.tab.c
clean:
	rm lex.yy.c
	rm y.tab.h
	rm y.tab.c

lex.yy.c: roj.l
	flex roj.l
y.tab.c: roj.y
	yacc -d -v roj.y

teste:
	./roj < Codigo\ em\ ROJ/contapares.roj
	./roj < Codigo\ em\ ROJ/maior3.roj
	./roj < Codigo\ em\ ROJ/matrix.roj
	./roj < Codigo\ em\ ROJ/sort.roj
	./roj < Codigo\ em\ ROJ/sum.roj

hashtable.o: hashtable.c hashtable.h
	gcc -c hashtable.c
