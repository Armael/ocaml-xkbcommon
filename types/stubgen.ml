let prologue = "
#include <xkbcommon/xkbcommon.h>
"

let () =
  print_endline prologue;
  Cstubs_structs.write_c Format.std_formatter
    (module Xkbcommon_types_f.Types.Make)
