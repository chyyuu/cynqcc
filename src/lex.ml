open Batteries

let int_regexp = Str.regexp "\\(-?[0-9]+\\)\\(\\b.*\\)"
let id_regexp = Str.regexp "\\([A-Za-z][A-Za-z0-9_]*\\)\\(\\b.*\\)"
let get_kw_int_or_id input =
    if Str.string_match int_regexp input 0
    then 
        let int_token = Str.matched_group 1 input in
        let rest = Str.matched_group 2 input in
            (Tok.Int(int_of_string int_token), rest)
    else if Str.string_match id_regexp input 0
    then
        let id_token_str = Str.matched_group 1 input in
        let rest = Str.matched_group 2 input in
        let id_token = 
            match id_token_str with
            | "return" -> Tok.ReturnKeyword
            | "int" -> IntKeyword
            | _ -> Id(id_token_str)
        in
            (id_token, rest)
    else
        failwith ("Syntax error: \""^input^ "\" is not valid.")

let rec lex input = 
    let input = String.trim input in 
        if String.length input = 0
        then []
        else
            let tok, remaining_program = 
                match String.explode input with
                | '{'::rest -> (Tok.OpenBrace, String.implode rest)
                | '}'::rest -> (CloseBrace, String.implode rest)
                | '('::rest -> (OpenParen, String.implode rest)
                | ')'::rest -> (CloseParen, String.implode rest)    
                | ';'::rest -> (Semicolon, String.implode rest)
                | _ -> get_kw_int_or_id input
            in
            tok :: (lex remaining_program)

let tok_to_string t =
    let s = 
        match t with
        | Tok.OpenBrace -> "{"
        | CloseBrace -> "}"
        | OpenParen -> "("
        | CloseParen -> ")"
        | Semicolon -> ";"
        | IntKeyword -> "INT"
        | ReturnKeyword -> "RETURN"
        | Int i -> Printf.sprintf "INT<%d>" i
        | Id id -> Printf.sprintf "ID<%s>" id
    in
    s
