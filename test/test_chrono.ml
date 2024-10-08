open Street_astronomy.Chrono

type of_int_params = int * int * int * int * int * int

module TestDate = struct
  (* List of test cases: (input parameters, expected Date.t) *)

  let of_int_cases : (of_int_params * Date.t) list =
    [
      ( (1, 1, 1, 0, 0, 0),
        (* Edge case for early dates *)
        { year = 1; month = 1; day = 1; hour = 0; minute = 0; second = 0 } );
      ( (1970, 1, 1, 0, 0, 0),
        (* Unix epoch date *)
        { year = 1970; month = 1; day = 1; hour = 0; minute = 0; second = 0 } );
      ( (2021, 1, 1, 1, 1, 1),
        (* Start of a year *)
        { year = 2021; month = 1; day = 1; hour = 1; minute = 1; second = 1 } );
      ( (2021, 12, 31, 23, 59, 59),
        (* End of a year *)
        {
          year = 2021;
          month = 12;
          day = 31;
          hour = 23;
          minute = 59;
          second = 59;
        } );
    ]

  let julian_cases : (Date.t * float) list =
    [
      ( { year = 1; month = 1; day = 1; hour = 0; minute = 0; second = 0 },
        1721423.5 );
      ( { year = 2000; month = 1; day = 1; hour = 12; minute = 0; second = 0 },
        2451545.0 );
      ( { year = 1970; month = 1; day = 1; hour = 0; minute = 0; second = 0 },
        2440587.50 );
      ( { year = 2021; month = 1; day = 1; hour = 1; minute = 1; second = 1 },
        2459215.542373 );
      ( {
          year = 2021;
          month = 12;
          day = 31;
          hour = 23;
          minute = 59;
          second = 59;
        },
        2459580.499988 );
      ( { year = 2024; month = 10; day = 3; hour = 1; minute = 1; second = 1 },
        2460586.542373 );
    ]

  let date_testable = Alcotest.testable Date.pp Date.eq
  let date_testable_almost = Alcotest.testable Date.pp Date.eq_almost
  let float_testable = Alcotest.float 0.0001

  let test_of_int_cases () =
    List.iter
      (fun ((year, month, day, hour, minute, second), expected_date) ->
        let result = Date.of_ints year month day hour minute second in
        Alcotest.(check date_testable) "test Date.of_ints" expected_date result)
      of_int_cases

  let test_to_julian_cases () =
    List.iter
      (fun (date, expected_julian) ->
        let result = Date.to_julian date in
        Alcotest.(check float_testable)
          "test Date.to_julian" expected_julian result)
      julian_cases

  let test_from_julian_cases () =
    List.iter
      (fun (expected_date, julian) ->
        let result = Date.from_julian julian in
        Alcotest.(check date_testable)
          "test Date.from_julian" expected_date result)
      julian_cases

  let test_from_julian_fvf_cases () =
    List.iter
      (fun (expected_date, julian) ->
        let result = Date.from_julian_fvf julian in
        Alcotest.(check date_testable_almost)
          "test Date.from_julian_fvf" expected_date result)
      julian_cases
end
