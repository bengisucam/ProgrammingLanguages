
%{
#include "stdio.h"
int result=0;
int yylex();
int lineno;
void yyerror()
{
lineno+=2;
fprintf(stderr,"error: Something goes wrong in line: %d \n",lineno - 1);
}


int yywrap(void)
{
printf("PROGRAM TERMINATED SUCCESSFULLY!!!\n");
return 1;
}

%}
%token INTNUMBER FLOATNUMBER  STRING IDENTIFIER PLUS_OPT  SUB_OPT DIV_OPT  MULT_OPT EXP_OPT
%token STR INT FLOAT GRAPH ARRAY ROAD NODE
%token AND_OPT OR_OPT NOT ASSIGN INC_ASSIGN DEC_ASSIGN EQUAL 
%token IF THEN ELSE WHILE FOR FUNC_DECLARATION 
%token SHOWONMAP SEARCHLOCATION GETROADSPEED GETLOCATION SHOWTARGET 
%token GETLOCATIONOFOTHERUSERS CREATEGRAPH ADDNODE GETCROSSROADS GETROADDISTANCE GETROADSCORE 
%token LEFT_BRACKET RIGHT_BRACKET LEFT_SQUARE_BRACKET RIGHT_SQUARE_BRACKET 
%token LEFT_CURLY_BRACKET RIGHT_CURLY_BRACKET 
%token GREATER_THAN LESS_THAN GREATER_OR_EQUAL SMALLER_OR_EQUAL NOT_EQUAL 
%token COMMA SEMICOLON
%token NEWLINE
%left PLUS_OPT SUB_OPT
%left MULT_OPT DIV_OPT
%right  EXP_OPT

%%
lines: /* nothing */
     | lines program
     ;

program: NEWLINE  { lineno++;}
	| stringexp   { lineno++;}
	| exp   { lineno++;} 
	| assignmentexp  { lineno++;}
	| conditionalstatement  { lineno++;}
	| ifstatement  { lineno++;}
	| forstatement  { lineno++;}
	| whilestatement  { lineno++;}
	| functiondef  { lineno++;}
	| functioncall  { lineno++;}
	| {yyerror();}	 { lineno++;}
	;
  
  
variable: INTNUMBER
		| FLOATNUMBER
		| IDENTIFIER
		| STRING
		;
		
exp: exp SUB_OPT exp 
	| exp PLUS_OPT exp  
	| exp DIV_OPT exp  
	| exp MULT_OPT exp  
	| exp EXP_OPT exp 
	| INTNUMBER 
	| FLOATNUMBER
	| IDENTIFIER
    ;
 
assignmentexp: IDENTIFIER assignop variable 			
			| IDENTIFIER assignop exp    
			| ARRAY ASSIGN variable   
			| GRAPH ASSIGN variable   
			;

assignop: ASSIGN 
		| DEC_ASSIGN
		| INC_ASSIGN
		;
	
stringexp: STRING 
		| stringexp  STRING 
		; 
   
conditionalstatement: variable GREATER_THAN variable   	
					| variable GREATER_OR_EQUAL variable    
					| variable LESS_THAN variable   
					| variable SMALLER_OR_EQUAL variable   
					| variable NOT_EQUAL variable   	
					| variable EQUAL variable   
					;

ifstatement: IF LEFT_BRACKET conditionalstatement RIGHT_BRACKET	THEN anystatement   
			|IF LEFT_BRACKET conditionalstatement RIGHT_BRACKET	THEN anystatement ELSE anystatement   
			;
			
forstatement: FOR LEFT_BRACKET assignmentexp SEMICOLON  conditionalstatement SEMICOLON exp RIGHT_BRACKET THEN anystatement  
			;

whilestatement: WHILE LEFT_BRACKET conditionalstatement RIGHT_BRACKET THEN anystatement	 
			;

functiondef: SHOWONMAP LEFT_BRACKET FLOAT funcfloat COMMA FLOAT funcfloat RIGHT_BRACKET 		
			| SEARCHLOCATION LEFT_BRACKET STR funcstr RIGHT_BRACKET 				
			| GETROADSPEED LEFT_BRACKET ROAD IDENTIFIER RIGHT_BRACKET  
			| GETLOCATION LEFT_BRACKET INT funcint RIGHT_BRACKET 	
			| SHOWTARGET LEFT_BRACKET STR funcstr RIGHT_BRACKET 	
			| CREATEGRAPH LEFT_BRACKET RIGHT_BRACKET 
			| ADDNODE LEFT_BRACKET NODE IDENTIFIER COMMA NODE IDENTIFIER RIGHT_BRACKET
			| GETCROSSROADS LEFT_BRACKET ARRAY IDENTIFIER LEFT_SQUARE_BRACKET RIGHT_SQUARE_BRACKET RIGHT_BRACKET	
			| GETROADDISTANCE LEFT_BRACKET ROAD IDENTIFIER RIGHT_BRACKET 
			| GETROADSCORE LEFT_BRACKET ROAD IDENTIFIER RIGHT_BRACKET 	
			| GETLOCATIONOFOTHERUSERS LEFT_BRACKET ARRAY IDENTIFIER LEFT_SQUARE_BRACKET RIGHT_SQUARE_BRACKET RIGHT_BRACKET 	
			| FUNC_DECLARATION IDENTIFIER LEFT_BRACKET parameters RIGHT_BRACKET   
			;
			
functioncall: SHOWONMAP LEFT_BRACKET funcfloat COMMA funcfloat RIGHT_BRACKET    	
			| SEARCHLOCATION LEFT_BRACKET funcstr RIGHT_BRACKET 	
			| GETROADSPEED LEFT_BRACKET IDENTIFIER RIGHT_BRACKET 
			| GETLOCATION LEFT_BRACKET funcint RIGHT_BRACKET  
			| SHOWTARGET LEFT_BRACKET funcstr RIGHT_BRACKET
			| CREATEGRAPH LEFT_BRACKET RIGHT_BRACKET
			| ADDNODE LEFT_BRACKET IDENTIFIER COMMA IDENTIFIER RIGHT_BRACKET
			| GETCROSSROADS LEFT_BRACKET IDENTIFIER RIGHT_BRACKET
			| GETROADDISTANCE LEFT_BRACKET IDENTIFIER RIGHT_BRACKET
			| GETROADSCORE LEFT_BRACKET IDENTIFIER RIGHT_BRACKET
			| GETLOCATIONOFOTHERUSERS LEFT_BRACKET IDENTIFIER RIGHT_BRACKET
			| IDENTIFIER LEFT_BRACKET funcparam RIGHT_BRACKET SEMICOLON   
			;

funcstr: IDENTIFIER
		| STRING
		;

funcfloat: IDENTIFIER
		| FLOATNUMBER
		;
		
funcint: IDENTIFIER
		| INTNUMBER
		;
		
funcvar: IDENTIFIER
		  | FLOATNUMBER
		  | INTNUMBER
		  | STRING
		  ;
		  
funcparam: funcvar		  
		  | funcvar COMMA funcparam
		  | /*empty parameter*/
		  ;
		
parameters: one_param
		  | one_param COMMA parameters
		  | /*empty parameter*/
		  ;
		  
one_param: type IDENTIFIER
		  | ARRAY IDENTIFIER LEFT_SQUARE_BRACKET RIGHT_SQUARE_BRACKET
		  ;
		  
type: FLOAT
	| INT
	| NODE
	| STR
	| ROAD
	;

anystatement: ifstatement
			| forstatement
			| whilestatement
			| assignmentexp
			| exp
			;

%%
#include "math.h"

int main(void)
{

yyparse();

return 0;
}