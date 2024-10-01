(* moon.mli: Calculate the phase of the Moon and provide phase information *)

(* Exception for invalid phase calculations *)
exception ImpossiblePhase of string


(* The illumination of the Moon *)
type illumination = Crescent | Quarter | Gibbous

(* The phase of the Moon *)
type phase = New | Waxing of illumination | Full | Waning of illumination

(* Record to represent the phase of the Moon along with other details *)
type moon_phase = {
  phase : phase;                (* Current phase (e.g., Waxing Crescent, Full) *)
  age_in_days : float;          (* Age of the Moon in days since the last New Moon *)
  illumination_percent : float; (* Percent of the Moon's face that is illuminated *)
}

(* Convert a phase to a string *)
val describe_phase : phase -> string


(* Calculate the phase of the Moon given its age in days *)
val phase_of_age : float -> phase

(* Provide the Moon phase information based on the Julian Date *)
val phase_info : float -> moon_phase
