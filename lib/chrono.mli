module Date :
  sig
    type t = {
      year : int;
      month : int;
      day : int;
      hour : int;
      minute : int;
      second : int;
    }
    val make :
      year:int ->
      month:int -> day:int -> hour:int -> minute:int -> second:int -> t
    val make_simple : year:int -> month:int -> day:int -> t
    val of_ints : int -> int -> int -> int -> int -> int -> t
    val of_ints_simple : int -> int -> int -> t
    val is_gregorian : t -> bool
    val julian_centuries_since_epoch : float -> float
    val days_since_epoch : float -> float -> float
    val from_julian : float -> t
    val from_julian_fvf : float -> t
    val to_julian : t -> float
    val to_string : t -> string
    val pp : Format.formatter -> t -> unit
    val eq : t -> t -> bool
    val eq_almost : t -> t -> bool
  end
