# street-astronomy-ocaml

## Overview

This library is designed to provide calculations for amateur astronomy.
This is WIP and no actual version has been released yet.
## Current Features
- Calculate Julian dates from Gregorian dates etc.
- Calculate different phases of the Moon (e.g., New, Full, First Quarter).
- Determine the age of the Moon in days since the last New Moon.
- Calculate the illumination percentage of the Moon.
- Convert between degrees and radians for angular measurements.

## Installation

Instructions for installation will be provided soon.

## Usage

Here is a quick example of how to use the library:

```ocaml
(* Example code demonstrating usage *)
open Street_astronomy.Moon

let () =
  let details = details_of_julian 2459955.5 in
  Printf.printf "Phase: %s\n" (string_of_phase details.phase);
  Printf.printf "Age: %.2f days\n" details.age;
  Printf.printf "Illumination: %.2f%%\n" details.illumination;
