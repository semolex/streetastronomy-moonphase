(* Main test suite runner for the Street_astronomy library *)
let () =
  Alcotest.run "Street_astronomy Tests"
    [
      ( "phase_of_date",
        [
          Alcotest.test_case "Moon.phase_of_date" `Quick
            Test_moon.TestPhase.test_phase_of_date_cases;
        ] );
      ( "phase_calendar",
        [
          Alcotest.test_case "Moon.phase_calendar" `Quick
            Test_moon.TestPhase.test_phase_calendar_cases;
        ] );
      ( "test_from_degrees_to_degrees_cases",
        [
          Alcotest.test_case "Coordinates.test_from_degrees_to_degrees_cases"
            `Quick
            Test_coordinates.TestEquatorial.test_from_degrees_to_degrees_cases;
        ] );
      ( "test_from_degrees_cases",
        [
          Alcotest.test_case "Coordinates.test_from_degrees_to_degrees_cases"
            `Quick Test_coordinates.TestEquatorial.test_from_degrees_cases;
        ] );
    ]
