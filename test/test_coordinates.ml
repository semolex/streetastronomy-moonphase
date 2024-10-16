open Street_astronomy.Coordinates

module TestEquatorial = struct
  open Equatorial

  let from_degrees_to_degrees_cases =
    [
      (0.0, 0.0, 0.0, 0.0);
      (90.0, 0.0, 90.0, 0.0);
      (180.0, 0.0, 180.0, 0.0);
      (270.0, 0.0, 270.0, 0.0);
      (0.0, 90.0, 0.0, 90.0);
      (0.0, -90.0, 0.0, -90.0);
      (180.0, 90.0, 180.0, 90.0);
      (180.0, -90.0, 180.0, -90.0);
      (0.0, 45.0, 0.0, 45.0);
      (90.0, 45.0, 90.0, 45.0);
      (180.0, 45.0, 180.0, 45.0);
      (270.0, 45.0, 270.0, 45.0);
      (0.0, -45.0, 0.0, -45.0);
      (90.0, -45.0, 90.0, -45.0);
      (180.0, -45.0, 180.0, -45.0);
      (270.0, -45.0, 270.0, -45.0);
      (0.0, 89.999, 0.0, 89.999);
      (90.0, 89.999, 90.0, 89.999);
      (180.0, 89.999, 180.0, 89.999);
      (270.0, 89.999, 270.0, 89.999);
      (0.0, -89.999, 0.0, -89.999);
      (90.0, -89.999, 90.0, -89.999);
      (180.0, -89.999, 180.0, -89.999);
      (270.0, -89.999, 270.0, -89.999);
    ]

  let from_degrees_cases =
    [
      ( {
          ra = { hours = 18; minutes = 36; seconds = 56.33635 };
          dec = { degrees = 38; arcminutes = 47; arcseconds = 1.2802 };
        },
        (279.236200, 38.783611) );
    ]

  let degrees_testable = Alcotest.float 0.0001
  let epsilon = 0.9

  let ra_equal ra1 ra2 =
    ra1.hours = ra2.hours && ra1.minutes = ra2.minutes
    && abs_float (ra1.seconds -. ra2.seconds) < epsilon

  let dec_equal dec1 dec2 =
    dec1.degrees = dec2.degrees
    && dec1.arcminutes = dec2.arcminutes
    && abs_float (dec1.arcseconds -. dec2.arcseconds) < epsilon

  let eq_equal eq1 eq2 = ra_equal eq1.ra eq2.ra && dec_equal eq1.dec eq2.dec
  let eq_pp ppf eq = Format.fprintf ppf "%s" (to_string eq)
  let eq_testable = Alcotest.testable eq_pp eq_equal

  let test_from_degrees_to_degrees_cases () =
    List.iter
      (fun (ra, dec, expected_ra, expected_dec) ->
        let eq = from_degrees ra dec in
        let ra', dec' = to_degrees eq in
        Alcotest.(check degrees_testable) "ra" expected_ra ra';
        Alcotest.(check degrees_testable) "dec" expected_dec dec')
      from_degrees_to_degrees_cases

  let test_from_degrees_cases () =
    List.iter
      (fun (expected_eq, (ra, dec)) ->
        let eq = from_degrees ra dec in
        let rap, decp = to_degrees eq in
        Printf.printf "Expected!: %f %f\n" rap decp;
        (* Check that the generated record matches the expected one using the eq_equal function *)
        Alcotest.(check eq_testable "Equatorial from degrees" expected_eq eq);

        (* Now convert back to degrees and check if they match the original inputs *)
        let ra', dec' = to_degrees eq in
        Alcotest.(check degrees_testable) "RA from record" ra ra';
        Alcotest.(check degrees_testable) "Dec from record" dec dec')
      from_degrees_cases
end
