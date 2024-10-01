open Julian

exception ImpossiblePhase of string

type illumination =
  | Crescent
  | Quarter
  | Gibbous

type phase =
  | New
  | Waxing of illumination
  | Full
  | Waning of illumination

let describe_phase = function
  | New -> "New"
  | Waxing Crescent -> "Waxing Crescent"
  | Waxing Quarter -> "First Quarter"
  | Waxing Gibbous -> "Waxing Gibbous"
  | Full -> "Full"
  | Waning Gibbous -> "Waning Gibbous"
  | Waning Quarter -> "Last Quarter"
  | Waning Crescent -> "Waning Crescent"

type moon_phase = {
  phase : phase;
  age_in_days : float;
  illumination_percent : float;
}

(* Helper function to convert degrees to radians *)
let deg_to_rad deg = deg *. Float.pi /. 180.0


(* Helper function to compare floating-point numbers with a tolerance *)
let float_equal a b epsilon = abs_float (a -. b) < epsilon

(* Calculate the Moon phase based on its age in days since the last New Moon *)
let phase_of_age age_in_days =
  (* Wrap the age within a single synodic month *)
  let phase = mod_float age_in_days Constants.synodic_month in
  (* Define tolerance for floating-point comparisons *)
  let epsilon = 1e-6 in

  (* Phase boundaries based on the synodic month *)
  let new_moon_end = 3.6913 in                    (* Boundary for New Moon *)
  let waxing_crescent_end = 7.3826 in             (* Boundary for Waxing Crescent *)
  let first_quarter_end = 11.0739 in              (* Boundary for First Quarter *)
  let waxing_gibbous_end = 14.7652 in             (* Boundary for Waxing Gibbous *)
  let full_moon_end = 18.4565 in                  (* Boundary for Full Moon *)
  let waning_gibbous_end = 22.1478 in             (* Boundary for Waning Gibbous *)
  let last_quarter_end = 25.8391 in               (* Boundary for Last Quarter *)

  (* Determine the phase based on the boundaries *)
  if age_in_days < 0.0 then raise (ImpossiblePhase "Negative phase")
  else if age_in_days > Constants.synodic_month then raise (ImpossiblePhase "Phase exceeds synodic month")
  else if float_equal phase 0.0 epsilon || phase < new_moon_end -. epsilon then New
  else if phase < waxing_crescent_end -. epsilon then Waxing Crescent
  else if phase < first_quarter_end -. epsilon then Waxing Quarter
  else if phase < waxing_gibbous_end -. epsilon then Waxing Gibbous
  else if phase < full_moon_end -. epsilon then Full
  else if phase < waning_gibbous_end -. epsilon then Waning Gibbous
  else if phase < last_quarter_end -. epsilon then Waning Quarter
  else if float_equal phase Constants.synodic_month epsilon || phase < Constants.synodic_month then Waning Crescent
  else failwith "Impossible phase"

let days_since_epoch jd =
  jd -. Constants.jd_epoch_2000

let mean_longitude days =
  let mean_long = 218.316 +. 13.176396 *. days in
  mod_float mean_long 360.0  (* Ensure the value is between 0 and 360 degrees *)

let sun_mean_anomaly days =
  let mean_anomaly = 357.5291 +. 0.98560028 *. days in
  mod_float mean_anomaly 360.0

let moon_mean_anomaly days =
  let mean_anomaly = 134.963 +. 13.064993 *. days in
  mod_float mean_anomaly 360.0

let phase_angle jd =
  let days = days_since_epoch jd in
  let mean_long = mean_longitude days in
  let m_s = sun_mean_anomaly days in
  let m_m = moon_mean_anomaly days in
  let elongation = mean_long -. m_s in  (* Elongation of the Moon *)

(* Phase angle uses both Sun's and Moon's mean anomalies for better accuracy *)
let phase_angle = elongation -. 6.289 *. sin (deg_to_rad m_m)
                            +. 2.100 *. sin (deg_to_rad m_s)
                            -. 1.274 *. sin (deg_to_rad (2.0 *. elongation -. m_m))
                            -. 0.658 *. sin (deg_to_rad (2.0 *. elongation))
                            -. 0.214 *. sin (deg_to_rad (2.0 *. m_m))
                            -. 0.110 *. sin (deg_to_rad elongation) in
  mod_float phase_angle 360.0


let phase_of_jd jd =
  let days = days_since_epoch jd in
  let age = mod_float days Constants.synodic_month in
  phase_of_age age

let phase_info jd =
  let age_in_days = mod_float (days_since_epoch jd) Constants.synodic_month in
  let phase_angle = phase_angle jd in
  let illumination_percent = 100.0 *. (1.0 +. cos (deg_to_rad phase_angle)) /. 2.0 in
  { phase = phase_of_jd jd; age_in_days; illumination_percent }
