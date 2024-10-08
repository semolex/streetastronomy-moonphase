(* Main test suite runner for the Street_astronomy library *)
let () =
  Alcotest.run "Street_astronomy Tests"
    [
      ( "of_int_cases",
        [
          Alcotest.test_case "Chrono.Date.of_ints" `Quick
            Test_chrono.TestDate.test_of_int_cases;
        ] );
      ( "to_julian_cases",
        [
          Alcotest.test_case "Chrono.Date.to_julian" `Quick
            Test_chrono.TestDate.test_to_julian_cases;
        ] );
      ( "from_julian_cases",
        [
          Alcotest.test_case "Chrono.Date.from_julian" `Quick
            Test_chrono.TestDate.test_from_julian_cases;
        ] );
      ( "from_julian_cases_fvf",
        [
          Alcotest.test_case "Chrono.Date.from_julian_fvf" `Quick
            Test_chrono.TestDate.test_from_julian_fvf_cases;
        ] );
      ( "phase_of_date",
        [
          Alcotest.test_case "Moon.phase_of_date" `Quick
            Test_moon.TestPhase.test_phase_of_date_cases;
        ] );
    ]
