start:
	flex project.l
	bison -dy project.y
	gcc -o cheetos_parser y.tab.c lex.yy.c
	./cheetos_parser < test.txt