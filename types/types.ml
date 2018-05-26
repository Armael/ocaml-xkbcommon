open Ctypes

module Make (S : Cstubs_structs.TYPE) = struct
  open S

  module Context = struct
    type t = [`context] structure
    let t : t typ = structure "xkb_context"
  end

  module Context_flag = struct
    let _XKB_CONTEXT_NO_FLAGS = constant "XKB_CONTEXT_NO_FLAGS" int64_t
    let _XKB_CONTEXT_NO_DEFAULT_INCLUDES =
      constant "XKB_CONTEXT_NO_DEFAULT_INCLUDES" int64_t
    let _XKB_CONTEXT_NO_ENVIRONMENT_NAMES =
      constant "XKB_CONTEXT_NO_ENVIRONMENT_NAMES" int64_t
  end
end
