type token = 
  | OpenBrace
  | CloseBrace
  | OpenParen
  | CloseParen
  | Semicolon
  | IntKeyword
  | ReturnKeyword
  | Int of int
  | Id of string