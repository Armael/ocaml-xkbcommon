type keycode = int
type keysym = int

module Keysyms : module type of Keysyms

module Context : sig
  type flag =
    | No_default_includes
    | No_environment_names

  type flags = flag list

  type t
  val t : t Ctypes.typ

  val create : ?flags:flags -> unit -> t option
  val unref : t -> unit
end

module Rule_names : sig
  type t = {
    rules : string option;
    model : string option;
    layout : string option;
    variant : string option;
    options : string option;
  }

  (* val t : t Ctypes.typ *)
  (* TODO *)
end

module Keymap : sig
  type t
  val t : t Ctypes.typ

  val new_from_names : Context.t -> Rule_names.t -> t option
  val unref : t -> unit
end

module State : sig
  type t
  val t : t Ctypes.typ

  val key_get_syms : t -> keycode -> keysym list
end
