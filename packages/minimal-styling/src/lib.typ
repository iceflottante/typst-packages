#let _theme = (
  font_size: (
    title: 32pt / 1.5,
    h1: 32pt / 1.5,
    h2: 24pt / 1.5,
    h3: 20pt / 1.5,
    h4: 16pt / 1.5,
    h5: 14pt / 1.5,
    h6: 13.6pt / 1.5,
    body: 16pt / 1.5,
  ),
  font_family: (
    all: (
      "--apple-system",
      "BlinkMacSystemFont",
      "Segoe UI",
      "Noto Sans",
      "Helvetica",
      "Arial",
      "Sans Serif Collection",

      // fonts that nice to have
      "MiSans",

      // use system fonts for fallback
      "PingFang SC",
      "Microsoft YaHei",
      "Segoe UI Emoji",
      "Apple Color Emoji",
    ),
  ),
  color: (
    link: rgb(9, 105, 218),
    raw: rgb(246, 248, 250),
    line: rgb(223, 228, 233),
  ),
  spacing: (
    heading_above: 24pt / 1.5,
    heading_below: 16pt / 1.5,
    heading_line: 5pt,
  ),
)


#let _template_text(doc) = {
  show: set text(
    font: _theme.font_family.all,
    top-edge: "ascender",
    bottom-edge: "descender",
  )

  doc
}


#let _template_headings(doc) = {
  show: _template_text

  show heading: set block(
    width: 100%,
    above: _theme.spacing.heading_above,
    below: _theme.spacing.heading_below,
  )
  show heading: set text(weight: 600)

  show heading.where(level: 1): set text(size: _theme.font_size.h1)
  show heading.where(level: 2): set text(size: _theme.font_size.h2)
  show heading.where(level: 3): set text(size: _theme.font_size.h3)
  show heading.where(level: 4): set text(size: _theme.font_size.h4)
  show heading.where(level: 5): set text(size: _theme.font_size.h5)
  show heading.where(level: 6): set text(size: _theme.font_size.h6)

  let _heading_with_line(it) = {
    set block(below: 0pt)
    it
    set block(
      above: _theme.spacing.heading_line,
      below: _theme.spacing.heading_below,
    )
    line(
      length: 100%,
      stroke: 0.5pt + _theme.color.line,
    )
  }

  show heading.where(level: 1): _heading_with_line
  show heading.where(level: 2): _heading_with_line

  doc
}

#let _template_raw(doc) = {
  show: _template_text

  let _raw_common_options = (radius: 3pt, fill: _theme.color.raw)

  show raw.where(block: true): set block(.._raw_common_options, width: 100%, inset: 8pt)

  // https://typst.app/docs/reference/text/raw/#parameters-block
  show raw.where(block: false): box.with(
    .._raw_common_options,
    inset: (x: 2.7pt),
    outset: (y: 1.3pt),
    baseline: 2pt,
  )

  // https://github.com/typst/typst/discussions/3988
  show raw.where(block: false): it => {
    show " ": " " + sym.zws
    it
  }
  doc
}

#let _template_link(doc) = {
  show: _template_text

  show link: underline
  show link: set text(fill: _theme.color.link)
  show link: set underline(offset: 3.2pt / 1.5)

  doc
}

#let _template_footnote(doc) = {
  show footnote: it => {
    set text(fill: _theme.color.link)
    it
  }
  doc
}

// https://github.com/talal/ilm/blob/aaa225f53034dd229b53d98ed185a0fb813f94ad/lib.typ#L214
#let _template_table(doc) = {
  doc
}


#let template_minimal_styling(doc) = {
  show: _template_text
  show: _template_raw
  show: _template_link
  show: _template_headings
  show: _template_footnote
  show: _template_table

  doc
}

#let component_title(body) = {
  align(
    center,
    block(
      text(_theme.font_size.title, body),
    ),
  )
}
