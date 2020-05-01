%{
	#include<stdio.h>
	#include<stdlib.h>
	#include<string.h>
	int numwords=0;
	int numchap=0;
	int numsec=0;
	int numpara=0;
	int numdec=0;
	int numexc=0;
	int numint=0;

	extern int yylex();
%}
%union{
	char *f;
}

%token <f> Toktitle Tokchap Toksec Tokword TokIntNum TokFloatNum Toksep Tokline dec Exc Inter Tokspace
%type <f> Title

%%	
Title 			: Toktitle Chapters	
Chapters		: Chapters chapter	{numchap++;}
				| chapter {numchap++;}
chapter 		: newline Tokchap newline paragraphs newline Sections
				| newline Tokchap newline Sections
				| newline Tokchap newline paragraphs newline
				;
Sections 		: Sections section  {numsec++;}
				| section    {numsec++;}
				;	
section 		: Toksec Tokline paragraphs newline
				;
paragraphs 		: paragraphs Tokline para  {numpara++;}
				| para {numpara++;}
				;
para 			: para sentence 
				| sentence 
				;
sentence		: Tokspace sent 	
				| sent 				
				;
sent			: literal Toksep sent
				| literal Tokspace sent
				| literal Tokspace Tokendl	
				| literal Tokendl
				;
Tokendl			: dec	{numdec++;}
				| Exc 	{numexc++;}
				| Inter {numint++;}
				;
literal			: Tokword	{numwords++;}
				| TokIntNum
				| TokFloatNum
				;
newline			: Tokline
				|
				;
%%
void yyerror(char * s) 
{    
 printf ("%error\n"); 
 exit(0);
}  
int main(int argc, char** argv){
	yyparse();
	printf("Number of Chapters: %d\n",numchap);
	printf("Number of Sections: %d\n",numsec);
	printf("Number of Paragraphs: %d\n",numpara);
	printf("Number of Sentences: %d\n",numdec+numexc+numint);
	printf("Number of Words: %d\n",numwords);
	printf("Number of Declarative Sentences: %d\n",numdec);
	printf("Number of Exclamatory Sentences: %d\n",numexc);
	printf("Number of Interrogative Sentences: %d\n",numint);
	return 0;
}