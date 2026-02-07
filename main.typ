// math template
#import "@preview/numbly:0.1.0": numbly

#import "@preview/dashy-todo:0.1.2": todo

#import "@preview/frame-it:1.2.0": *

#import "@preview/lilaq:0.5.0" as lq

#import "@preview/cetz:0.4.2": canvas, draw
#import "@preview/cetz-plot:0.1.2": plot

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

#let title = "HW2.2"

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
#let int = $integral$;

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

// #set page(height: auto) // for intinite page
// #todo("turn on infinite pages and fix page braking")

#show: regular

// = Instructions

// #line(length: 100%)
// #show math.integral: math.display

+ 
  + #p[
    For this problem, consider the integral:
    $
      S = int_0^(2pi) sin^k(x) dif x
    $
    If $k$ is an odd positive integer, determine the value of S.
  ]
  + #p[Calculate
      $
        integral (1/x) sqrt(a^2 - x^2) dif
      $

      + by using a $u$-substitution.
      + by using a trig substitution.
      Then compare your results.
    ]
+ #p[
    In tutorial, we looked at metapopulations and the Levins model derived by Richard Levins in 1969 which describes metapopulations as a means for studying spatially structured populations. In particular, the model tracks the proportion of patches that are occupied by the population, but does not track the density of the population nor which specific patches are inhabited. These subpopulations are modelled through the Levins model
    $
      (dif p)/ (dif t) = c p (1 - p) - m p
    $
    where $p = p(t)$ is the fraction of patches occupied, $m > 0$ is the mortality of a subpopulation, and $c > 0$ is the colonization of a vacant subpopulation. Recall that vacant patches can be colonized at a rate proportional to the fraction of occupied patches as $1- =$.]

  + #p[Set $m = 1$ and $c = 3$.]
    + #p[model and determine the long term behaviour (i.e., equilibria). Be sure to include all steps in your solution.]
    + #p[Interpret your answer in the context of the biological setting of the model: i.e., what are the biological significances of the results you have obtained.]
  + #p[If we set $m = 0$ in the Levins model, then we are left with the Logistic Growth model on the proportion of patches. In this case, from our understanding of the Logistic Growth model, we know that all patches will be filled in the long run $(p -> 1)$. This observation, along with others related to metapopulations, leads to the need to have $m > 0$. With some manipulation of the right-hand side of the Levins model, we can rewrite it as a Logistic Growth model on the proportion of patches, and use our knowledge of the Logistic Growth model in order to understand the Levins model.
    ]
  + #p[Manipulate the right-hand side of the Levins model to put it into the form of the Logistic growth model
      $
        (dif p)/ (dif t) = r p (1- p/k)
      $
      and identify the new parameters $r$ and $K$ in terms of $m$ and $c$.]


    + #p[Interpret the effects of the parameters $m$ and $c$ as they relate to the Logistic Growth model.
      ]

+ #p[The Gamma function Γ(x) is a continuous function defined by the improper integral

    $
      Gamma(x) = int_0^infinity t^(x-1)e^(-t) dif t
    $
  ]

  + #p[Compute $Gamma(1)$.]
    $
      Gamma(1) &= int_0^infinity t^(1-1)e^(-t) dif t \
      &= int_0^infinity (1)e^(-t) dif t \
      &= - int_0^infinity (-1)e^(-t) dif t \
      // Gamma(1) &= - e^(-t) + C wide "where C is a constant"
    $

    // Since we are integrating from $0$, we know that: 
    // $
    //   0 &= - int_0^0 (-1)e^(-t) dif t \
    //   therefore 0 &= - e^(-0) + C \
    //   -C &= -1 \
    //   C &= 1
    // $
    // So

  + #p[Use integration by parts to show that $Gamma(x + 1) = x Gamma(x)$ for $x > 0$. ]
  + #p[Using the fact that $int_0^infinity e^(-t^2) dif t = sqrt(pi)/ 2$, compute $Gamma (1/2)$. Hint: Make a substitution. ]
  + #p[Find $Gamma(3/2)$.]

#p[
  _Remark:_ Using the recurrence relation in (b), it can be proved that $Gamma(n + 1) = n!$ when $n$ is a positive integer. (Recall that the factorial is defined as $n! = n ·(n -1) ·... ·3 ·2 ·1$, but this formula is only valid when n is a natural number.)

  In view of this property,$Gamma(x + 1)$ is often written as $x!$ and regarded as an extension of the factorial function to real numbers. Some scientific calculators with the factorial function $n!$ built in actually calculate the gamma function rather than the simpler formula of products of integers. Check whether your calculator does this by asking it for $0.5!$. If you get an error message, it is not using the gamma function. If you get a numerical value, compare it with your answer in (c).
]



