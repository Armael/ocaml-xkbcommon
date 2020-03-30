open Ctypes

module Types = Xkbcommon_types_f.Types.Make (Generated_types)

module Make (F : Cstubs.FOREIGN) =
struct
  open F
  open! Types

  let xkb_context_new = foreign "xkb_context_new"
      (uint64_t @-> returning (ptr Types.Context.t))
end
