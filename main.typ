// math template
#import "@preview/numbly:0.1.0": numbly

#import "@preview/dashy-todo:0.1.2": todo

#import "@preview/frame-it:1.2.0": *

#import "@preview/lilaq:0.5.0" as lq

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

+ #p[
  Suppose that $f$ is differentiable with $f prime (x) > 0$ for all $x$ and suppose that $f(1) = 0$. Set
  $
    F(x) = int_0^x f(t) dif t
  $
  Determine if each statement is True or False. Justify your answer.
  ]
  + #p[The function $F(x)$ is continuous.]
  + #p[The function $F(x)$ is not twice differentiable. ]
  + #p[The value x = 1 is a critical point of $F$.]
  + #p[The function $F(x)$ takes on a local minimum at $x = 1$. ]
  + #p[$F(1) > 0$.]
  #p[Based on your answers above, make a rough sketch of the graph of $F(x)$. ]

+ #p[Recall in class we proved that $display(sum_(i = 1)^k i = (k(k+1))/2)$. In this problem, we will construct a proof of #block($display(S = sum_(i = 1)^k i^2 )$ )]

  + #p[Calculate the value of $S$ for $k = 1,2,3$ and $4$.]
  
  + #p[Calculate the value of $display((k(k+1)(2k+1))/6)$] 
  + #p[Show that $display(sum_(i = 1)^k i^2 = (k(k+1)(2k+1))/6)$ by constructing a proof by induction by:]
    + #p[showing the equality is true for the base case (i.e., $k=1$).]
    + #p[for each positive integer $N$, the equality holds for $k = N$ implies the equality for $k = N + 1$.

    Be sure to end your proof with an appropriate conclusion statement (i.e., "Therefore, by induction, ...").]

+ #p[Let $f(x)$ be an integrable function over the interval $[a,b]$. Choose an integer $N$ and let
  $
    x_k = a + k Delta x, #h(1em) k = 0, 1, 2, ..., N "where" Delta x = (b-a)/N
  $

  The #link("https://en.wikipedia.org/wiki/Trapezoidal_rule")[trapezoid rule] is an approximation of the definite integral: 
  $
    int_a^b f(x) dif x approx Delta x sum^N_(k=1) (f(x_k) + f(x_(k-1)) ) / 2,
  $

  where $Delta x = (b - a) / N$

  A bound on the error is given by the error formula

  $
    abs(int_a^b f(x) dif x - (b-a)/N sum^N_(k=1)  (f(x_k) + f(x_(k-1)) ) / 2, ) <= (b-a)^3 / (12 N^2)K_2
  $

  where $K_2$ is any number such that $abs(f prime prime (x) ) <= K_2$ for all $x in [a,b]$. 

  Consider the #link("https://en.wikipedia.org/wiki/Fresnel_integral")[Fresnel integral]

  $
    int_0^sqrt(pi/2) sin(x^2) dif x
  $]

  + #p[Write out and calculate the Left and Right Riemann sums for $N = 4$.] 
  + #p[Write our and calculate the Trapezoid rule for $N = 4$.] 
  + #p[Find and appropriate value of $K_2$ for the Fresnel integral. Be sure to justify your answer.] 
  + #p[Find the value of (the smallest) $N$ which guarantees the trapezoid rule approximates the Fresnel Integral with errors less than $10^(-1)$ and $10^(-2)$. Be sure to justify your answers.]
+ #p[In class, we proved Part 2 of the Fundamental Theorem of Calculus, which states that if $f$ is a continuous function on the interval $[a, b]$ and F is any antiderivative of $f$, then

  $
    F(b)-F(a) = int_a^b f(x) dif x
  $

    Here, you will construct another proof of Part 2 of the Theorem.]

  + #p[Divide the interval $[a, b]$ in $n$ subintervals with endpoints $a = x_0 < x_1 < x_2 < ... < x_n = b $. Show that

  $
    F(b) - F(a) = sum_(i=1)^n (F(x_i) - F(x_(i-1)))
  $]

  + #p[Now suppose that $F$ is any antiderivative of $f$. Show that there exists a number $c_i$ in
  each interval $[x_(i-1), x_i]$ such that ]

    $
      F(x_i) - F(x_(i-1)) = f(c_i)(x_i - x_(i-1))
    $

  + #p[Now build an appropriate Riemann sum for $f$ on $[a,b]$ and show that
  $
    F(b) - F(a) = int^b_a f(x) dif x
  $]



#show: appendix

= Guide to Finding Intersection Points of $P_"in"$ and $P_"out"$ in Python<app1>
Create a new Jupyter notebook using anaconda. Copy and paste the following lines of code into a new cell.

+ #p[
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