open Ctypes

module Types = Xkbcommon_types_f.Types.Make (Generated_types)

module Make (F : Cstubs.FOREIGN) =
struct
  open F
  open! Types

  let xkb_context_new = foreign "xkb_context_new"
      (uint64_t @-> returning (ptr Types.Context.t))

  let xkb_context_unref = foreign "xkb_context_unref"
      (ptr Types.Context.t @-> returning void)

  let xkb_keymap_new_from_names = foreign "xkb_keymap_new_from_names"
      (ptr Types.Context.t @-> ptr Types.Rule_names.t @-> uint64_t @->
       returning (ptr Types.Keymap.t))

  let xkb_keymap_unref = foreign "xkb_keymap_unref"
      (ptr Types.Keymap.t @-> returning void)

  let xkb_state_key_get_syms = foreign "xkb_state_key_get_syms"
      (ptr Types.State.t @-> Types.Keycode.t @-> ptr (ptr Types.Keysym.t)
         @-> returning int)
end
