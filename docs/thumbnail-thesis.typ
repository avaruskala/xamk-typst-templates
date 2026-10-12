#import "/src/lib.typ" as xamk

// style thumbnail for light and dark theme
#let theme = sys.inputs.at("theme", default: "light")
#let dark = theme == "dark"

#xamk.thesis(
  lang: "fi",
  metadata: (
    authors: (
      (name: "First Last", group: "GRUOPXX", student-number: "12345"),
    ),
    title: "Title",
    subtitle: "Subtitle",
    degree: "Degree",
    degree-programme: "Degree programme",
    date: datetime.today(),
    supervisors: (["Supervisor"],),
    fi: (
      degree-title: "Tutkintonimike",
      thesis-title: "Opinnäytetyön nimi",
      commissioned-by: "Toimeksiantaja",
      abstract: [
      ],
      keywords: ("opinnäytetyö",),
    ),
    en: (
      degree-title: "Degree title",
      thesis-title: "Title of the thesis",
      commissioned-by: "Commissioned by",
      abstract: [
      ],
      keywords: ("thesis",),
    ),
    level: "bachelor",
  ),
  theme: (dark: dark, logo-yellow: false),
)[]

