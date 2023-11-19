%{
  open Ast
%}

%token <string> IDENT
%token LPAREN RPAREN
%token EOF
%token <string> PUNCT
%token <string> PROVE
%token <string> HINT
%token <string> ENDHINT
%start main
%type <expression list> main

%%

main:
  | e = expression EOF { [e] }

expression:
  | LPAREN ; e = expression ; RPAREN { e }
  | nm = IDENT { Identifier nm }
  | pt = PUNCT { Punctuation pt }
  | pv = PROVE {Prove pv}
  | ht = HINT {Hint ht}
  | eht = ENDHINT{Identifier eht}

  | e1 = expression; nm = IDENT { Application (e1, Identifier nm) }
  | e1 = expression; pt = PUNCT { Application (e1, Punctuation pt) }
  | e1 = expression; pv = PROVE {Application (e1, Prove pv)}
  | e1 = expression; ht = HINT {Application (e1, Hint ht)}
  | e1 = expression; eht = ENDHINT{Application(e1, Identifier eht)}

  | e1 = expression ; LPAREN; e2 = expression; RPAREN
      { Application (e1, e2) }


