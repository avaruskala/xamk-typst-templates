
#let scientific-poster(
  title: "Otsikkoteksti",
  ingress: "Ingressiteksti",
  flipped: false,
  image-source: none,
  body,
) = {
  set text(font: "Arial", size: 20pt, lang: "fi")
  set text(size: 14pt) if flipped
  let content-x-inset = 3.95cm

  set page(
    paper: "a2",
    margin: (x: content-x-inset, top: 5cm, bottom: 14.2%),
    columns: if flipped { 4 } else { 2 },
    flipped: flipped,
    header-ascent: 30% + 0pt,
    header: {
      box(height: 100%, width: 100%)
    },
    footer-descent: 5% + 10pt,
    footer: [
      #pad(x: -content-x-inset - 3mm, box(inset: (x: content-x-inset))[
        #line(length: 100%, stroke: (paint: gray, thickness: 3pt, dash: ("dot", 4pt)))

      ])
    ],
  )
  set columns(gutter: 5.5% + 0pt)

  place(float: true, scope: "parent", top, {
    pad(x: -content-x-inset, y: -5cm, box(width: 100%, {
      if not flipped and image-source != none {
        box(width: 100%, height: 176.25mm, {
          image(width: 100%, fit: "cover", image-source)
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
    let ingress-size = 36pt

    if flipped {
      title-size = 46.5pt
      ingress-size = 25pt
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

    text(size: ingress-size, weight: "bold", ingress)
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
