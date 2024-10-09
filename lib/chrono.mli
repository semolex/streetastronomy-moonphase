module Date : sig
  type t = {
    year : int;  (** The year component of the date. *)
    month : int;  (** The month component of the date (1-12). *)
    day : int;  (** The day component of the date (1-31). *)
    hour : int;  (** The hour component of the time (0-23). *)
    minute : int;  (** The minute component of the time (0-59). *)
    second : int;  (** The second component of the time (0-59). *)
  }
  (** Type representing a date and time with year, month, day, hour, minute, and second. *)

  val make :
    year:int ->
    month:int ->
    day:int ->
    hour:int ->
    minute:int ->
    second:int ->
    t
  (** [make ~year ~month ~day ~hour ~minute ~second] creates a date from the specified components. *)

  val make_simple : year:int -> month:int -> day:int -> t
  (** [make_simple ~year ~month ~day] creates a date with the specified year, month, and day, setting time components to zero. *)

  val of_ints : int -> int -> int -> int -> int -> int -> t
  (** [of_ints year month day hour minute second] creates a date from the specified integer components. *)

  val of_ints_simple : int -> int -> int -> t
  (** [of_ints_simple year month day] creates a date from the specified year, month, and day, with time components set to zero. *)

  val is_gregorian : t -> bool
  (** [is_gregorian date] returns true if the date is in the Gregorian calendar, false otherwise. *)

  val julian_centuries_since_epoch : float -> float
  (** [julian_centuries_since_epoch jd] calculates the number of Julian centuries since the epoch for the given Julian date. *)

  val days_since_epoch : float -> float -> float
  (** [days_since_epoch jd epoch] calculates the number of days since a given epoch for the specified Julian date. *)

  val from_julian : float -> t
  (** [from_julian jd] converts a Julian date to a date of type [t]. *)

  val from_julian_fvf : float -> t
  (** [from_julian_fvf jd] converts a Julian date to a date of type [t], using a different formula. *)

  val to_julian : t -> float
  (** [to_julian date] converts a date of type [t] to a Julian date. *)

  val to_string : t -> string
  (** [to_string t] converts a date of type [t] to a string representation. *)

  val pp : Format.formatter -> t -> unit
  (** [pp ppf d] pretty-prints a date of type [t] to the given formatter. *)

  val eq : t -> t -> bool
  (** [eq d1 d2] checks if two dates of type [t] are equal. *)

  val eq_almost : t -> t -> bool
  (** [eq_almost d1 d2] checks if two dates of type [t] are approximately equal (ignoring time differences). *)
end
