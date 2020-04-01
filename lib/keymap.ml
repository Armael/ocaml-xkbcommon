open Ctypes

module Bindings = Xkbcommon_ffi_f.Ffi.Make (Generated_ffi)
module Types = Xkbcommon_ffi_f.Ffi.Types

type t = Types.Keymap.t ptr

let t = ptr Types.Keymap.t

let new_from_names (ctx: Context.t) names =
  let keymap =
    Bindings.xkb_keymap_new_from_names ctx
      (Rule_names.t_to_cstruct names)
      Types.Keymap_compile_flags._XKB_KEYMAP_COMPILE_NO_FLAGS in
  if is_null keymap then None else Some keymap

let unref = Bindings.xkb_keymap_unref
