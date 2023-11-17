type expression =
  | Identifier of string
  | Application of expression * expression
  | Punctuation of string
  | Prove of string
  