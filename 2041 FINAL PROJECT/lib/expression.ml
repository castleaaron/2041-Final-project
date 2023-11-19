include Ast
module Parser = Parser
module Lexer = Lexer


let parse (s : string) : expression list =
  let lexbuf = Lexing.from_string s in
  let ast = Parser.main Lexer.token lexbuf in
  ast

let rec string_of_expression (e : expression) 
= match e with
| Identifier nm -> nm
| Application (e1, e2) -> 
  (string_of_expression e1) ^ " " ^ (string_of_expression_with_parens e2)
| Punctuation pt -> pt
| Prove pv -> pv
| Hint ht -> ht

and string_of_expression_with_parens e
= match e with
| Identifier nm -> nm
| Application _ -> "(" ^ string_of_expression e ^ ")"
| Punctuation pt -> pt
| Prove pv -> pv
| Hint ht -> ht



