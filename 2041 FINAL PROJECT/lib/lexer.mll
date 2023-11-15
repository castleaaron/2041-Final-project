{
    open Parser
    exception SyntaxError of string
}

let newline = '\r' | '\n' | "\r\n"

rule token = parse
    | [' ' '\t'] {token lexbuf}
    | newline {Lexing.new_line lexbuf; token lexbuf}
    | "//" [^ '\n' '\r']* {token lexbuf}
    | "(*"  {comment 0 lexbuf}
    | ['a'-'z' 'A'-'Z' '0'-'9' '_' '\''] + as word {IDENT(word)}
    | '(' {LPAREN}
    | ')' {RPAREN}
    | '{' {LCUR}
    | '}' {RCUR}
    | ':' {COLON}
    | '=' {ASSIGN}
    | "if" {IF}
    | "else" {ELSE}
    | _ {raise (SyntaxError ("Unexpected char: " ^ Lexing.lexeme lexbuf))}
    | eof {EOF}
and comment level = parse
    | "*)" {if level = 0 then token lexbuf else comment (level-1) lexbuf}
    | "(*" {comment (level+1) lexbuf}
    | _ {comment level lexbuf}