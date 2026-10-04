#import "attachment.typ": attachment-list
#import "locale.typ": l10n
#import "style.typ" as style

#let toc() = {
  pagebreak(weak: true)
  set heading(numbering: "1.1    ")

  show outline.entry: it => {
    let prefix = it.prefix()
    let body_fields = it.inner().fields().children
    body_fields.at(2) = box(width: 1fr, repeat(gap: 0.05em)[.])

    if it.level == 1 {
      body_fields.at(0) = upper(body_fields.at(0))
    }

    block(
      spacing: 1.57em,
      link(
        it.element.location(),
        it.indented(prefix, body_fields.join()),
      ),
    )
  }

  v(16.5pt)
  context {
    outline(title: text(size: 12pt, upper(l10n("outline-title"))))
  }
  attachment-list()
}

#let body(theme, lang) = {
  style.body-clean(theme: theme, lang, {
    body

    context {
      let loc = here()
      state_page_count.update(st => {
        st.pages = loc.page()
        st
      })
    }

    pagebreak(weak: true)
    attachments-display()

    context {
      let loc = here()
      state_page_count.update(st => {
        st.appendices = loc.page() - st.pages
        st
      })
    }
  })
}
