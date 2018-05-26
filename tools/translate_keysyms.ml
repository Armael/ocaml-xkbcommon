let () =
  let headers =
    match Sys.argv |> Array.to_list |> List.tl with
    | h :: _ -> h
    | _ -> exit 1
  in
  let cin = open_in headers in
  let b = Buffer.create 37 in
  let lb = Lexing.from_channel cin in
  let () = Translate_keysyms_lex.init b in
  let () = Translate_keysyms_lex.lexer b lb in
  close_in cin;
  print_string (Buffer.contents b)
