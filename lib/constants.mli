val synodic_month : float
(** The average length of a synodic month, used in lunar phase calculations. *)

val jd_epoch_2000 : float
(** Julian date for January 1, 2000, 12:00 TT (Terrestrial Time). *)

val jd_new_moon_epoch : float
(** Julian date for January 6, 2000, 14:24:00.0 UT1 , the epoch for new moon calculations. *)

val jd_1900 : float
(** Julian date for January 1, 1900, 12:00 TT (Terrestrial Time). *)

val months_in_year_offset : int
(** Adjustment used for month calculation in date conversion formulas. *)

val days_per_year : int
(** The number of days in a typical (non-leap) year. *)

val julian_year_offset : int
(** Year offset used in Julian to Gregorian date conversion. *)

val month_conversion_factor : int
(** Factor used for converting months in date calculations. *)

val century_divisor : int
(** Number of years in a century. *)

val quadricentennial_divisor : int
(** Number of years in a 400-year period in the Gregorian calendar. *)

val gregorian_jdn_offset : int
(** Offset used for Julian Day Number calculations in the Gregorian calendar. *)

val julian_jdn_offset : int
(** Offset used for Julian Day Number calculations in the Julian calendar. *)

val mjd_offset : float
(** Modified Julian Date (MJD) offset, used to convert between Julian and Modified Julian Dates. *)

val days_in_julian_year : float
(** The average number of days in a Julian year. *)

val hours_per_day : float
(** Number of hours in a day. *)

val minutes_per_day : float
(** Number of minutes in a day (24 hours * 60 minutes). *)

val seconds_per_day : float
(** Number of seconds in a day (24 hours * 60 minutes * 60 seconds). *)

val noon_shift : float
(** Shift for calculating noon in Julian date conversions. *)

val gregorian_start_jdn : int
(** The Julian Day Number corresponding to October 15, 1582, the start of the Gregorian calendar. *)

val quadricentennial_days : int
(** Number of days in 400 years in the Gregorian calendar, including leap years. *)

val days_in_century : int
(** Number of days in 100 years in the Gregorian calendar, including leap year adjustments. *)

val days_in_julian_century : float
(** Number of days in a Julian century. *)

val quadrennial_days : int
(** Number of days in 4 years in both the Julian and Gregorian calendars, accounting for leap years. *)

val days_per_month_factor : float
(** Factor used for month calculation in Julian to Gregorian date conversions. *)

val month_correction : int array
(** Array used for calculating the cumulative number of days up to the start of each month in a year. *)
