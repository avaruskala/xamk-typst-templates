#import "default-values.typ" as default-values
#import "locale.typ": l10n
#import "schema.typ" as schema


#let dark-text-fill = luma(87%)
#let dark-page-fill = luma(6%)
#let logo-color-yellow = rgb("#FBBA18")

#let to-baseline(len) = {
  len - 0.75em
}

#let invert-lightness(c) = {
  let (h, s, l, a) = c.hsl().components()
  let lightness = calc.pow(float(100% - l), 1 / 1.3)

  color.hsl(h, s, lightness * 100%, a)
}

#let invert-lightness-if(c, b) = {
  if b {
    invert-lightness(c)
  } else {
    c
  }
}

#let place-logo(custom-color: none, width: auto, dy: 0%, dx: 0%, alignment: auto, dark, yellow) = context {
  let logo-svg

  if text.lang == "fi" {
    logo-svg = read("/assets/logo/xamk_logo_musta_kehys_svg.svg")
  } else {
    logo-svg = read("/assets/logo/xamk_logo_musta_kehys_svg_englanti.svg")
  }

  let c

  if custom-color != none {
    c = custom-color
  } else if yellow and dark {
    c = logo-color-yellow
  } else if dark {
    c = luma(100%)
  } else {
    c = luma(0%)
  }

  logo-svg = logo-svg.replace("#000", c.to-hex())

  let image = image(bytes(logo-svg), fit: "contain", width: width)
  if dy == 0% and dx == 0% {
    image
  } else {
    place(
      dy: dy,
      dx: dx,
      alignment,
      image,
    )
  }
}


#let cover-layout(custom-color: none, dark, yellow) = {
  let fill-color

  if custom-color != none {
    fill-color = custom-color
  } else if yellow and dark {
    fill-color = logo-color-yellow
  } else if dark {
    fill-color = luma(87%)
  } else {
    fill-color = luma(0%)
  }

  if dark {
    fill-color = fill-color.hsl().saturate(-21.02%).darken(80.8%)
  } else {
    fill-color = fill-color.hsl().saturate(-21.02%).darken(-80.8%)
  }

  layout(size => {
    let stroke_width = 9.2pt

    let offset_y = 14.35pt
    let offset_x = 14.5pt
    let width = size.width - stroke_width - offset_x * 2
    let height = size.height - stroke_width - offset_y * 2

    let triangle_width = 21pt
    let triangle_height = 21.2pt
    let middle_x = width / 2
    let middle_y = height / 2

    polygon(
      stroke: stroke_width + fill-color,
      (0pt, 0pt),

      (middle_x - triangle_width, 0pt),
      (middle_x, triangle_height),
      (middle_x + triangle_width, 0pt),

      (width, 0pt),

      (width, middle_y - triangle_width),
      (width - triangle_height, middle_y),
      (width, middle_y + triangle_width),

      (width, height),

      (middle_x + triangle_width, height),
      (middle_x, height - triangle_height),
      (middle_x - triangle_width, height),

      (0pt, height),

      (0pt, middle_y + triangle_width),
      (0pt + triangle_height, middle_y),
      (0pt, middle_y - triangle_width),
    )
  })
}

#let abstract(body) = {
  set par(leading: to-baseline(1.2em), spacing: 1.36em)
  body
}

#let body-clean(theme: schema.parse((:), schema.theme), lang, body) = {
  default-values.sizes-state.update(_ => {
    default-values.initial-sizes
  })

  set text(
    lang: lang,
    size: 12pt,
    top-edge: 0.8em,
    bottom-edge: -0.2em,
  )

  set heading(numbering: "1.1   ")
  set page(margin: (top: 2.31cm, left: if theme.wide { 2cm } else { 4.3cm }, bottom: 1.25cm, right: 2cm))

  show figure.caption: set text(size: 10pt)
  set math.equation(numbering: "(1)")
  show heading: it => {
    set text(size: 12pt)
    set par(leading: 3pt)
    if it.level == 1 {
      v(weak: true, 32pt)
      upper(it)
    } else {
      v(weak: true, 26.5pt)
      it
    }
    v(weak: true, 1.66em)
  }

  set page(
    header: context align(center)[
      #set text(
        top-edge: "cap-height",
        bottom-edge: "baseline",
      )
      #place(top + center, dy: 1.343cm)[
        #counter(page).display()
      ]
    ],
  )

  set list(indent: 1.9cm, spacing: 2.8pt, body-indent: 1em, marker: (text(weight: 900)[•], [‣], [–]))
  show list: it => {
    set par(leading: 3pt, spacing: 0em)
    it
    v(weak: true, 1.6em)
  }

  set figure.caption(separator: [. ])
  show figure.where(kind: image): it => {
    show par: it => {
      v(0pt)
      it
      v(0pt)
    }
    let caption = it.caption
    align(left, [
      #box(stroke: black + 1pt, it.body)
      #v(-default-values.sizes-state.get().par-after + 4pt)
      #it.caption
    ])
    v(weak: true, 20pt)
  }

  set table(stroke: 1pt + white) if theme.dark
  show table.cell.where(y: 0): it => {
    strong(it)
  }
  show table: it => {
    it
    v(1em)
  }
  show figure.where(kind: table): it => {
    set block(breakable: true)
    set text(10pt)
    align(left, {
      it.caption
      v(2pt, weak: true)
      it.body
      v(weak: true, 20pt)
    })
  }
  show raw.where(block: true): it => {
    it
    v(default-values.sizes-state.get().par-after)
  }

  set bibliography(
    title: l10n("bibliography-title"),
  )
  show bibliography: it => {
    pagebreak(weak: true)
    set par(spacing: 1.5em, leading: .5em)
    it
  }

  set par(leading: 0.725em, linebreaks: "simple", spacing: to-baseline(1.5em) + 1.5em)
  show link: set text(fill: invert-lightness-if(blue, theme.dark))
  show link: underline

  show ref: it => {
    if it.element != none and it.element.func() == figure {
      [(#it)]
    } else {
      it
    }
  }

  body
}
