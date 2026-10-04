#import "style.typ": to-baseline
#import "locale.typ": l10n
#import "default-values.typ" as default-values

#let attachments = state("xamk-attachments", ())
#let attachment-label = <xamk-attachment>

#let attachment-list() = context {
  if query(attachment-label).len() > 0 {
    upper(l10n("attachments"))
    v(5pt)
    set par(spacing: 1.05em)

    for (i, meta) in query(attachment-label).enumerate() {
      let i = i + 1
      h(5.5em)
      link(
        meta.location(),
        [#l10n("attachment") #i. #meta.value.name],
      )
      linebreak()
      v(0pt)
    }
  }
}

#let attachments-display() = context {
  pagebreak(weak: true)

  for (i, (flipped, name, body)) in attachments.get().enumerate() {
    let attachment-number = i + 1
    let attachment_page_counter = counter("xamk-attachment-" + str(i))
    attachment_page_counter.update(1)

    set page(
      flipped: flipped,
      //margin: (top: 3.10cm, left: 4.3cm, bottom: 1.25cm, right: 2cm),
      margin: if flipped {
        (right: 2.74cm, top: 4.3cm, left: 1.25cm, bottom: 2cm)
      } else {
        (top: 2.74cm, left: 4.3cm, bottom: 1.25cm, right: 2cm)
      },
      header-ascent: 0% + 0pt,
      header: context {
        attachment_page_counter.step()

        let page-counter = {
          // Attachment number
          [#l10n("attachment") #attachment-number]
          // Show page numbering when more than one page
          if attachment_page_counter.final().first() > 2 {
            [/#attachment_page_counter.display()]
          }
        }
        if flipped {
          rotate(90deg, place(bottom, dx: 13.015cm, dy: -25.710cm, page-counter))
        } else {
          place(bottom, dx: 13.01cm, dy: 0cm, page-counter)
        }
      },
    )
    set par(leading: 0.65em, justify: false, spacing: 1.2em, linebreaks: "optimized")
    set par(leading: to-baseline(1em))
    set list(indent: 2.37cm)

    default-values.sizes-state.update(st => {
      st.par-after = 15pt
      st
    })

    show heading: it => {
      set text(size: 12pt)
      set par(leading: 3pt)
      if it.level == 1 {
        upper(it)
      } else {
        it
      }
      v(weak: true, 0pt)
    }
    show list: it => {
      v(weak: true, 0pt)
      it
    }

    [
      #heading(outlined: false, numbering: none, name)
      #metadata((name: name)) #attachment-label

      #body
    ]
  }
}

#let attachment(
  flipped: false,
  name: str,
  body,
) = context {
  attachments.update(state => {
    state.push((flipped: flipped, name: name, body: body))
    state
  })
}
