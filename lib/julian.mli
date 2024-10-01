(* Module to group all the Julian Date and MJD constants together *)
module Constants :
  sig

    (* Average length of the synodic month in days *)
    val synodic_month : float

    (* Julian Date (JD) for the start of the Julian epoch *)
    val jd_epoch_2000 : float

    (* Month adjustment to make March the first month of the year *)
    val month_adjustment : int

    (* Year adjustment factor to shift the starting point of the year *)
    val year_adjustment : int

    (* Conversion factor for months in the Julian Day Number formula *)
    val month_conversion_factor : int

    (* Number of days in a non-leap year *)
    val days_per_year : int

    (* Divisor for century-based leap year rule in the Gregorian calendar *)
    val century_divisor : int

    (* Divisor for 400-year leap year rule in the Gregorian calendar *)
    val quadricentennial_divisor : int

    (* Offset used to convert Gregorian dates to Julian Day Number (JDN) *)
    val gregorian_jdn_offset : int

    (* Offset to convert Julian date to Julian Day Number (JDN) *)
    val julian_jdn_offset : int

    (* Constant used to convert between Julian Date (JD) and Modified Julian Date (MJD) *)
    val mjd_offset : float

    (* Average number of days per year in the Julian calendar (accounting for leap years) *)
    val days_per_julian_year : float

    (* Number of hours in a day *)
    val hours_per_day : float

    (* Number of minutes in a day (24 * 60) *)
    val minutes_per_day : float

    (* Number of seconds in a day (24 * 60 * 60) *)
    val seconds_per_day : float

    (* Shift to align the Julian Day starting point at noon *)
    val noon_shift : float
  end

(* Function to calculate the Julian Day Number (JDN) for a given Gregorian date *)
val jdn_of_gregorian : int -> int -> int -> int

  (* Function to check if a given year is a leap year *)
val is_leap_year : int -> bool

(* Function to calculate the Julian Date (JD) for a given Gregorian date and time *)
val julian_date : int -> int -> int -> int -> int -> int -> float

(* Function to calculate the Modified Julian Date (MJD) for a given Gregorian date and time *)
val modified_julian_date : int -> int -> int -> int -> int -> int -> float
