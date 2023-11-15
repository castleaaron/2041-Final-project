(* type statement =
  | Declaration of string * expression
  | Assignment of string * expression
  | If_Else of expression * statement list * statement list *)
type expression =
  | Identifier of string
  | Application of expression * expression
  | Declaration of string * expression
  | Assignment of string * expression
  (* | If_Else of expression * expression list * expression list *)