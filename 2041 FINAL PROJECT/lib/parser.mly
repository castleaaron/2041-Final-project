%{
  open Ast
%}
%token <string> IDENT
%token COLON
%token LPAREN
%token RPAREN
%token EOF
%token LCOMMENT
%token RCOMMENT
%token LBRACKET
%token RBRACKET
%token <string> PUNCT
%start main
%type <expression list> main
%%
main:
    | e = expression EOF { [e] }
expression:
    | LPAREN ; e = expression ; RPAREN { e }
    | LCOMMENT ; e = expression ; RCOMMENT { e }
    | LBRACKET ; e = expression ; RBRACKET { e }
    | nm = IDENT { Identifier nm }
    | pt = PUNCT { Punctuation pt }
    | e1 = expression; nm = IDENT 
        {Application (e1, Identifier nm)}
    | e1 = expression pt = PUNCT
        {Application (e1, Punctuation pt)}

    | e1 = expression ; LPAREN; e2 = expression; RPAREN
        {Application (e1, e2)}
    | e1 = expression ; LCOMMENT e2 = expression; RCOMMENT
        {Application (e1, e2)}
    | e1 = expression ; LBRACKET e2 = expression ; RBRACKET
        {Application (e1, e2)}
    
