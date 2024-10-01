(* test_street_astronomy.ml *)
open OUnit2
open Street_astronomy.Moon
open Street_astronomy.Julian

(* Custom printer for Moon.phase *)
let phase_printer phase =
  describe_phase phase


let test_describe_phase _ =
  (* Use assert_equal with a custom printer to show expected and actual phase *)
  assert_equal ~printer:describe_phase New New;
  assert_equal ~printer:describe_phase (Waxing Crescent) (Waxing Crescent);
  assert_equal ~printer:describe_phase (Waxing Quarter) (Waxing Quarter);
  assert_equal ~printer:describe_phase (Waxing Gibbous) (Waxing Gibbous);
  assert_equal ~printer:describe_phase Full Full;
  assert_equal ~printer:describe_phase (Waning Gibbous) (Waning Gibbous);
  assert_equal ~printer:describe_phase (Waning Quarter) (Waning Quarter);
  assert_equal ~printer:describe_phase (Waning Crescent) (Waning Crescent);

  print_endline "All describe_phase tests passed successfully!"


let test_phase_of_age _ =
  (* Use assert_equal with a custom printer to show expected and actual phase *)
  assert_equal ~printer:phase_printer New (phase_of_age 0.0);
  assert_equal ~printer:phase_printer New (phase_of_age 3.6912);
  assert_equal ~printer:phase_printer (Waxing Crescent) (phase_of_age 3.6913);
  assert_equal ~printer:phase_printer (Waxing Crescent) (phase_of_age 7.3825);
  assert_equal ~printer:phase_printer (Waxing Quarter) (phase_of_age 7.3826);
  assert_equal ~printer:phase_printer (Waxing Quarter) (phase_of_age 11.0738);
  assert_equal ~printer:phase_printer (Waxing Gibbous) (phase_of_age 11.0739);
  assert_equal ~printer:phase_printer (Waxing Gibbous) (phase_of_age 14.7651);
  assert_equal ~printer:phase_printer Full (phase_of_age 14.7652);
  assert_equal ~printer:phase_printer Full (phase_of_age 18.4564);
  assert_equal ~printer:phase_printer (Waning Gibbous) (phase_of_age 18.4565);
  assert_equal ~printer:phase_printer (Waning Gibbous) (phase_of_age 22.1477);
  assert_equal ~printer:phase_printer (Waning Quarter) (phase_of_age 22.1478);
  assert_equal ~printer:phase_printer (Waning Quarter) (phase_of_age 25.8390);
  assert_equal ~printer:phase_printer (Waning Crescent) (phase_of_age 25.8391);
  assert_equal ~printer:phase_printer (Waning Crescent) (phase_of_age (Constants.synodic_month -. 1e-6));  (* Just before 29.53 *)
  assert_equal ~printer:phase_printer New (phase_of_age Constants.synodic_month);  (* Full cycle back to New *)

  (* Test near-boundary values to ensure correct phase categorization *)
  assert_equal ~printer:phase_printer New (phase_of_age 0.5);  (* Close to New Moon *)
  assert_equal ~printer:phase_printer (Waxing Crescent) (phase_of_age 4.0);  (* Middle of Waxing Crescent *)
  assert_equal ~printer:phase_printer (Waxing Quarter) (phase_of_age 8.0);   (* Middle of First Quarter *)
  assert_equal ~printer:phase_printer (Waxing Gibbous) (phase_of_age 12.0);  (* Middle of Waxing Gibbous *)
  assert_equal ~printer:phase_printer Full (phase_of_age 15.0);  (* Middle of Full Moon *)
  assert_equal ~printer:phase_printer (Waning Gibbous) (phase_of_age 19.0);  (* Middle of Waning Gibbous *)
  assert_equal ~printer:phase_printer (Waning Quarter) (phase_of_age 23.0);  (* Middle of Last Quarter *)
  assert_equal ~printer:phase_printer (Waning Crescent) (phase_of_age 27.0); (* Middle of Waning Crescent *)

  (* Test edge cases for phase transitions *)
  assert_equal ~printer:phase_printer (Waxing Crescent) (phase_of_age 3.6913);  (* Exact transition from New to Waxing Crescent *)
  assert_equal ~printer:phase_printer (Waxing Quarter) (phase_of_age 7.3826);   (* Exact transition from Waxing Crescent to First Quarter *)
  assert_equal ~printer:phase_printer (Waxing Gibbous) (phase_of_age 11.0739);  (* Exact transition from First Quarter to Waxing Gibbous *)
  assert_equal ~printer:phase_printer Full (phase_of_age 14.7652);              (* Exact transition from Waxing Gibbous to Full Moon *)
  assert_equal ~printer:phase_printer (Waning Gibbous) (phase_of_age 18.4565);  (* Exact transition from Full to Waning Gibbous *)
  assert_equal ~printer:phase_printer (Waning Quarter) (phase_of_age 22.1478);  (* Exact transition from Waning Gibbous to Last Quarter *)
  assert_equal ~printer:phase_printer (Waning Crescent) (phase_of_age 25.8391); (* Exact transition from Last Quarter to Waning Crescent *)

  (* Check if the function raises the custom exception when given a negative age/value is too big *)
  (* THIS SHOULD BE REMOVED IN FAVOR OF USING NORMALIZATION IN THE FUNCTION *)
  assert_raises
    (ImpossiblePhase "Negative phase")
    (fun () -> phase_of_age (-100.0));

  assert_raises
    (ImpossiblePhase "Phase exceeds synodic month")
    (fun () -> phase_of_age 30.0);

  print_endline "All phase_of_age tests passed successfully!"

(* Test suite *)
let suite =
  "StreetAstronomy Tests" >::: [
    "test_describe_phase" >:: test_describe_phase;
    "test_phase_of_age" >:: test_phase_of_age;
  ]

(* Run the test suite *)
let () =
  run_test_tt_main suite
