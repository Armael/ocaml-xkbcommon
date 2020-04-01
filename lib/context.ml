open Ctypes

module Bindings = Xkbcommon_ffi_f.Ffi.Make (Generated_ffi)
module Types = Xkbcommon_ffi_f.Ffi.Types

module Keysyms = Keysyms

let (@::) o xs = match o with
  | Some x -> x::xs
  | None   ->    xs

let (&&&) x1 x2 =
  let open Unsigned.UInt64 in
  Infix.((x1 land x2) <> zero)

let some_if b x =
  if b then Some x else None

type flag =
  | No_default_includes
  | No_environment_names

type flags = flag list

let flags_of_uint64 x =
  let open Types.Context_flags in
  let u = Unsigned.UInt64.of_int64 in
  (some_if (x &&& u _XKB_CONTEXT_NO_DEFAULT_INCLUDES)
     No_default_includes) @::
  (some_if (x &&& u _XKB_CONTEXT_NO_ENVIRONMENT_NAMES)
     No_environment_names) @::
  []

let uint64_of_flags l =
  let open Types.Context_flags in
  let open Unsigned.UInt64 in
  let open Infix in
  let u = Unsigned.UInt64.of_int64 in
  List.fold_left (fun bits flag -> match flag with
    | No_default_includes ->
      bits lor u _XKB_CONTEXT_NO_DEFAULT_INCLUDES
    | No_environment_names ->
      bits lor u _XKB_CONTEXT_NO_ENVIRONMENT_NAMES
  ) (u _XKB_CONTEXT_NO_FLAGS) l

let flags : flags typ =
  view ~read:flags_of_uint64 ~write:uint64_of_flags uint64_t

let _ = flags

type t = Types.Context.t ptr
let t = ptr Types.Context.t

let create ?(flags = []) () =
  let ctx = Bindings.xkb_context_new (uint64_of_flags flags) in
  if is_null ctx then None else Some ctx

let unref = Bindings.xkb_context_unref
