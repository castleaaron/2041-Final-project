{
    open Parser
    exception SyntaxError of string
}

let newline = '\r' | '\n' | "\r\n"

rule token = parse
    | [' ' '\t'] {token lexbuf}
    | "(*prove*)" + as prove {PROVE(prove)}
    | newline {Lexing.new_line lexbuf; token lexbuf}
    | ['a'-'z' 'A'-'Z' '0'-'9' '_' '\''] + as word {IDENT(word)}
    | '(' {LPAREN}
    | ')' {RPAREN}
    | "(*" {comment 0 lexbuf}
    | '{' {LBRACKET}
    | '}' {RBRACKET}
    | ['.' ',' '?' '!' '-' ':' '='] + as p {PUNCT(p)}
    | _ {raise (SyntaxError ("Unexpected char: " ^ Lexing.lexeme lexbuf))}
    | eof {EOF}

and comment level = parse
  | "*)" { if level = 0 then token lexbuf
            else comment (level - 1) lexbuf }
  | "(*" { comment (level + 1) lexbuf }
  | _ { comment level lexbuf }
