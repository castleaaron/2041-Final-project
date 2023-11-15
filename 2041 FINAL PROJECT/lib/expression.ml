include Ast
module Parser = Parser
module Lexer = Lexer


let rec string_of_expression (e : expression) 
= match e with
| Identifier nm -> nm
| Application (e1, e2) -> 
  (string_of_expression e1) ^ " " ^ (string_of_expression_with_parens e2)
| Declaration (nm, e1) -> nm ^ " = " ^ string_of_expression e1
| Assignment (nm, e1) -> nm ^ " = " ^ string_of_expression e1 (* finish this *)
(* | If_Else (expr, thenLst, elseLst) -> string_of_expression expr ^ string_of_expression_lst ^ string_of_expression_lst *)
and string_of_expression_with_parens e
= match e with
| Identifier nm -> nm
| Application _ -> "(" ^ string_of_expression e ^ ")"
| Declaration (nm, e1) -> nm ^ " = " ^ string_of_expression e1 (* finsih this *)
| Assignment (nm, e1) -> nm ^ " = " ^ string_of_expression e1 (* finish this *)
(*add case for if else*)


(* and string_of_expression_lst e *)





(* let rec string_of_statement (s : statement)
= match s with
| Declaration (var, expr) -> var ^ " = " ^ string_of_expression expr
| Assignment (var, expr) -> var
| If_Else of expression * statement list * statement list *)



(* let rec string_of_statements ntabs (es : statement list) : string =
  List.fold_left (fun i x -> i ^ string_of_statements ntabs x ^ "\n") ""
and string_of_statement (ntabs : int) : statement -> string =
  let rec repi i f acc =
    if i <= 0 then acc else repi (i-1) f (f acc)
  in let tabs = repi ntabs (fun x -> x ^ "\t") ""
  in function
    | Declaration (var, expr) -> tabs ^ "var " ^ var ^ " = " ^ string_of_expression
    | Assignment (var, expr) -> tabs ^ var ^ " = " ^ string_of_expression
    | If_Else (expr, thenS, elseS) -> tabs ^ "if (" ^ string_of_expression expr ^ ") {\n" ^ string_of_statements (ntabs+1) thenS ^ tabs ^ "} else {\n" ^ string_of_statements (ntabs_1) elseS ^ tabs ^ "}" *)
