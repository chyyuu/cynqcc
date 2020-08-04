type token = 
  | OpenBrace
  | CloseBrace
  | OpenParen
  | CloseParen
  | Semicolon
  | IntKeyword
  | ReturnKeyword
  | Minus  
  | Int of int
  | Id of string