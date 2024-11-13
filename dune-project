(lang dune 3.16)

(name street-astronomy)

(generate_opam_files true)

(source
 (github semolex/streetastronomy-moonphase))

(authors "Oleksii Semeshchuk")

(maintainers "semolex")

(license MIT)

(documentation https://github.com/semolex/streetastronomy-moonphase)

(package
 (name street-astronomy)
 (synopsis "Small library for Moon phase calculations")
 (description "TBD")
 (depends ocaml dune calendar)
 (tags
  (astro astronomy celestial-sphere moon sun star)))

; See the complete stanza docs at https://dune.readthedocs.io/en/stable/reference/dune-project/index.html
