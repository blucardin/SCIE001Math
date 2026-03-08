// math template
#import "@preview/numbly:0.1.0": numbly

#import "@preview/dashy-todo:0.1.2": todo

#import "@preview/frame-it:1.2.0": *

#import "@preview/lilaq:0.5.0" as lq

#import "@preview/cetz:0.4.2": canvas, draw
#import "@preview/cetz-plot:0.1.2": plot

#import "@preview/tablex:0.0.9": *

#let (p, feature, variant, syntax) = frames(
  feature: ("Feature",),
  // For each frame kind, you have to provide its supplement title to be displayed
  variant: ("Variant",),
  // You can provide a color or leave it out and it will be generated
  p: ("Problem", gray),
  // You can add as many as you want
  syntax: ("Syntax",),
)
// This is necessary. Don't forget this!
#show: frame-style(styles.thmbox)


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

#let title = "HW2.3"

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
  numbering: numbly("{1:1.}", "{2:(a)}", "{3:i.}"),
)

#let lim = math.limits(math.lim)
#let int = $integral$
#let inf = $infinity$
#let th = $theta$
#let dx = $dif x$
#let du = $dif u$
#let dp = $dif p$
#let dt = $dif t$
#let dv = $dif v$
#let dth = $dif th$
#let lna(x) = $ln abs(#x)$
#let pm = $plus.minus$
#let ans(x) = $ #rect[$#x$] $

#let um = "m"
#let ukg = "kg"
#let uN = "N"

// #set heading(numbering: "1.")

#align(center + horizon)[

  _#text(30pt)[
    #title
  ] \ \
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

// #set page(height: auto) // for infinite page
// #todo("turn on infinite pages and fix page braking")

#show: regular

// = Instructions

// #line(length: 100%)
// #show math.integral: math.display

+ #p[Recall that the probability density function for the electron-proton distance r in the hydrogen atom ground state (i.e., the 1s orbital) is given by
$
  f(r) &= 4 pi r^2 psi^2_100 (r) \
  &= A r^2 e^( (- 2 r) / a_0)
$
where $a_0$ is the Bohr radius.

]
  + #p[Find the cumulative distribution function $F(r)$.]
  + #p[Determine the value of $A$ (i.e., “normalize” the distribution).]
  + #p[Determine the probability that the electron will be found within 2a0 of the proton. Does this seem reasonable?]
  + #p[Determine the "most probable" and the "expected" radius for the hydrogen atom in the ground state.]

+ #p[_Newton's universal law of gravitation_ states that the force of attraction between two point masses $m$ and $M$ has magnitude

$
  F = (G m M) / r^2
$

where $r$ is the distance between the masses and $G = 6.67 times 10^(-11) uN dot um^2/(ukg^2) $ is a constant.
]
  + #p[
    If M represents the mass of the centre of the earth and we regard it as a point mass concentrated at its centre, show that Newton's universal law of gravitation at the earth's surface reduces to F = mg, where g = 9.82 m/s2. Assume for the calculation of M that the earth is a sphere with radius 6370 km and mean density $5.52 times 10^3 ukg/um^3$.

  ]
