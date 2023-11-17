%{
  open Ast
%}

%token <string> IDENT
%token LPAREN RPAREN
%token EOF
%token LBRACKET RBRACKET
%token <string> PUNCT
%token <string> PROVE
%start main
%type <expression list> main

%%

main:
  | e = expression EOF { [e] }

expression:
  | LPAREN ; e = expression ; RPAREN { e }
  | LBRACKET ; e = expression ; RBRACKET { e }
  | PROVE ; e = expression ; PROVE { e }
  | nm = IDENT { Identifier nm }
  | pt = PUNCT { Punctuation pt }
  | pv = PROVE {Prove pv}

  | e1 = expression; nm = IDENT { Application (e1, Identifier nm) }
  | e1 = expression; pt = PUNCT { Application (e1, Punctuation pt) }
  | e1 = expression; pv = PROVE {Application (e1, Prove pv)}

  | e1 = expression ; LPAREN; e2 = expression; RPAREN
      { Application (e1, e2) }
  | e1 = expression ; LBRACKET e2 = expression ; RBRACKET
      { Application (e1, e2) }


