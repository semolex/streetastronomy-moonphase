module Constants = struct

  let synodic_month = 29.530588853
  let jd_epoch_2000 = 2451545.0
  let month_adjustment = 14
  let year_adjustment = 4800
  let month_conversion_factor = 153
  let days_per_year = 365
  let century_divisor = 100
  let quadricentennial_divisor = 400
  let gregorian_jdn_offset = 32045
  let julian_jdn_offset = 32083
  let mjd_offset = 2400000.5
  let days_per_julian_year = 365.25
  let hours_per_day = 24.0
  let minutes_per_day = 1440.0
  let seconds_per_day = 86400.0
  let noon_shift = 12.0

end

let jdn_of_gregorian year month day =
  (* Adjust month and year according to the Julian date algorithm *)
  (* TODO: Reuse Calendar *)

  let a = (Constants.month_adjustment - month) / 12 in
  let y = year + Constants.year_adjustment - a in
  let m = month + 12 * a - 3 in
  day + (Constants.month_conversion_factor * m + 2) / 5
  + Constants.days_per_year * y
  + y / 4                                       (* Number of leap years *)
  - y / Constants.century_divisor               (* Subtract for century years *)
  + y / Constants.quadricentennial_divisor      (* Add for every 400 years *)
  - Constants.gregorian_jdn_offset              (* Gregorian calendar offset *)

let is_leap_year year =
  (year mod 4 = 0 && year mod 100 <> 0) || (year mod 400 = 0)


let julian_date year month day hour minute second =
  let jdn = jdn_of_gregorian year month day in
  let day_fraction =
    (float_of_int hour -. Constants.noon_shift) /. Constants.hours_per_day +.  (* Convert hour to fraction of a day *)
    (float_of_int minute) /. Constants.minutes_per_day +.      (* Convert minute to fraction of a day *)
    (float_of_int second) /. Constants.seconds_per_day        (* Convert second to fraction of a day *)
  in
  float_of_int jdn +. day_fraction

let modified_julian_date year month day hour minute second =
  let jd = julian_date year month day hour minute second in
  jd -. Constants.mjd_offset
