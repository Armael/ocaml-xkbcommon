{
exception LexingError

let init buf =
  Buffer.add_string buf "type t = int\n"
}

let blank = ['\n' '\t' ' ']
let letter = ['a' - 'z' 'A' - 'Z' '_']
let digit = ['0' - '9']
let keyname = (letter | digit)+
let hexadigit = ['0' - '9' 'a' - 'f' 'A' - 'F']
let hexa = '0' 'x' hexadigit+

let nonempty_line_in_comment_block = " *" [^ '\n']+ "\n"
let empty_line_in_comment_block = " *\n"
let paragraph_in_comment_block =
  nonempty_line_in_comment_block+ empty_line_in_comment_block

rule lexer buf = parse
  | "/*" { Buffer.add_string buf "(*"; comment buf lexbuf }
  | "#ifndef _XKBCOMMON_KEYSYMS_H\n"
  | "#define _XKBCOMMON_KEYSYMS_H\n"
  | "#endif" { lexer buf lexbuf }
  | "#define" blank+ "XKB_KEY_" (keyname as name) (blank+ as pad) (hexa as value) {
      Printf.bprintf buf "let _%s : t = %s%s" name pad value;
      lexer buf lexbuf
    }
  | eof { () }
  | (_ as c) { Buffer.add_char buf c; lexer buf lexbuf }

and comment buf = parse
  | "*/" { Buffer.add_string buf "*)"; lexer buf lexbuf }
  (* Hack: disable some perl regexps that break the comment block *)
  | " * Mnemonic names" [^ '\n']+ "\n"
    paragraph_in_comment_block
    paragraph_in_comment_block
  { comment buf lexbuf }
  | eof { raise LexingError }
  | (_ as c) { Buffer.add_char buf c; comment buf lexbuf }
