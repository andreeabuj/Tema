%{
#include "y.tab.h"

int lineNo = 1;
int colNo = 1;
%}

%%

^"PROGRAM" 			{colNo+=7; ECHO; return TOK_PROGRAM; }
"VAR"				{colNo+=3; ECHO; return TOK_VAR;}
"INTEGER"			{colNo+=7; ECHO; return TOK_INTEGER;}
"BEGIN"				{colNo+=5; ECHO; return TOK_BEGIN;}
"END"				{colNo+=3; ECHO; return TOK_END;}
"READ"				{colNo+=4; ECHO; return TOK_READ;}
"WRITE"				{colNo+=5; ECHO; return TOK_WRITE;}
"FOR"				{colNo+=3; ECHO; return TOK_FOR;}
"TO"				{colNo+=2; ECHO; return TOK_TO;}
"DO"				{colNo+=2; ECHO; return TOK_DO;}

"+"				{colNo++; ECHO; return TOK_PLUS;}
"-"				{colNo++; ECHO; return TOK_MINUS;}
"*"				{colNo++; ECHO; return TOK_MULTIPLY;}
"DIV"				{colNo++; ECHO; return TOK_DIVIDE;}
"("				{colNo++; ECHO; return TOK_LEFT;}
")"				{colNo++; ECHO; return TOK_RIGHT;}
":"				{colNo++; ECHO; return ':';}
";"				{colNo++; ECHO; return ';';}
":="				{colNo++; ECHO; return TOK_ASSIGMENT;}
"."				{colNo++; ECHO; return TOK_POINT;}
","				{colNo++; ECHO; return ',';}

0|[1-9][0-9]* { colNo+=strlen(yytext); yylloc.first_line=lineNo;
yylloc.first_column=colNo; yylval.val=atoi(yytext); ECHO; return TOK_INT; }

[a-zA-Z][a-zA-Z0-9_]* { yylloc.first_line = lineNo; yylloc.first_column = colNo; colNo+=strlen(yytext); yylval.sir = new char[strlen(yytext)+1]; strcpy(yylval.sir,yytext); ECHO; return TOK_ID;}
[ ]		{ colNo++; }
.		{ colNo++; ECHO; return TOK_ERROR; }
\r\n|\n		{ lineNo++; colNo=1; }
%%
