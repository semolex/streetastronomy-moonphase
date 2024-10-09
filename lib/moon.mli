(**
  Description: This module provides different functions related to the Moon.
  References:
    - "Astronomical Algorithms" by Jean Meeus, Chapter 47, p. 342
    - https://en.wikipedia.org/wiki/Lunar_phase
    - https://github.com/mourner/suncalc/blob/master/suncalc.js
    - https://stjarnhimlen.se/comp/tutorial.html
*)

module Phase : sig
  (** Type representing the different phases of the Moon. *)
  type phase =
    | New  (** Represents the New Moon phase. *)
    | FirstQuarter  (** Represents the First Quarter phase. *)
    | Full  (** Represents the Full Moon phase. *)
    | LastQuarter  (** Represents the Last Quarter phase. *)
    | WaxingCrescent  (** Represents the Waxing Crescent phase. *)
    | WaxingGibbous  (** Represents the Waxing Gibbous phase. *)
    | WaningGibbous  (** Represents the Waning Gibbous phase. *)
    | WaningCrescent  (** Represents the Waning Crescent phase. *)

  type phase_details = {
    phase : phase;  (** The Moon phase classification. *)
    age : float;  (** The Moon's age in days since the last New Moon. *)
    illumination : float;  (** The percentage of the Moon's illumination. *)
  }
  (** Type representing detailed information about the Moon's phase.
      Contains the classification of the phase, the age of the Moon,
      and the illumination percentage. *)

  val deg_to_rad : float -> float
  (** [deg_to_rad deg] converts degrees to radians. *)

  val rad_to_deg : float -> float
  (** [rad_to_deg rad] converts radians to degrees. *)

  val string_of_phase : phase -> string
  (** [string_of_phase p] returns a string representation of the Moon phase [p]. *)

  val details_of_julian : float -> phase_details
  (**
    [details_of_julian jd] returns detailed information about the Moon's phase
    for a given Julian date [jd]. The result includes the phase, age, and
    illumination percentage.
  *)

  val details_of_date : CalendarLib.Calendar.Precise.t -> phase_details
  (** [details_of_date date] returns detailed information about the Moon's phase
      for a given date of type [CalendarLib.Calendar.Precise.t]. *)

  val details_of_date_int :
    int -> int -> int -> int -> int -> int -> phase_details
  (**
    [details_of_date_int year month day hour minute second] returns detailed information about the Moon's phase
    for a given date of type int.
  *)

  val phase_calendar :
    CalendarLib.Calendar.Precise.t ->
    CalendarLib.Calendar.Precise.t ->
    (CalendarLib.Calendar.Precise.t * phase_details) list
  (**
    [phase_calendar start_date end_date] returns a list of detailed information about the Moon's phases for the range of dates
    with arguments of type [CalendarLib.Calendar.Precise.t].
  *)

  val pp : Format.formatter -> phase -> unit
  (** Pretty-printer for the [phase] type. *)

  val print_calendar :
    (CalendarLib.Calendar.Precise.t * phase_details) list -> unit
  (**
    [print_calendar calendar] prints the Moon phases calendar to the standard output.
    The argument is a list of tuples, where the first element is the date and the second element is the phase details.
  *)
end
