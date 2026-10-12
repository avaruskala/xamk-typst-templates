#import "/src/lib.typ" as xamk

// style thumbnail for light and dark theme
#let theme = sys.inputs.at("theme", default: "light")
#let dark = theme == "dark"

#xamk.long-task(
  lang: "en",
  metadata: (
    authors: (
      (name: "First Last", group: "GRUOPXX", student-number: "12345"),
    ),
    title: "Title",
    subtitle: "Subtitle",
    task: "Task",
    course: "Course name",
    date: datetime.today(),
  ),
  theme: (dark: dark, logo-yellow: false),
)[]

