#import "@preview/valkyrie:0.2.2" as z

#let parse = z.parse

#let author = z.dictionary((
  name: z.string(),
  group: z.string(),
  student-number: z.string(),
))

#let general = (
  title: z.content(),
  subtitle: z.content(optional: true, default: ""),
  authors: z.array(min: 1, author),
  date: z.date(),
)

#let build-ont(lang) = {
  let fi-optional = lang != "fi"

  let abtract = (
    degree-title: z.content(),
    thesis-title: z.content(),
    commissioned-by: z.content(),
    abstract: z.content(pre-transform: z.coerce.content),
    keywords: z.array(min: 1, z.string()),
  )

  z.dictionary(name: "thesis", (
    ..general,
    degree: z.string(),
    degree-programme: z.string(),
    fi: z.dictionary(optional: fi-optional, abtract),
    en: z.dictionary(abtract),
    supervisors: z.array(min: 1, z.content()),
    level: z.choice(default: "bachelor", name: "thesis level", ("bachelor", "master")),
  ))
}

#let long-task = z.dictionary(name: "long-task", (
  ..general,
  course: z.content(),
  task: z.content(),
))

#let theme = z.dictionary(name: "theme", (
  logo-yellow: z.boolean(default: false),
  custom-logo-color: z.color(optional: true),
  dark: z.boolean(default: false),
  wide: z.boolean(default: false),
  cover-font: z.any(optional: true, default: none),
))
