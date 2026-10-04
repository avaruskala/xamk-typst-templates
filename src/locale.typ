#import "@preview/linguify:0.5.0": linguify, load-ftl-data

#let l10n-data = {
  let data = toml("/assets/l10n/lang.toml")
  let path = data.ftl.at("path", default: "./l10n")
  (
    data.lang = data
      .ftl
      .languages
      .map(lang => {
        (lang, read(path + "/" + lang + ".ftl"))
      })
      .to-dict()
  )
  data
}

#let l10n(key, lang: auto, args: auto, default: auto) = {
  linguify(key, from: l10n-data, lang: auto, args: args, default: default)
}
