(* Things that should be in the OCaml library... *)

module Fun :
sig
  val curry : ('a * 'b -> 'c) -> ('a -> 'b -> 'c)
  val uncurry : ('a -> 'b -> 'c) -> ('a * 'b -> 'c)

  val repeat : int -> ('a -> unit) -> 'a -> unit
end

module List :
sig
  val equal : ('a -> 'a -> bool) -> 'a list -> 'a list -> bool
  val make : int -> 'a -> 'a list
  val table : int -> (int -> 'a) -> 'a list
  val group : ('a -> 'a -> bool) -> 'a list -> 'a list list
  val take : int -> 'a list -> 'a list (* raises Failure *)
  val drop : int -> 'a list -> 'a list (* raises Failure *)
  val split_at : int -> 'a list -> ('a list * 'a list)

  val hd_opt : 'a list -> 'a option
  val last : 'a list -> 'a (* raises Failure *)
  val split_last : 'a list -> 'a list * 'a (* raises Failure *)

  val index_of : 'a -> 'a list -> int option
  val index_where : ('a -> bool) -> 'a list -> int option
  val first_opt : ('a -> 'b option) -> 'a list -> 'b option

  val compare : ('a -> 'a -> int) -> 'a list -> 'a list -> int
  val is_ordered : ('a -> 'a -> int) -> 'a list -> bool
  val is_strictly_ordered : ('a -> 'a -> int) -> 'a list -> bool

  val iter_pairs : ('a -> 'a -> unit) -> 'a list -> unit
end

module List32 :
sig
  val make : int32 -> 'a -> 'a list
  val length : 'a list -> int32
  val nth : 'a list -> int32 -> 'a (* raises Failure *)
  val take : int32 -> 'a list -> 'a list (* raises Failure *)
  val drop : int32 -> 'a list -> 'a list (* raises Failure *)
end

module Array :
sig
  val compare : ('a -> 'a -> int) -> 'a array -> 'a array -> int
end

module Array32 :
sig
  val make : int32 -> 'a -> 'a array
  val length : 'a array -> int32
  val get : 'a array -> int32 -> 'a
  val set : 'a array -> int32 -> 'a -> unit
  val blit : 'a array -> int32 -> 'a array -> int32 -> int32 -> unit
end

module Bigarray :
sig
  open Bigarray

  module Array1_64 :
  sig
    val create : ('a, 'b) kind -> 'c layout -> int64 -> ('a, 'b, 'c) Array1.t
    val dim : ('a, 'b, 'c) Array1.t -> int64
    val get : ('a, 'b, 'c) Array1.t -> int64 -> 'a
    val set : ('a, 'b, 'c) Array1.t -> int64 -> 'a -> unit
    val sub : ('a, 'b, 'c) Array1.t -> int64 -> int64 -> ('a, 'b, 'c) Array1.t
  end
end

module Seq :
sig
  val for_all : ('a -> bool) -> 'a Seq.t -> bool
end

module Option :
sig
  val get : 'a option -> 'a -> 'a
end

module Promise :
sig
  type 'a t
  exception Promise
  val make : unit -> 'a t
  val make_fulfilled : 'a -> 'a t
  val fulfill : 'a t -> 'a -> unit
  val is_fulfilled : 'a t -> bool
  val value : 'a t -> 'a
  val value_opt : 'a t -> 'a option
end

module Int :
sig
  val log2 : int -> int
  val is_power_of_two : int -> bool
end

module Uint32 :
sig
  type t
  val to_string : t -> string
  val of_string : string -> t
  val of_string_opt : string -> t option
  val of_int : int -> t
  val to_int : t -> int
  val of_int32 : int32 -> t
  val to_int32 : t -> int32
  val add : t -> t -> t
  val sub : t -> t -> t
  val mul : t -> t -> t
  val succ : t -> t
  val zero : t
  val one : t
  val compare : t -> t -> int
  val logand : t -> t -> t
  val logor : t -> t -> t
  val shift_right_logical : t -> int -> t
end

module String :
sig
  val implode : char list -> string
  val explode : string -> char list
  val split : string -> char -> string list
  val breakup : string -> int -> string list
  val find_from_opt : (char -> bool) -> string -> int -> int option
  val chop_prefix : string -> string -> string option
  val chop_suffix : string -> string -> string option
  val lightweight_escaped : string -> string
end

module CRC :
sig
  val crc8 : string -> int
end

module Hex :
sig
  val hexdigit : char -> int
  val bytes_of_hex : string -> string
  val int_of_hex_byte : string -> int

  val hex_of_byte  : int -> string
  val hex_of_char  : char -> string
  val hex_of_bytes : string -> string
end

module FilePath :
sig
  (**
   * Normalises a file path
   *)
  val normalise : string -> string

  (**
   * Makes one path relative to another path.
   *
   * Examples:
   *
   * relative_to "/home/foo" "/home/foo/project" = Some "project"
   * relative_to "/home/foo" "/home/foo/project/lib" = Some "project/lib"
   * relative_to "/home/foo" "/home/bar/project" = None
   * relative_to "foo/bar" "foo/bar/project" = Some "project"
   *)
  val relative_to : string -> string -> string option
end
