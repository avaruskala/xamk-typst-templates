#import "default-values.typ" as default-values
#import "layout.typ": toc
#import "attachment.typ": attachments-display
#import "style.typ" as style
#import "schema.typ" as schema

#let page-count-state = state("xamk-page-counter", (pages: 0, appendices: 0))

#let xamk-document(
  preface: ctx => none,
  theme: schema.theme,
  metadata,
  cover,
  body,
) = {
  set page(fill: style.dark-page-fill) if theme.dark
  set text(fill: style.dark-text-fill) if theme.dark

  set text(
    font: ("Arial", "Liberation Sans"),
    lang: metadata.lang,
    size: 16pt,
    hyphenate: true,
  )
  set page(
    paper: "a4",
    margin: (top: 1.75cm, left: 2cm, bottom: 1.25cm, right: 2cm),
  )
  set document(
    title: if metadata.subtitle != none [#metadata.title: #metadata.subtitle] else [#metadata.title],
    date: metadata.date,
    keywords: metadata.keywords,
    author: metadata.authors.map(
      author => author.name,
    ),
  )

  cover((
    custom-logo-color: theme.custom-logo-color,
  ))
  set text(size: 12pt)
  preface((
    custom-logo-color: theme.custom-logo-color,
    page-count-state: page-count-state,
  ))
  toc()
  style.body-clean(theme: theme, metadata.lang, {
    body

    context {
      let loc = here()
      page-count-state.update(st => {
        st.pages = loc.page()
        st
      })
    }
    pagebreak(weak: true)
    attachments-display()

    context {
      let loc = here()
      page-count-state.update(st => {
        st.appendices = loc.page() - st.pages
        st
      })
    }
  })
}
