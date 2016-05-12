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
SE						{ return SE; }
ENTAO						{ return ENTAO; }
SENAO						{ return SENAO; }
FIMSE						{ return FIMSE; }
ENQUANTO					{ return ENQUANTO; }
IMPRIMIR					{ return IMPRIMIR; }
LER						{ return LER; }
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
