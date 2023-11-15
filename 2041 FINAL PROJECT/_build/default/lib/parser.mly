%{
  open Ast
%}
%token <string> IDENT
%token COLON
%token ASSIGN
%token VAR
%token IF
%token ELSE
%token LCUR
%token RCUR
%token LPAREN
%token RPAREN
%token SEMI
%token EOF
%start main
%type <expression list> main
// %type <statement list> main
// %type <statement> statement
// %type <expression> expression
%%
main:
    // | s = statement EOF { [s] }
    | e = expression EOF { [e] }
// statement:
//     | VAR ; var = IDENT ; ASSIGN ; expr = expression SEMI { Declaration (var, expr) }
//     | var = IDENT ; ASSIGN ; expr = expression SEMI { Assignment (var, expr) }
//     | IF ; LPAREN ; expr = expression ; RPAREN ; LCUR ; s1 = list(statement) ; RCUR ;
//         ELSE ; LCUR ; s2 = list(statement) ; RCUR { If_Else (expr, s1, s2)}
expression:
    | LPAREN ; e = expression ; RPAREN { e }
    | nm = IDENT { Identifier nm }
    | e1 = expression; nm = IDENT 
        {Application (e1, Identifier nm)}
    | e1 = expression ; LPAREN; e2 = expression; RPAREN
        {Application (e1, e2)}
    
