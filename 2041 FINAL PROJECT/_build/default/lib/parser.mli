
(* The type of tokens. *)

type token = 
  | VAR
  | SEMI
  | RPAREN
  | RCUR
  | LPAREN
  | LCUR
  | IF
  | IDENT of (string)
  | EOF
  | ELSE
  | COLON
  | ASSIGN

(* This exception is raised by the monolithic API functions. *)

exception Error

(* The monolithic API. *)

val main: (Lexing.lexbuf -> token) -> Lexing.lexbuf -> (Ast.expression list)
