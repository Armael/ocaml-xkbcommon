open Ctypes

module Bindings = Xkbcommon_ffi_f.Ffi.Make (Generated_ffi)
module Types = Xkbcommon_ffi_f.Ffi.Types

type t = {
  rules : string option;
  model : string option;
  layout : string option;
  variant : string option;
  options : string option;
}

let t_to_cstruct t =
  let s = make Types.Rule_names.t in
  setf s Types.Rule_names.rules t.rules;
  setf s Types.Rule_names.model t.model;
  setf s Types.Rule_names.layout t.layout;
  setf s Types.Rule_names.variant t.variant;
  setf s Types.Rule_names.options t.options;
  addr s
