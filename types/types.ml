open Ctypes

module Make (S : Cstubs_structs.TYPE) = struct
  open S

  module Context = struct
    type t = [`context] structure
    let t : t typ = structure "xkb_context"
  end

  module Context_flags = struct
    let _XKB_CONTEXT_NO_FLAGS = constant "XKB_CONTEXT_NO_FLAGS" int64_t
    let _XKB_CONTEXT_NO_DEFAULT_INCLUDES =
      constant "XKB_CONTEXT_NO_DEFAULT_INCLUDES" int64_t
    let _XKB_CONTEXT_NO_ENVIRONMENT_NAMES =
      constant "XKB_CONTEXT_NO_ENVIRONMENT_NAMES" int64_t
  end

  module Rule_names = struct
    type t = [`rule_names] structure
    let t : t typ = structure "xkb_rule_names"
    let rules = field t "rules" string_opt
    let model = field t "model" string_opt
    let layout = field t "layout" string_opt
    let variant = field t "variant" string_opt
    let options = field t "options" string_opt
    let () = seal t
  end

  module Keymap = struct
    type t = [`keymap] structure
    let t : t typ = structure "xkb_keymap"
    (* no seal: it is an opaque type *)
  end

  module Keymap_compile_flags = struct
    let _XKB_KEYMAP_COMPILE_NO_FLAGS =
      constant "XKB_KEYMAP_COMPILE_NO_FLAGS" uint64_t
  end

  module State = struct
    type t = [`state] structure
    let t : t typ = structure "xkb_state"
    (* no seal: it is an opaque type *)
  end

  module Keycode = struct
    type t = int
    let t = int
  end

  module Keysym = struct
    type t = int
    let t = int
  end
end
