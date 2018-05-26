type flag =
  | No_default_includes
  | No_environment_names

type flags = flag list

type t

val create : ?flags:flags -> unit -> t
