%{

%}

letra [A-Za-z]
digito [0-9]
lixo .|\n

%%

[\+\-\*\/=;()\[\]]				{ return yytext[0]; }
INICIO						{ return INICIO; }
FIM						{ return FIM; }
INSTINICIO					{ return INSTINICIO; }
INSTFIM						{ return INSTFIM; }
VAR						{ return VAR; }
se						{ return SE; }
entao						{ return ENTAO; }
senao						{ return SENAO; }
fimse						{ return FIMSE; }
enquanto					{ return ENQUANTO; }
imprimir					{ return IMPRIMIR; }
ler						{ return LER; }
DIFF						{ return DIFF; }
GG						{ return GG; }
LL						{ return LL; }
GE						{ return GE; }
LE						{ return LE; }
EQ						{ return EQ; }
AND						{ return AND; }
NOT						{ return NOT; }


{letra}+					{yylval.var = strdup(yytext); return id;}
\-?{digito}+					{yylval.val = atoi(yytext); return num;}
{lixo}						{;}

%%

int yywrap() {
	return 1;
}
