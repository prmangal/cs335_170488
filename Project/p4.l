%{
	#include<stdio.h>
	#include<stdlib.h>
	#include<string.h>
	#include"y.tab.h"
%}


IntNum [1-9][0-9]*
FloatNum	{IntNum}[.][0-9]+

words [a-zA-Z]+
notsentence [ ]*({words}[ ]*[,:]?[ ]*)*[.?!]?
decsentence [ ]*({words}[ ]*[,:]?[ ]*)*[.]
exclsentence [ ]*({words}[ ]*[,:]?[ ]*)*[!]
intsentence [ ]*({words}[ ]*[,:]?[ ]*)*[?]
sentence {decsentence}|{exclsentence}|{intsentence}	
chap Chapter[ ]*{IntNum}[ ]*[:][ ]*{notsentence}  
sec Section[ ]*{FloatNum}[ ]*[:][ ]*{notsentence}
title Title[ ]*[:][ ]*{notsentence}
%%
[\n]+ {yylval.f=yytext;return Tokline;}
{title}	{yylval.f=yytext;printf("%s\nTable of Contents:\n",yytext);return Toktitle;}
{chap}	{yylval.f=yytext;printf("%s\n",yytext);return Tokchap;}
{sec}	{yylval.f=yytext;printf("	%s\n",yytext);return Toksec;}
{words}	{yylval.f=yytext;return Tokword;}
{IntNum}	{yylval.f=yytext;return TokIntNum;}
{FloatNum}	{return TokFloatNum;}
[ ]*[,:][ ]*	{yylval.f=yytext;return Toksep;}
[.]	{yylval.f=yytext;return dec;}
[?]	{yylval.f=yytext;return Exc;}
[!]	{yylval.f=yytext;return Inter;}
([	]|[ ])*	{yylval.f=yytext;return Tokspace;}
.	;

%%


int yywrap(void){
	return 1;
}