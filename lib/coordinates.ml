type coordinates = Eq | Gal | Ecl | AltAz

exception Invalid_coordinates of string

module Equatorial = struct
  type right_ascension = { hours : int; minutes : int; seconds : float }
  type declination = { degrees : int; arcminutes : int; arcseconds : float }
  type t = { ra : right_ascension; dec : declination }

  let to_degrees coord =
    let total_ra =
      float_of_int coord.ra.hours
      +. (float_of_int coord.ra.minutes /. 60.0)
      +. (coord.ra.seconds /. 3600.0)
    in
    let total_dec =
      float_of_int coord.dec.degrees
      +. (float_of_int coord.dec.arcminutes /. 60.0)
      +. (coord.dec.arcseconds /. 3600.0)
    in
    (total_ra *. 15.0, total_dec)

  let to_string eq =
    Printf.sprintf
      "{ ra = { hours = %d; minutes = %d; seconds = %.2f }; dec = { degrees = \
       %d; arcminutes = %d; arcseconds = %.2f } }"
      eq.ra.hours eq.ra.minutes eq.ra.seconds eq.dec.degrees eq.dec.arcminutes
      eq.dec.arcseconds

  let from_degrees ra dec =
    (* Convert RA from degrees to hours, minutes, seconds *)
    let total_hours = ra /. 15.0 in
    let hours = int_of_float total_hours in
    let remaining_hours = total_hours -. float_of_int hours in
    let minutes = int_of_float (remaining_hours *. 60.0) in
    let seconds =
      (remaining_hours *. 3600.0) -. (float_of_int minutes *. 60.0)
    in

    (* Convert Dec from degrees to degrees, arcminutes, arcseconds *)
    let degrees = int_of_float dec in
    let remaining_dec = dec -. float_of_int degrees in
    let arcminutes = int_of_float (remaining_dec *. 60.0) in
    let arcseconds =
      (remaining_dec *. 3600.0) -. (float_of_int arcminutes *. 60.0)
    in

    {
      ra = { hours; minutes; seconds };
      dec = { degrees; arcminutes; arcseconds };
    }

  let angular_distance coord1 coord2 =
    let ra1, dec1 = to_degrees coord1 in
    let ra2, dec2 = to_degrees coord2 in
    let ra1_rad = ra1 *. Float.pi /. 180.0 in
    let dec1_rad = dec1 *. Float.pi /. 180.0 in
    let ra2_rad = ra2 *. Float.pi /. 180.0 in
    let dec2_rad = dec2 *. Float.pi /. 180.0 in
    let delta_ra = ra1_rad -. ra2_rad in
    let delta_dec = dec1_rad -. dec2_rad in
    let a =
      (sin (delta_dec /. 2.0) *. sin (delta_dec /. 2.0))
      +. cos dec1_rad *. cos dec2_rad
         *. sin (delta_ra /. 2.0)
         *. sin (delta_ra /. 2.0)
    in
    let c = 2.0 *. atan2 (sqrt a) (sqrt (1.0 -. a)) in
    c *. 180.0 /. Float.pi (* Result in degrees *)
end
