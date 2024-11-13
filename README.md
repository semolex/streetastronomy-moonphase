# streetastronomy-moonphase

A specialized OCaml library for accurate Moon phase calculations.

## Overview

`streetastronomy-moonphase` is a precise astronomical calculation library focused on lunar phases. Implemented in OCaml, it provides accurate calculations based on well-established astronomical algorithms, particularly those from Jean Meeus's "Astronomical Algorithms".

## Features

- **Moon Phase Calculations**:
  - Determine the current phase of the Moon (New, Full, Quarter phases, etc.)
  - Calculate the Moon's age since last New Moon
  - Calculate illumination percentage
  - Generate phase calendars for date ranges

- **Precise Date Handling**:
  - Support for Julian date calculations
  - Integration with CalendarLib for accurate date manipulations
  - Support for various date input formats

## Installation

As of now it is not available on opam. You can clone the repository and build it locally.

```sh
git clone <URL>
cd streetastronomy-moonphase
dune build
```

## Usage

```ocaml
open Street_astronomy.Moon

(* Get current Moon phase details *)
let details = Phase.details_of_date (CalendarLib.Calendar.Precise.now ())
let () = Printf.printf "Current Moon Phase: %s\n"
  (Phase.string_of_phase details.phase)
```

```ocalm
(* Calculate for specific date *)
let details = Phase.details_of_date_int 2024 2 14 12 0 0
let () =
  Printf.printf "Phase: %s\n" (Phase.string_of_phase details.phase);
  Printf.printf "Age: %.2f days\n" details.age;
  Printf.printf "Illumination: %.2f%%\n" details.illumination
```

```ocaml
open CalendarLib.Calendar.Precise

(* Generate phase calendar for a month *)
let start_date = make 2024 2 1 0 0 0
let end_date = make 2024 2 29 23 59 59
let calendar = Phase.phase_calendar start_date end_date

(* Print the calendar *)
let () = Phase.print_calendar calendar
```

## API Documentation

### Types
```ocaml
type phase =
  | New
  | FirstQuarter
  | Full
  | LastQuarter
  | WaxingCrescent
  | WaxingGibbous
  | WaningGibbous
  | WaningCrescent

type phase_details = {
  phase: phase;
  age: float;         (* Moon's age in days *)
  illumination: float (* Percentage of illumination *)
}
```

### Key Functions

* `details_of_julian`: Calculate phase details from Julian date
* `details_of_date`: Calculate phase details from CalendarLib date
* `details_of_date_int`: Calculate phase details from individual date components
* `phase_calendar`: Generate phase calendar for a date range

References
This implementation is based on:

"Astronomical Algorithms" by Jean Meeus (Chapter 47)
Standard astronomical calculations for lunar phases
Peer-reviewed astronomical computation methods
