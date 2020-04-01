open Ctypes

module Bindings = Xkbcommon_ffi_f.Ffi.Make (Generated_ffi)
module Types = Xkbcommon_ffi_f.Ffi.Types

type t = Types.State.t ptr
let t = ptr Types.State.t

let key_get_syms (st: t) (kc: Types.Keycode.t) =
  let retp = allocate (ptr Types.Keysym.t)
      (from_voidp Types.Keysym.t null) in
  let nsyms = Bindings.xkb_state_key_get_syms st kc retp in
  let rec read_syms nsyms p =
    if nsyms = 0 then []
    else (!@ p) :: read_syms (nsyms - 1) (p +@ 1) in
  read_syms nsyms (!@ retp)
