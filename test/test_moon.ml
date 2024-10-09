open Street_astronomy.Moon
open Street_astronomy.Chrono

module TestPhase = struct
  open Phase

  let phase_of_date_cases =
    [
      (* Test cases for 2023 *)
      (Date.of_ints 2023 12 12 23 32 26, New);
      (Date.of_ints 2023 8 24 04 57 00, FirstQuarter);
      (Date.of_ints 2023 5 12 15 00 26, LastQuarter);
      (Date.of_ints 2023 5 23 13 54 21, WaxingCrescent);
      (Date.of_ints 2023 5 31 13 54 21, WaxingGibbous);
      (* Test cases for 2024 *)
      (Date.of_ints 2024 10 5 22 26 26, WaxingCrescent);
      (Date.of_ints 2024 10 2 20 00 26, New);
      (Date.of_ints 2024 03 03 15 24 48, LastQuarter);
      (* January 6, 2000 e.g. jd_new_moon_epoch *)
      (Date.of_ints 2000 1 6 14 24 00, New);
      (* January 7, 2000*)
      (Date.of_ints 2000 1 7 14 24 00, WaxingCrescent);
      (* Moon phases for 2022 as of https://aa.usno.navy.mil *)
      (Date.of_ints 2010 10 07 18 44 00, New);
      (Date.of_ints 2010 10 14 21 27 00, FirstQuarter);
      (Date.of_ints 2010 10 23 01 36 00, Full);
      (Date.of_ints 2010 10 30 12 46 00, LastQuarter);
      (Date.of_ints 2010 11 06 04 52 00, New);
      (Date.of_ints 2010 11 13 16 39 00, FirstQuarter);
      (Date.of_ints 2010 11 21 17 27 00, Full);
      (Date.of_ints 2010 11 28 20 36 00, LastQuarter);
      (Date.of_ints 2010 12 05 17 36 00, New);
      (Date.of_ints 2010 12 13 13 59 00, FirstQuarter);
      (Date.of_ints 2010 12 21 08 13 00, Full);
      (Date.of_ints 2010 12 28 04 18 00, LastQuarter);
      (* Moon phases for 2024 as of https://aa.usno.navy.mil *)
      (Date.of_ints 2024 10 10 18 55 00, FirstQuarter);
      (Date.of_ints 2024 10 17 11 26 00, Full);
      (Date.of_ints 2024 10 24 08 03 00, LastQuarter);
      (Date.of_ints 2024 11 01 12 47 00, New);
      (Date.of_ints 2024 11 09 05 55 00, FirstQuarter);
      (Date.of_ints 2024 11 15 21 28 00, Full);
      (Date.of_ints 2024 11 23 01 28 00, LastQuarter);
      (Date.of_ints 2024 12 01 06 21 00, New);
      (Date.of_ints 2024 12 08 15 26 00, FirstQuarter);
      (Date.of_ints 2024 12 15 09 02 00, Full);
      (Date.of_ints 2024 12 22 22 18 00, LastQuarter);
      (Date.of_ints 2024 12 30 22 27 00, New);
      (* Moon phases for 2025  as of https://aa.usno.navy.mil *)
      (Date.of_ints 2025 01 06 23 56 00, FirstQuarter);
      (Date.of_ints 2025 01 13 22 27 00, Full);
      (Date.of_ints 2025 01 21 20 31 00, LastQuarter);
      (Date.of_ints 2025 01 29 12 36 00, New);
      (Date.of_ints 2025 02 05 08 02 00, FirstQuarter);
      (Date.of_ints 2025 02 12 13 53 00, Full);
      (Date.of_ints 2025 02 20 17 32 00, LastQuarter);
      (Date.of_ints 2025 02 28 00 45 00, New);
      (* Random phases from https://starwalk.space/en/moon-calendar *)
      (Date.of_ints 2024 01 01 19 00 00, WaningGibbous);
      (Date.of_ints 2024 28 03 19 00 00, WaningGibbous);
      (Date.of_ints 2024 30 08 19 00 00, WaningCrescent);
      (Date.of_ints 2024 10 08 19 00 00, WaxingCrescent);
      (* Random phases from https://www.timeanddate.com/moon/phases/ *)
      (Date.of_ints 2024 10 02 19 49 00, New);
      (Date.of_ints 2024 10 09 10 04 00, WaxingCrescent);
      (Date.of_ints 2024 10 10 19 55 00, FirstQuarter);
      (* Moon events from https://www.timeanddate.com/moon/phases/ *)
      (Date.of_ints 2024 10 17 12 26 00, Full);
      (* Hunter's Moon *)
      (Date.of_ints 2024 02 24 09 03 00, Full);
      (* Micro Moon *)
      (Date.of_ints 2023 01 06 23 07 00, Full);
      (* Super Moon *)
    ]

  let phase_testable = Alcotest.testable pp ( = )

  let test_phase_of_date_cases () =
    List.iter
      (fun (date, expected_phase) ->
        Alcotest.(check phase_testable)
          "test phase_of_date" expected_phase (details_of_date date).phase)
      phase_of_date_cases
end
