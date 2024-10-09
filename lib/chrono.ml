open Constants

module Date = struct
  type t = {
    year : int;
    month : int;
    day : int;
    hour : int;
    minute : int;
    second : int;
  }

  let make ~year ~month ~day ~hour ~minute ~second =
    { year; month; day; hour; minute; second }

  let make_simple ~year ~month ~day =
    { year; month; day; hour = 0; minute = 0; second = 0 }

  let of_ints year month day hour minute second =
    make ~year ~month ~day ~hour ~minute ~second

  let of_ints_simple year month day = make_simple ~year ~month ~day

  let is_gregorian date =
    let { year; month; day; _ } = date in
    year > 1582 || (year = 1582 && (month > 10 || (month = 10 && day >= 15)))

  let days_since_epoch jd epoch = jd -. epoch

  let julian_centuries_since_epoch jd =
    days_since_epoch jd jd_epoch_2000 /. days_in_julian_century

  let from_julian jd =
    (* Adjust Julian date to the correct time *)
    let jd = jd +. 0.5 in

    (* Separate integer and fractional parts *)
    let z = int_of_float jd in
    let f = jd -. float_of_int z in

    (* Calculate auxiliary values *)
    let alpha =
      if z >= gregorian_start_jdn then
        let a = (z - 1867216) / days_in_century in
        z + 1 + a - (a / 4)
      else z
    in
    let b = alpha + 1524 in
    let c = int_of_float ((float_of_int b -. 122.1) /. days_in_julian_year) in
    let d = int_of_float (days_in_julian_year *. float_of_int c) in
    let e = int_of_float (float_of_int (b - d) /. 30.6001) in

    (* Calculate date components *)
    let day = b - d - int_of_float (30.6001 *. float_of_int e) in
    let month = if e < 14 then e - 1 else e - 13 in
    let year = if month > 2 then c - 4716 else c - 4715 in

    (* Calculate time components *)
    let day_fraction = f *. hours_per_day in
    let hour = int_of_float day_fraction in
    let minute_fraction = (day_fraction -. float_of_int hour) *. 60.0 in
    let minute = int_of_float minute_fraction in
    let second_fraction = (minute_fraction -. float_of_int minute) *. 60.0 in
    let second = int_of_float (second_fraction +. 0.5) in

    { year; month; day; hour; minute; second }

  let from_julian_fvf jd =
    (* Adjust the Julian day number *)
    let jd = int_of_float (jd +. 0.5) in
    let l = jd + 68569 in

    (* Calculate intermediate variables for year, month, and day *)
    let n = 4 * l / quadricentennial_days in
    let l = l - (((quadricentennial_days * n) + 3) / 4) in
    let i = 4000 * (l + 1) / 1461001 in
    let l = l - (quadrennial_days * i / 4) + 31 in
    let j = 80 * l / 2447 in
    let day = l - (2447 * j / 80) in
    let l = j / 11 in
    let month = j + 2 - (12 * l) in
    let year = (100 * (n - 49)) + i + l in

    (* Adjust year if it is zero *)
    let year = if year = 0 then 1 else year in

    (* Special case adjustment: if month is 12 and day is 30, and year = 1, it should be January 1st, year 1 *)
    let year, month, day =
      if year = 1 && month = 12 && day = 30 then (1, 1, 1)
      else (year, month, day)
    in

    { year; month; day; hour = 0; minute = 0; second = 0 }

  let to_julian date : float =
    let { year; month; day; hour; minute; second } = date in

    (* Adjust the month and year for January and February *)
    let a = (months_in_year_offset - month) / 12 in
    let y = year + julian_year_offset - a in
    let m = month + (12 * a) - 3 in

    (* Calculate the Julian Day Number (JDN) using the appropriate formula *)
    let jdn =
      if is_gregorian date then
        (* Gregorian calendar formula *)
        day
        + (((month_conversion_factor * m) + 2) / 5)
        + (days_per_year * y) + (y / 4) - (y / century_divisor)
        + (y / quadricentennial_divisor)
        - gregorian_jdn_offset
      else
        (* Julian calendar formula *)
        day
        + (((month_conversion_factor * m) + 2) / 5)
        + (days_per_year * y) + (y / 4) - julian_jdn_offset
    in

    (* Calculate the fractional part of the day using constants *)
    let day_fraction =
      ((float_of_int hour -. noon_shift) /. hours_per_day)
      +. (float_of_int minute /. minutes_per_day)
      +. (float_of_int second /. seconds_per_day)
    in
    (* Move all to helpers? *)
    (* Combine the JDN and the fractional part of the day *)
    let jd = float_of_int jdn +. day_fraction in
    jd

  let to_string t : string =
    Format.asprintf "%04d-%02d-%02d %02d:%02d:%02d" t.year t.month t.day t.hour
      t.minute t.second

  let pp ppf d =
    Format.fprintf ppf
      "{ year = %d; month = %d; day = %d; hour = %d; minute = %d; second = %d }"
      d.year d.month d.day d.hour d.minute d.second

  let eq d1 d2 =
    d1.year = d2.year && d1.month = d2.month && d1.day = d2.day
    && d1.hour = d2.hour && d1.minute = d2.minute && d1.second = d2.second

  let eq_almost d1 d2 =
    d1.year = d2.year && d1.month = d2.month && d1.day = d2.day
end
