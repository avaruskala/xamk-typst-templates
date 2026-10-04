#import "@local/unofficial-xamk:0.0.0" as xamk

#show: xamk.thesis.with(
  lang: "fi",
  metadata: (
    authors: (
      (name: "Etunimi Sukunimi", group: "ryhmä", student-number: "opiskelijanumero"),
    ),
    title: "Opinnäytetyön otsikko yhdelle tai useammalle riville",
    subtitle: "Tarvittaessa alaotsikko",
    degree: "Tutkinto",
    degree-programme: "Koulutus",
    date: datetime.today(),
    supervisors: ([Tero Tietäväinen],),
    fi: (
      degree-title: [Tutkintonimike],
      thesis-title: [Opinnäytetyön nimi],
      commissioned-by: [Yritys],
      abstract: [
      ],
      keywords: ("opinnäytetyö",),
    ),
    en: (
      degree-title: [Tutkintonimike],
      thesis-title: [Title of the thesis],
      commissioned-by: [Yritys],
      abstract: [
      ],
      keywords: ("thesis",),
    ),
    level: "bachelor",
  ),
  theme: (dark: false, logo-yellow: false),
)

// Kirjoittajan ohjeet: https://ksamk.sharepoint.com/sites/Opiskelu/SitePages/Kirjoittajan-ohjeet.aspx
// Koulutusten tunnukset: https://ksamk.sharepoint.com/sites/Opetus/SitePages/Koulutusten-tunnukset.aspx
//
// Writing instructions: https://ksamk.sharepoint.com/sites/Opiskelu/SitePages/en/Kirjoittajan-ohjeet.aspx
// Degree programme codes: https://ksamk.sharepoint.com/sites/Opetus/SitePages/en/Koulutusten-tunnukset.aspx
