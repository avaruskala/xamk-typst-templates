root := justfile_directory()

export TYPST_ROOT := root

[private]
default:
  @just --list --unsorted

# generate manual
doc:
  typst compile docs/manual.typ docs/manual.pdf
  typst compile --pages 1 docs/thumbnail-long-task.typ thumbnail/thumbnail-long-task.png
  typst compile --pages 1 --input theme=dark docs/thumbnail-long-task.typ thumbnail/thumbnail-long-task-dark.png

  typst compile --pages 1 docs/thumbnail-thesis.typ thumbnail/thumbnail-thesis.png
  typst compile --pages 1 --input theme=dark docs/thumbnail-thesis.typ thumbnail/thumbnail-thesis-dark.png

  typst compile --pages 1 docs/thumbnail-scientific-poster.typ thumbnail/thumbnail-scientific-poster.png

# run test suite
test *args:
  tt run --no-fail-fast {{ args }}

# update test cases
update *args:
  tt update {{ args }}

# package the library into the specified destination folder
package target:
  ./scripts/package "{{target}}"

# install the library with the "@local" prefix
install: (package "@local")

# install the library with the "@preview" prefix (for pre-release testing)
install-preview: (package "@preview")

[private]
remove target:
  ./scripts/uninstall "{{target}}"

# uninstalls the library from the "@local" prefix
uninstall: (remove "@local")

# uninstalls the library from the "@preview" prefix (for pre-release testing)
uninstall-preview: (remove "@preview")

# run ci suite
ci: test doc
