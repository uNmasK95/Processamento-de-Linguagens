roj: y.tab.c lex.yy.c	
	gcc -o roj y.tab.c 
lex.yy.c: roj.l
	flex roj.l
y.tab.c: roj.y
	yacc -d roj.y 
