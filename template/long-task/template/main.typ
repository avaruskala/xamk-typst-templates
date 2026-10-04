#import "@local/unofficial-xamk:0.0.0" as xamk

#show: xamk.long-task.with(
  lang: "fi",
  metadata: (
    authors: (
      (name: "Etunimi Sukunimi", group: "ryhmä", student-number: "opiskelijanumero"),
    ),
    title: [Tehtävän otsikko yhdelle tai useammalle riville #linebreak() ..],
    subtitle: [Tarvittaessa alaotsikko],
    task: [Tehtävä],
    course: [Opintojakson nimi],
    date: datetime.today(),
  ),
  theme: (dark: false, logo-yellow: false),
)

#v(2em)

// Kirjoittajan ohjeet: https://ksamk.sharepoint.com/sites/Opiskelu/SitePages/Kirjoittajan-ohjeet.aspx
//
// Writing instructions: https://ksamk.sharepoint.com/sites/Opiskelu/SitePages/en/Kirjoittajan-ohjeet.aspx
