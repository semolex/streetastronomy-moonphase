type coordinates = Eq | Gal | Ecl | AltAz  (** The type of coordinates. *)

exception Invalid_coordinates of string
(** The exception raised when the coordinates are invalid. *)

(** Equatorial coordinates. *)
module Equatorial : sig
  type right_ascension = { hours : int; minutes : int; seconds : float }
  (** The type of right ascension. Currently involves float but might need to change to int. *)

  type declination = { degrees : int; arcminutes : int; arcseconds : float }
  (** The type of declination. Currently involves float but might need to change to int. *)

  type t = { ra : right_ascension; dec : declination }
  (** The type of equatorial coordinates. *)

  val to_degrees : t -> float * float
  (** [to_degrees eq] converts the equatorial coordinates [eq] to degrees. *)

  val to_string : t -> string
  (** [to_string eq] converts the equatorial coordinates [eq] to a string representation. *)

  val from_degrees : float -> float -> t
  (** [from_degrees ra dec] converts the right ascension [ra] and declination [dec] to equatorial coordinates. *)

  val angular_distance : t -> t -> float
  (** [angular_distance eq1 eq2] computes the angular distance between the equatorial coordinates [eq1] and [eq2]. *)
end
