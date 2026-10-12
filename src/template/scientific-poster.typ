#import "/src/style.typ"

/// Scientific poster template function.
///
/// *Example*
/// ```typ
/// #show: xamk.scientific-poster.with(
///   title: "Otsikkoteksti",
///   lead-paragraph: "Ingressiteksti",
///   header: none,
///   flipped: false,
/// )
/// Body
/// ```
///
/// - body (content): Contents of the poster.
/// - title (string): Title.
/// - lead-paragraph (string): Lead paragraph.
/// - flipped (bool): Horizontal orientation.
/// - header (content): Header content.
/// ->
#let scientific-poster(
  body,
  title: "Otsikkoteksti",
  lead-paragraph: "Ingressiteksti",
  flipped: false,
  header: none,
) = {
  set text(font: "Arial", size: 20pt, lang: "fi")
  set text(size: 14pt) if flipped
  let content-x-inset = 3.95cm

  set page(
    paper: "a2",
    margin: (x: content-x-inset - 1mm, top: 5cm, bottom: 14.2%),
    columns: if flipped { 4 } else { 2 },
    flipped: flipped,
    header-ascent: 30% + 0pt,
    header: {
      box(height: 100%, width: 100%)
    },
    footer-descent: 5% + 10pt,
    footer: [
      #pad(x: -content-x-inset - 3mm, box(inset: (x: content-x-inset), {
        line(length: 100%, stroke: (paint: gray, thickness: 2.5pt, dash: ("dot", 3.5pt)))
        style.place-logo(false, false, alignment: top + right, dx: -0.25cm, dy: 1.78cm, width: 5.65cm)
      }))
    ],
  )
  set columns(gutter: 5.5% + 0pt)

  place(float: true, scope: "parent", top, {
    pad(x: -content-x-inset, y: -5cm, box(width: 100%, {
      if not flipped and header != none {
        box(width: 100%, height: 176.25mm, {
          header
        })
      }

      let topshape-height = 1.26cm
      let topshape-width = 11mm
      let topshape-top = 2.4cm
      let fill-color = rgb("#FDB82B")

      if flipped {
        topshape-top = 2.5cm
        topshape-width = 12.5mm
      }

      place(top, polygon(
        fill: fill-color,
        (0%, 0%),
        (0cm, topshape-height),
        (50% - topshape-width, topshape-height),
        (50%, topshape-top),
        (50% + topshape-width, topshape-height),
        (100%, topshape-height),
        (100%, 0cm),
      ))
      place(bottom, dy: 2pt, rect(fill: fill-color, width: 100%, height: 2mm))
    }))
    v(4cm)
  })

  place(float: true, scope: "parent", top, box({
    let title-size = 66pt
    let lead-paragraph-size = 36pt

    if flipped {
      title-size = 46.5pt
      lead-paragraph-size = 25pt
      v(2.4cm * 2 + 0.25cm)
    } else {
      v(2.4cm)
    }

    text(size: title-size, weight: "bold", title)
    linebreak()

    if flipped {
      v(8mm)
    } else {
      v(10.5mm)
    }

    text(size: lead-paragraph-size, weight: "bold", lead-paragraph)
    linebreak()
    if flipped {
      v(11mm)
    } else {
      v(16mm)
    }
  }))
  set par(spacing: 2.8em, leading: 1.13em)
  set text(font: "Open Sans")
  body
}
