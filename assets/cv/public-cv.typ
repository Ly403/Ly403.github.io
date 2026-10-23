// Optional generated CV using the website's public data:
// typst compile --root . assets/cv/public-cv.typ /tmp/YiLiu-CV-generated.pdf
// The website download at assets/pdf/CV.pdf uses the owner's supplied PDF.
#let cv = json("../json/resume.json")
#let blue = rgb("#234c72")
#let muted = rgb("#526273")
#set document(title: "Yi Liu — Curriculum Vitae", author: "Yi Liu")
#set page(
  paper: "a4",
  margin: (x: 16mm, top: 14mm, bottom: 15mm),
  footer: context align(center, text(size: 8pt, fill: muted, counter(page).display())),
)
#set text(font: "Libertinus Serif", size: 10pt, fill: rgb("#17283b"))
#set par(leading: 0.42em, spacing: 5pt)
#set list(indent: 11pt, body-indent: 4pt, spacing: 2pt)
#show link: set text(fill: blue)
#show heading.where(level: 1): it => block(above: 9pt, below: 5pt)[
  #text(size: 12pt, weight: "bold", fill: blue, it.body)
  #v(-4pt)
  #line(length: 100%, stroke: 0.45pt + rgb("#bcc9d4"))
]
#let date(value) = value.split("-").slice(0, 2).join(".")
#let period(entry) = date(entry.startDate) + " – " + (
  if entry.at("endDate", default: "") == "" { "Present" } else { date(entry.endDate) }
)
#let row(left, right) = grid(
  columns: (1fr, auto), column-gutter: 9pt,
  left, text(size: 9pt, fill: muted, right),
)

#align(center)[
  #text(size: 23pt, weight: "bold", cv.basics.name)
  #v(3pt)
  #text(size: 9pt)[
    #cv.basics.phone #h(5pt) | #h(5pt)
    #link("mailto:" + cv.basics.email)[#cv.basics.email] #h(5pt) | #h(5pt)
    #link(cv.basics.url)[ly403.github.io]
    \ Shanghai, China
  ]
]

= Biography
#cv.basics.summary

His main interests are few-step sampling, lightweight architectures, conditional control, and hardware-aware acceleration, with a long-term goal of reliable, real-time interactive generation.

= Education
#for entry in cv.education.slice(0, 2) [
  #block(above: 4pt, breakable: false)[
    #row(strong(entry.institution), period(entry))
    #emph(entry.studyType + " in " + entry.area)
    #list(..entry.courses.map(item => [#item]))
  ]
]

= Publications
#for publication in cv.publications [
  #block(above: 5pt, breakable: false)[
    #text(weight: "bold", fill: blue)[[#publication.publisher]]
    #link(publication.url)[#publication.name]
    \ #text(size: 9.3pt, publication.summary)
  ]
]

#pagebreak()
= Internship Experience
#for entry in cv.work [
  #block(above: 5pt, breakable: false)[
    #row(strong(entry.name), period(entry))
    #emph(entry.position + " · " + entry.location)
    \ #entry.summary
    #list(..entry.highlights.map(item => [#item]))
  ]
]

= Research Experience
#for entry in cv.projects [
  #block(above: 5pt, breakable: false)[
    #row(strong(entry.name), period(entry))
    #text(size: 9.2pt, emph(entry.summary))
    #list(..entry.highlights.map(item => [#item]))
  ]
]

= Selected Honors and Awards
#for award in cv.awards [
  #block(above: 3pt, breakable: false)[
    #row([#award.title], award.date)
  ]
]

= Skills and Languages
*Programming:* #cv.skills.first().keywords.join(" · ")

#for language in cv.languages [
  *#language.language:* #language.fluency
  #parbreak()
]
