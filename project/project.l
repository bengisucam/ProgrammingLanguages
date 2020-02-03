%{
#include "stdio.h"
#include "y.tab.h"
extern int yylval;
%}
%%
[\t ]+  /* Ignore Whitespace */;
str return (STR );
int return(INT);
float return(FLOAT);
graph return(GRAPH);
array return(ARRAY);
road return(ROAD);
AND return(AND_OPT);
OR return(OR_OPT);
\! return(NOT);
\= return(ASSIGN);
\+= return(INC_ASSIGN);
\-= return(DEC_ASSIGN);
\== return(EQUAL);
if return(IF);
then return(THEN);
else return(ELSE);        
while return(WHILE);
for return(FOR);
node return(NODE);
function return(FUNC_DECLARATION);
showOnMap return(SHOWONMAP);
searchLocation return(SEARCHLOCATION);
getRoadSpeed return(GETROADSPEED);
getLocation return(GETLOCATION);
showTarget return(SHOWTARGET);
createGraph return(CREATEGRAPH);
addNode return(ADDNODE);
getCrossRoads return(GETCROSSROADS);
getRoadDistance return(GETROADDISTANCE);
getRoadScore return(GETROADSCORE);
getLocationOfOtherUsers return(GETLOCATIONOFOTHERUSERS);
\; return(SEMICOLON);
\, return(COMMA);
\( return(LEFT_BRACKET);
\) return(RIGHT_BRACKET);
\[ return(LEFT_SQUARE_BRACKET);
\] return(RIGHT_SQUARE_BRACKET);
\{ return(LEFT_CURLY_BRACKET);
\} return(RIGHT_CURLY_BRACKET);	
"+" return(PLUS_OPT);
\- return(SUB_OPT);
\/ return(DIV_OPT);
\* return(MULT_OPT);
\^ return(EXP_OPT);
\> return(GREATER_THAN);
\< return(LESS_THAN);
\>= return(GREATER_OR_EQUAL);
\<= return(SMALLER_OR_EQUAL);
\!= return(NOT_EQUAL);
\\n {extern int lineno; lineno++; return(NEWLINE);}
[+-]?[0-9]+  return(INTNUMBER);
[+-]?[0-9]*(\.)?[0-9]+ return(FLOATNUMBER);
\"(.)*\" return(STRING); 
[a-zA-Z]([a-zA-Z]|[0-9])* return(IDENTIFIER);
%%
