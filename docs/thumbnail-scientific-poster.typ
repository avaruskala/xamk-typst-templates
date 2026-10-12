#import "/src/lib.typ" as xamk

// style thumbnail for light and dark theme
#let theme = sys.inputs.at("theme", default: "light")
#let dark = theme == "dark"

#show: xamk.scientific-poster.with(header: [
  #rect(width: 100%, height: 100%, fill: blue)
])

#lorem(400)
