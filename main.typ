// math template
#import "@preview/numbly:0.1.0": numbly

#import "@preview/dashy-todo:0.1.2": todo

#import "@preview/frame-it:1.2.0": *

#import "@preview/lilaq:0.5.0" as lq

#let (example, feature, variant, syntax) = frames(
  feature: ("Feature",),
  // For each frame kind, you have to provide its supplement title to be displayed
  variant: ("Variant",),
  // You can provide a color or leave it out and it will be generated
  example: ("Example", gray),
  // You can add as many as you want
  syntax: ("Syntax",),
)
// This is necessary. Don't forget this!
#show: frame-style(styles.boxy)


#let appendix(body) = {
  set heading(numbering: "A", supplement: [Appendix])
  counter(heading).update(0)
  body
}
#let regular(body) = {
  set heading(supplement: [Regular])
  body
}

// // darkmode
// #set page(
//   fill: black.lighten(10%)
// )
// #set text(
//   fill: black.lighten(75%)
// )

#let title = "HW2.1"

#show link: underline

#set page(header: context {
  // Handle the case when page.numbering is not set by
  // falling back to the default "1" numbering pattern.
  let page-numbering = page.numbering
  if page-numbering == none { page-numbering = "1" }

  let both = (
    type(page-numbering) == function
      or {
        (
          page-numbering
            .clusters()
            .filter(c => (
              c
                in (
                  // Counting symbols: https://typst.app/docs/reference/model/numbering
                  "1",
                  "a",
                  "A",
                  "i",
                  "I",
                  "α",
                  "Α",
                  "*",
                  "א",
                  "一",
                  "壹",
                  "あ",
                  "い",
                  "ア",
                  "イ",
                  "ㄱ",
                  "가",
                  "\u{0661}",
                  "\u{06F1}",
                  "\u{0967}",
                  "\u{09E7}",
                  "\u{0995}",
                  "①",
                  "⓵",
                )
            ))
            .len()
            >= 2
        )
      }
  )

  let x = numbering(
    page-numbering,
    ..counter(page).get(),
    ..if both { counter(page).at(<numbering-main-end>) },
  )
  if x != "1" {
    title
    h(1fr)
    x
  }
})


#set enum(
  full: true,
  numbering: numbly("{1:1.}", "{2:(a)}"),
)

#let lim = math.limits(math.lim)
#let int = $integral$; 

// #set heading(numbering: "1.")

#align(center + horizon)[

  _#text(30pt)[
    #title
  ] \ \
  *Climate Modeling*
  _

  // #show heading: it => pad(left: 1em * (it.level - 1), it)

  SCIE 001 Math

  Noah Virjee\
  45515863

  #let today = datetime.today()

  #today.display("[month repr:long]")
  #today.day(), #today.year()// or another custom format

]

// #align(bottom)[

// #outline(target: heading.where(supplement: [Regular]))

// #outline(target: heading.where(supplement: [Appendix]), title: [Appendix])

// ]

#pagebreak()

// #set page(height: auto) // for intinite page
// #todo("turn on infinite pages and fix page braking")

#show: regular

// = Instructions

// #line(length: 100%)

= This
+ #example[
  Body, i.e. large content block for the frame.]
  + That

  $
    int_a^b
    
  $

  When approaching a modelling problem, mathematicians often start from fundamental principles (sometimes called first principles). We can think of these principles as the


  where $P_"in"$ and $P_"out"$ denote the power corresponding to, respectively, energy flowing in from the Sun and energy flowing out as the Earth's thermal radiation.

+ #example[
    #underline[*Your task:*] Derive the EBM given above and verify that the units on both sides of the 
  ]

  #align(center)[
    #table(
      columns: (auto, auto),
      inset: 10pt,
      align: center,
      stroke: (x, y) => if x == 0 and y >= 1 {
        (right: 0.7pt + black)
      },
      table.header([*Left Side*], [*Right Side*]),

      $
        & = J K^(-1) K / s \
        & = J / s \
        & = W
      $,

      $
        & = W - W \
        & = W \
      $,
    )

    $
      W = W
    $
    *  Left Side = Right Side
    *
  ]

  Therefore, the units are consistent.

    $
    lim_(T -> 247^- )alpha(T) = alpha(247) wide lim_(T -> 247^+ )alpha(T) = alpha(247) wide lim_(T -> 282^- )alpha(T) = alpha(282) wide lim_(T -> 282^+ )alpha(T) = alpha(282)
  $

  #colbreak()


+ #example[#underline[*Your task:*] Whi]



#show: appendix

= Guide to Finding Intersection Points of $P_"in"$ and $P_"out"$ in Python<app1>
Create a new Jupyter notebook using anaconda. Copy and paste the following lines of code into a new cell.
