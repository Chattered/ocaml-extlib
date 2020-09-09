(* 
 * ExtHashtbl - extra functions over hashtables.
 * Copyright (C) 2003 Nicolas Cannasse
 * 
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version,
 * with the special exception on linking described in file LICENSE.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 *)
 
(** Extra functions over hashtables. *)

module Hashtbl :
  (** The wrapper module *)
  sig

  include module type of Hashtbl

  type ('a,'b) t = ('a,'b) Hashtbl.t
  (** The type of a hashtable. *)

  (** {6 New Functions} *)

  val exists : ('a,'b) t -> 'a -> bool
  (** [exists h k] returns true is at least one item with key [k] is
    found in the hashtable. *)

  val keys : ('a,'b) t -> 'a Enum.t
  (** Return an enumeration of all the keys of a hashtable.
      If the key is in the Hashtable multiple times, all occurrences
      will be returned.  *)

  val values : ('a,'b) t -> 'b Enum.t
  (** Return an enumeration of all the values of a hashtable. *)

  val enum : ('a, 'b) t -> ('a * 'b) Enum.t
  (** Return an enumeration of (key,value) pairs of a hashtable. *)

  val of_enum : ('a * 'b) Enum.t -> ('a, 'b) t
  (** Create a hashtable from a (key,value) enumeration. *)

  val find_default : ('a,'b) t -> 'a -> 'b -> 'b
    (** Find a binding for the key, and return a default
      value if not found *)

  val find_opt : ('a,'b) Hashtbl.t -> 'a -> 'b option
  (** Find a binding for the key, or return [None] if no
    value is found *)

  val find_option : ('a,'b) Hashtbl.t -> 'a -> 'b option
  (** compatibility, use [find_opt] *)

  val remove_all : ('a,'b) t -> 'a -> unit
  (** Remove all bindings for the given key *)

  val map : ('b -> 'c) -> ('a,'b) t -> ('a,'c) t
  (** [map f x] creates a new hashtable with the same
      keys as [x], but with the function [f] applied to
    all the values *)

  val length : ('a,'b) t -> int
  (** Return the number of elements inserted into the Hashtbl 
    (including duplicates) *)

#if OCAML >= 400
  val reset : ('a,'b) t -> unit
  val randomize : unit -> unit

  type statistics = Hashtbl.statistics = {
    num_bindings: int;
    num_buckets: int;
    max_bucket_length: int;
    bucket_histogram: int array;
  }

  val stats : ('a,'b) t -> statistics

  val seeded_hash_param : int -> int -> int -> 'a -> int
  val seeded_hash : int -> 'a -> int
#endif

#if OCAML >= 403
  val is_randomized : unit -> bool
  val filter_map_inplace : ('a -> 'b -> 'b option) -> ('a, 'b) t -> unit
#endif

  end
