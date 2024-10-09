open Constants
open CalendarLib.Calendar

module Phase = struct
  type phase =
    | New
    | FirstQuarter
    | Full
    | LastQuarter
    | WaxingCrescent
    | WaxingGibbous
    | WaningGibbous
    | WaningCrescent

  type phase_details = {
    phase : phase; (* The Moon phase classification *)
    age : float; (* Moon's age in days since the last New Moon *)
    illumination : float;
  }

  (* Mathematical helper functions *)
  let deg_to_rad deg = deg *. Float.pi /. 180.0
  let rad_to_deg rad = rad *. 180.0 /. Float.pi

  (* Helper function to describe the current Moon phase as a string *)
  let string_of_phase = function
    | New -> "New"
    | FirstQuarter -> "First Quarter"
    | Full -> "Full"
    | LastQuarter -> "Last Quarter"
    | WaxingCrescent -> "Waxing Crescent"
    | WaxingGibbous -> "Waxing Gibbous"
    | WaningGibbous -> "Waning Gibbous"
    | WaningCrescent -> "Waning Crescent"

  (* Normalize angle to the range [0, 360) degrees *)
  let normalize_angle angle =
    let a = mod_float angle 360.0 in
    if a < 0.0 then a +. 360.0 else a

  (* Correct the calculation of the Moon's age based on the nearest New Moon *)
  let moon_age jd epoch =
    (* Calculate the number of days since the epoch *)
    let since_epoch = jd -. epoch in

    (* Calculate the Moon's age in days since the last New Moon *)
    let age = mod_float since_epoch synodic_month in

    (* Ensure the Moon's age falls within [0, synodic_month) range *)
    if age < 0.0 then age +. synodic_month else age

  (* Calculate the mean elongation of the Moon *)
  let mean_elongation_moon jd =
    let t = (jd -. jd_epoch_2000) /. days_in_julian_century in
    let d =
      297.8501921 +. (445267.1114034 *. t)
      -. (0.0018819 *. t *. t)
      +. (1.0 /. 545868.0 *. t *. t *. t)
      -. (1.0 /. 113065000.0 *. t *. t *. t *. t)
    in
    normalize_angle d

  (* Calculate the mean anomaly of the Sun *)
  let mean_anomaly_sun jd =
    let t = (jd -. jd_epoch_2000) /. days_in_julian_century in
    let m =
      357.5291092 +. (35999.0502909 *. t)
      -. (0.0001536 *. t *. t)
      +. (1.0 /. 24490000.0 *. t *. t *. t)
    in
    normalize_angle m

  let mean_anomaly_moon jd =
    let t = (jd -. jd_epoch_2000) /. days_in_julian_century in
    let mp =
      134.9633964 +. (477198.8675055 *. t)
      +. (0.0087414 *. t *. t)
      +. (1.0 /. 69699.0 *. t *. t *. t)
      -. (1.0 /. 14712000.0 *. t *. t *. t *. t)
    in
    normalize_angle mp

  (* Mean longitude of the Sun *)
  let mean_longitude_sun jd =
    let d = jd -. jd_epoch_2000 in
    normalize_angle (280.459 +. (0.98564736 *. d))

  (* Apparent ecliptic longitude of the Sun *)
  let apparent_ecliptic_longitude_sun jd =
    let g = deg_to_rad (mean_anomaly_sun jd) in
    let q = mean_longitude_sun jd in
    let l = q +. (1.915 *. sin g) +. (0.020 *. sin (2.0 *. g)) in
    normalize_angle l

  let mean_longitude_moon jd =
    let d = jd -. jd_epoch_2000 in
    normalize_angle (218.316 +. (13.176396 *. d))

  (* Calculate the Moon's true longitude *)
  let true_longitude_moon jd =
    let m = deg_to_rad (mean_anomaly_moon jd) in
    let d = deg_to_rad (mean_elongation_moon jd) in
    let l0 = mean_longitude_moon jd in
    let l_true =
      l0
      +. (6.289 *. sin m)
      -. (1.274 *. sin (2.0 *. d))
      +. (0.658 *. sin (2.0 *. deg_to_rad (mean_longitude_sun jd)))
    in
    normalize_angle l_true

  (* Calculate the phase angle between the Moon and the Sun *)
  let phase_angle jd =
    let l_moon = true_longitude_moon jd in
    let l_sun = apparent_ecliptic_longitude_sun jd in
    normalize_angle (l_moon -. l_sun)

  let classify_moon_phase phase_angle =
    (* Define separate tolerances for New Moon and Quarter phases *)
    let epsilon_new_moon = 3.0 in
    (* Tolerance for New Moon classification *)
    let epsilon_quarters = 3.0 in

    (* Increased tolerance for Quarter phases *)
    match phase_angle with
    (* Special handling for New Moon: phase angles close to 0 or 360 degrees *)
    | angle when angle < epsilon_new_moon || angle >= 360.0 -. epsilon_new_moon
      ->
        New
    (* Handle Quarter phases with an increased tolerance range *)
    | angle
      when angle >= 90.0 -. epsilon_quarters
           && angle <= 90.0 +. epsilon_quarters ->
        FirstQuarter
    | angle
      when angle >= 180.0 -. epsilon_quarters
           && angle <= 180.0 +. epsilon_quarters ->
        Full
    | angle
      when angle >= 270.0 -. epsilon_quarters
           && angle <= 270.0 +. epsilon_quarters ->
        LastQuarter
    (* General classification for other phases *)
    | angle when angle > epsilon_new_moon && angle < 90.0 -. epsilon_quarters ->
        WaxingCrescent
    | angle
      when angle > 90.0 +. epsilon_quarters && angle < 180.0 -. epsilon_quarters
      ->
        WaxingGibbous
    | angle
      when angle > 180.0 +. epsilon_quarters
           && angle < 270.0 -. epsilon_quarters ->
        WaningGibbous
    | angle
      when angle > 270.0 +. epsilon_quarters
           && angle < 360.0 -. epsilon_new_moon ->
        WaningCrescent
    (* Default to New Moon if no other condition is met *)
    | _ -> New

  let illumination_percent angle =
    (* Calculate the angle distance from the Full Moon *)
    let phase_angle_effective = abs_float (180.0 -. angle) in
    let phase_angle_rad = deg_to_rad phase_angle_effective in
    (* Calculate the illumination using the cosine formula, scaled appropriately *)
    (1.0 +. cos phase_angle_rad) /. 2.0 *. 100.0

  (* Calculate Moon's phase and illumination for a given Julian Date *)
  let details_of_julian jd =
    let angle = phase_angle jd in
    let phase = classify_moon_phase angle in
    let age = moon_age jd jd_new_moon_epoch in

    let illumination = illumination_percent angle in
    { phase; illumination; age }

  let details_of_date date = details_of_julian (Precise.to_jd date)

  let details_of_date_int year month day hour minute second =
    let cal_date_time = Precise.make year month day hour minute second in
    let jd = Precise.to_jd cal_date_time in
    details_of_julian jd

  let phase_calendar start_date end_date =
    let rec aux current_date acc =
      if CalendarLib.Calendar.Precise.compare current_date end_date > 0 then
        List.rev acc (* Reverse the accumulated list to maintain order *)
      else
        let phase_details = details_of_date current_date in
        let new_entry = (current_date, phase_details) in
        (* Move to the next day using the add function for Precise *)
        let next_date =
          CalendarLib.Calendar.Precise.add current_date
            (CalendarLib.Calendar.Precise.Period.day 1)
        in
        aux next_date (new_entry :: acc)
    in
    aux start_date []

  let pp fmt phase = Format.fprintf fmt "%s" (string_of_phase phase)
end
