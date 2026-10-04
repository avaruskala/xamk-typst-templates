#import "/src/style.typ" as style
#import "/src/document.typ": xamk-document
#import "/src/schema.typ" as schema
#import "/src/locale.typ": l10n

#let abstract(ctx, theme, metadata, metadata-lang) = {
  style.place-logo(width: 2.33cm, dy: -0.47cm, alignment: left + top, theme.dark, theme.logo-yellow)
  v(1.52cm)

  align(left, table(
    inset: 0%,
    column-gutter: 3pt,
    row-gutter: 5.3pt,
    stroke: none,
    columns: (4.5cm, auto),
    l10n("degree-title"), metadata-lang.degree-title,
    l10n("abstract-authors", args: (author-count: metadata.authors.len())), metadata.authors.map(a => a.name).join[, ],
    l10n("thesis-title"), metadata.title,
    l10n("commissioned-by"), metadata-lang.commissioned-by,
    l10n("time"), metadata.date.display("[year]"),
    l10n("pages"),
    context l10n("pages-text", args: (
      page-count-content: ctx.page-count-state.final().pages,
      page-count-appendices: ctx.page-count-state.final().appendices,
    )),

    l10n("abstract-supervisor", args: (supervisor-count: metadata.supervisors.len())), metadata.supervisors.join[, ],
  ))

  v(20.6pt)

  strong(upper(l10n("abstract")))
  linebreak()
  v(3pt)

  pad(left: 2.3cm, style.abstract([
    #metadata-lang.abstract

    *#l10n("keywords")*: #metadata-lang.keywords.join[, ]
  ]))
}

#let thesis(
  theme: schema.theme,
  metadata: schema.build-ont("fi"),
  lang: "fi",
  body,
) = {
  let metadata = schema.parse(
    scope: ("metadata",),
    metadata,
    schema.build-ont(lang),
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
      keywords: if metadata.fi != none {
        metadata.fi.keywords + metadata.en.keywords
      } else {
        metadata.en.keywords
      },
    ),
    ctx => {
      set page(background: style.cover-layout(theme.dark, theme.logo-yellow))

      let cover_offset = 3.85pt
      align(center, {
        place(top + center, dy: 2.1em - cover_offset, {
          box(height: 15.03cm, width: 15.5cm, {
            set text(
              top-edge: "ascender",
              bottom-edge: "descender",
            )
            set par(spacing: 0em, leading: 0.5em)
            set par(spacing: 0em, leading: 0.2em)
            v(30pt + cover_offset - 0.6pt)
            text(size: 16pt, {
              for (name, group, student-number) in metadata.authors {
                name
                linebreak()
              }
            })
            v(30pt + cover_offset)
            text(size: 24pt, upper(metadata.title))
            v(3pt + cover_offset)
            text(size: 20pt, metadata.subtitle)
            v(30pt + cover_offset)
            text(size: 16pt, l10n("thesis-level-" + metadata.level))
            v(18pt + cover_offset)
            text(size: 16pt, metadata.degree)
            v(18pt + cover_offset)
            text(size: 16pt, metadata.degree-programme)
            v(weak: true, 18pt + cover_offset)
            v(weak: true, 36pt + cover_offset)
            text(size: 16pt, metadata.date.display("[year]"))
            v(18pt + cover_offset)
          })
        })

        style.place-logo(width: 8.25cm, dy: 16.41cm, alignment: top + center, theme.dark, theme.logo-yellow)
      })
    },
    preface: ctx => {
      if lang == "fi" {
        set text(lang: "fi")
        pagebreak()
        abstract(ctx, theme, metadata, metadata.fi)
      }
      {
        set text(lang: "en")
        pagebreak()
        abstract(ctx, theme, metadata, metadata.en)
      }
    },
    body,
  )
}
