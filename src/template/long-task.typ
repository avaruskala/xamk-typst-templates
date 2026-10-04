#import "/src/document.typ": xamk-document
#import "/src/style.typ" as style
#import "/src/schema.typ" as schema

#let long-task(
  lang: "fi",
  cover: none,
  theme: schema.theme,
  metadata: schema.long-task,
  body,
) = {
  let metadata = schema.parse(
    scope: ("metadata",),
    metadata,
    schema.long-task,
  )
  let theme = schema.parse(
    scope: ("theme",),
    theme,
    schema.theme,
  )

  xamk-document(
    theme: theme,
    (
      lang: lang,
      title: metadata.title,
      subtitle: metadata.subtitle,
      date: metadata.date,
      authors: metadata.authors,
      keywords: (),
    ),
    ctx => {
      set page(background: style.cover-layout(custom-color: ctx.custom-logo-color, theme.dark, theme.logo-yellow))
      let cover_offset = 3.85pt
      align(center, {
        place(top + center, dy: 1.1em - cover_offset, {
          box(height: 15.03cm, width: 15.5cm, {
            set text(
              top-edge: "ascender",
              bottom-edge: "descender",
            )
            set text(font: theme.cover-font) if theme.at(default: none, "cover-font") != none
            set par(spacing: 0em, leading: 0.5em)
            set par(spacing: 0em, leading: 0.2em)
            v(30pt + cover_offset - 0.6pt)
            text(size: 16pt, {
              for (name, group, student-number) in metadata.authors {
                [#name (#student-number #group)]
                linebreak()
              }
            })
            v(30pt + cover_offset)
            text(size: 24pt, upper(metadata.title))
            v(3pt + cover_offset)
            text(size: 20pt, metadata.subtitle)
            v(30pt + cover_offset)
            text(size: 16pt, metadata.task)
            v(18pt + cover_offset)
            text(size: 16pt, metadata.course)
            v(weak: true, 18pt + cover_offset)
            v(weak: true, 36pt + cover_offset)
            text(size: 16pt, metadata.date.display("[year]"))
            v(18pt + cover_offset)
          })
        })

        style.place-logo(
          width: 8.25cm,
          dy: 18.05cm,
          alignment: top + center,
          custom-color: ctx.custom-logo-color,
          theme.dark,
          theme.logo-yellow,
        )
      })
    },
    body,
  )
}
