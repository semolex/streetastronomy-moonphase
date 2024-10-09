open Street_astronomy.Moon
open CalendarLib.Calendar

module TestPhase = struct
  open Phase

  let phase_of_date_cases =
    [
      (* Test cases for 2023 *)
      (Precise.make 2023 12 12 23 32 26, New);
      (Precise.make 2023 8 24 04 57 00, FirstQuarter);
      (Precise.make 2023 5 12 15 00 26, LastQuarter);
      (Precise.make 2023 5 23 13 54 21, WaxingCrescent);
      (Precise.make 2023 5 31 13 54 21, WaxingGibbous);
      (* Test cases for 2024 *)
      (Precise.make 2024 10 5 22 26 26, WaxingCrescent);
      (Precise.make 2024 10 2 20 00 26, New);
      (Precise.make 2024 03 03 15 24 48, LastQuarter);
      (* January 6, 2000 e.g. jd_new_moon_epoch *)
      (Precise.make 2000 1 6 14 24 00, New);
      (* January 7, 2000*)
      (Precise.make 2000 1 7 14 24 00, WaxingCrescent);
      (* Moon phases for 2022 as of https://aa.usno.navy.mil *)
      (Precise.make 2010 10 07 18 44 00, New);
      (Precise.make 2010 10 14 21 27 00, FirstQuarter);
      (Precise.make 2010 10 23 01 36 00, Full);
      (Precise.make 2010 10 30 12 46 00, LastQuarter);
      (Precise.make 2010 11 06 04 52 00, New);
      (Precise.make 2010 11 13 16 39 00, FirstQuarter);
      (Precise.make 2010 11 21 17 27 00, Full);
      (Precise.make 2010 11 28 20 36 00, LastQuarter);
      (Precise.make 2010 12 05 17 36 00, New);
      (Precise.make 2010 12 13 13 59 00, FirstQuarter);
      (Precise.make 2010 12 21 08 13 00, Full);
      (Precise.make 2010 12 28 04 18 00, LastQuarter);
      (* Moon phases for 2024 as of https://aa.usno.navy.mil *)
      (Precise.make 2024 10 10 18 55 00, FirstQuarter);
      (Precise.make 2024 10 17 11 26 00, Full);
      (Precise.make 2024 10 24 08 03 00, LastQuarter);
      (Precise.make 2024 11 01 12 47 00, New);
      (Precise.make 2024 11 09 05 55 00, FirstQuarter);
      (Precise.make 2024 11 15 21 28 00, Full);
      (Precise.make 2024 11 23 01 28 00, LastQuarter);
      (Precise.make 2024 12 01 06 21 00, New);
      (Precise.make 2024 12 08 15 26 00, FirstQuarter);
      (Precise.make 2024 12 15 09 02 00, Full);
      (Precise.make 2024 12 22 22 18 00, LastQuarter);
      (Precise.make 2024 12 30 22 27 00, New);
      (* Moon phases for 2025  as of https://aa.usno.navy.mil *)
      (Precise.make 2025 01 06 23 56 00, FirstQuarter);
      (Precise.make 2025 01 13 22 27 00, Full);
      (Precise.make 2025 01 21 20 31 00, LastQuarter);
      (Precise.make 2025 01 29 12 36 00, New);
      (Precise.make 2025 02 05 08 02 00, FirstQuarter);
      (Precise.make 2025 02 12 13 53 00, Full);
      (Precise.make 2025 02 20 17 32 00, LastQuarter);
      (Precise.make 2025 02 28 00 45 00, New);
      (* Random phases from https://starwalk.space/en/moon-calendar *)
      (Precise.make 2024 01 01 19 00 00, WaningGibbous);
      (Precise.make 2024 28 03 19 00 00, WaningGibbous);
      (Precise.make 2024 30 08 19 00 00, WaningCrescent);
      (Precise.make 2024 10 08 19 00 00, WaxingCrescent);
      (* Random phases from https://www.timeanddate.com/moon/phases/ *)
      (Precise.make 2024 10 02 19 49 00, New);
      (Precise.make 2024 10 09 10 04 00, WaxingCrescent);
      (Precise.make 2024 10 10 19 55 00, FirstQuarter);
      (* Moon events from https://www.timeanddate.com/moon/phases/ *)
      (Precise.make 2024 10 17 12 26 00, Full);
      (* Hunter's Moon *)
      (Precise.make 2024 02 24 09 03 00, Full);
      (* Micro Moon *)
      (Precise.make 2023 01 06 23 07 00, Full);
      (* Super Moon *)
    ]

  let phase_calendar_test_cases =
    [
      (* Test case for a range of dates in August 2024 *)
      ( (Precise.make 2024 08 01 11 13 00, Precise.make 2024 08 10 11 13 00),
        (* Expected phases for each day from August 1 to August 10, 2024 *)
        [
          WaningCrescent;
          (* August 1, 2024 *)
          WaningCrescent;
          (* August 2, 2024 *)
          WaningCrescent;
          (* August 3, 2024 *)
          New;
          (* August 4, 2024 *)
          WaxingCrescent;
          (* August 5, 2024 *)
          WaxingCrescent;
          (* August 6, 2024 *)
          WaxingCrescent;
          (* August 7, 2024 *)
          WaxingCrescent;
          (* August 8, 2024 *)
          WaxingCrescent;
          (* August 9, 2024 *)
          WaxingCrescent;
          (* August 10, 2024 *)
        ] );
      ( (Precise.make 2024 01 17 11 13 00, Precise.make 2024 01 19 11 13 00),
        (* Expected phases for each day from January 17 to January 19, 2024 *)
        [
          WaxingCrescent;
          (* January 17, 2024 *)
          FirstQuarter;
          (* January 18, 2024 *)
          WaxingGibbous;
          (* January 19, 2024 *)
        ] );
    ]

  let phase_testable = Alcotest.testable pp ( = )

  let test_phase_of_date_cases () =
    List.iter
      (fun (date, expected_phase) ->
        Alcotest.(check phase_testable)
          "test phase_of_date" expected_phase (details_of_date date).phase)
      phase_of_date_cases

  let test_phase_calendar_cases () =
    List.iter
      (fun ((start_date, end_date), expected_phases) ->
        let phases = phase_calendar start_date end_date in
        print_calendar phases;

        (* Extract just the phase from each phase_details tuple *)
        let actual_phases =
          List.map (fun (_, phase_details) -> phase_details.phase) phases
        in

        (* Check the expected phases against the actual phases *)
        Alcotest.(check (list phase_testable))
          "test phase_calendar" expected_phases actual_phases)
      phase_calendar_test_cases
end
