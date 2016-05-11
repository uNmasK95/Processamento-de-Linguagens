%{

%}

letra [A-Za-z]
digito [0-9]
lixo .|\n

%%

[;(),]						{return (yytext[0]);}
(?i:TURMA)					{return TURMA;}
\"[^"]+\"					{yylval.valNo = strdup(yytext); return nome;}
{digito}+(\.{digito}+)?		{yylval.valN = atof(yytext); return nota;}
{lixo}						{;}

%%

int yywrap() {
	return 1;
}
