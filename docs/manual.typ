#import "@preview/elembic:1.1.1" as e
#import "@preview/tidy:0.4.3"
#import "/src/lib.typ" as unofficial-xamk
#import "/src/schema.typ" as schema
#import "/src/template/long-task.typ": long-task

#let lib = tidy.parse-module(
  (
    read("/src/attachment.typ"),
    read("/src/template/long-task.typ"),
    read("/src/template/scientific-poster.typ"),
    read("/src/template/thesis.typ"),
  ).join("\n"),
  require-all-parameters: false,
  name: "unofficial-xamk",
  old-syntax: true,
  scope: (unofficial-xamk: unofficial-xamk),
)

#tidy.show-module(
  lib,
)

