%{
	#include <stdio.h>
	#include <string.h>
	#include <stdlib.h>
	#include <ctype.h>
	#include <iostream>
	using namespace std;

	int yylex();
	int yyerror(const char *msg);

  	int EsteCorecta = 0;
	char msg[500];

	class TVAR
	{


	  
	  public:
		char* nume;
	        char* type;
	        char* valoare;
	        TVAR* next;
	  	static TVAR* head;
	  	static TVAR* tail;
	   	TVAR(char* n,char* t, char* v);
	   	TVAR();
	 	int exists(char* n);
   	 	void add(char* n,char* t, char* v);
   	  	char* getValue(char* n);
		char* getType(char* n);
	 	void setValue(char* n, char* v);
	};

	TVAR* TVAR::head;
	TVAR* TVAR::tail;

	TVAR::TVAR(char* n,char* t, char* v)
	{
		this->nume = new char[strlen(n)+1];
		strcpy(this->nume,n);
		this->type = new char[strlen(t)+1];
		strcpy(this->type,t);
		this->valoare = new char[strlen(v)+1];
		strcpy(this->valoare,v);
		this->next = NULL;
	}

	TVAR::TVAR()
	{
	  TVAR::head = NULL;
	  TVAR::tail = NULL;
	}

	int TVAR::exists(char* n)
	{
	  TVAR* tmp = TVAR::head;
	  while(tmp != NULL)
	  {
	    if(strcmp(tmp->nume,n) == 0)
	    	return 1;
	    tmp = tmp->next;
	  }
	  return 0;
	}

	void TVAR::add(char* n,char* type, char* v)
	{
	  TVAR* elem = new TVAR(n, type, v);
	  if(head == NULL)
	  {
	    TVAR::head = TVAR::tail = elem;
	  }
	  else
	  {
	    TVAR::tail->next = elem;
	    TVAR::tail = elem;
	  }
	}

  	char* TVAR::getValue(char* n)
	{
	 TVAR* tmp = TVAR::head;
	 while(tmp != NULL)
	 {
	  if(strcmp(tmp->nume,n) == 0)
	  	return tmp->valoare;
	  tmp = tmp->next;
	 }
	 return nullptr;
	}
	
	char* TVAR::getType(char* n)
	{
	 TVAR* tmp = TVAR::head;
	 while(tmp != NULL)
	 {
		if(strcmp(tmp->nume,n) == 0)
			return tmp->type;
		tmp=tmp->next;
	 }
	 return nullptr;
	}

	void TVAR::setValue(char* n, char* v)
	{
	  TVAR* tmp = TVAR::head;
	  while(tmp != NULL)
	  {
		  if(strcmp(tmp->nume,n) == 0)
	 	  {
				strcpy(tmp->valoare, v);
	    }
	    tmp = tmp->next;
	  }
	}

	TVAR* ts = NULL;


%}


%union { char* sir; int val; }

%token TOK_PROGRAM TOK_BEGIN TOK_END TOK_VAR TOK_POINT
%token TOK_PLUS TOK_MINUS TOK_MULTIPLY TOK_DIVIDE TOK_LEFT TOK_RIGHT TOK_ASSIGMENT
%token TOK_INTEGER 
%token TOK_READ TOK_WRITE 
%token TOK_FOR TOK_TO TOK_DO
%token <sir> TOK_ERROR TOK_ID
%token <val> TOK_INT

%type <sir> id_list

%start prog

%left TOK_PLUS TOK_MINUS
%left TOK_MULTIPLY TOK_DIVIDE

%locations
%%


prog : TOK_PROGRAM prog_name TOK_VAR dec_list TOK_BEGIN stmt_list TOK_END TOK_POINT
	{ EsteCorecta = 1; }
	;
prog_name : TOK_ID
	   
	;
dec_list : dec
	

	|
	   dec_list ';' dec
	
	;
dec: id_list ':' type

	
	;
type : TOK_INTEGER

	;
id_list : TOK_ID

	|
	  id_list ',' TOK_ID


	;
stmt_list : stmt
	|
	    stmt_list ';' stmt

	;
stmt : assign
     |
       read
     |
       write 
     |
       for

	;
assign : TOK_ID TOK_ASSIGMENT exp


	;
exp : term
    |
      exp TOK_PLUS term
    |
      exp TOK_MINUS term

	;
term : factor

     |
       term TOK_MULTIPLY factor
     |
       term TOK_DIVIDE factor

	;
factor : TOK_ID

       |
	 TOK_INT
       |
	 TOK_LEFT exp TOK_RIGHT
	
	;
read : TOK_READ TOK_LEFT id_list TOK_RIGHT
	
	;
for : TOK_FOR index_exp TOK_DO body


	;
write : TOK_WRITE TOK_LEFT id_list TOK_RIGHT

	;
index_exp : TOK_ID TOK_ASSIGMENT exp TOK_TO exp

	;
body : stmt
     |
       TOK_BEGIN stmt_list TOK_END

	;
%%
int main()
{
	yyparse();
	
	if(EsteCorecta == 1)
	{
		printf("CORECTA\n");
	}
	
		return 0;

}

int yyerror(const char *msg)
{
	printf("Error: %s\n" , msg);
	return 1;
}









