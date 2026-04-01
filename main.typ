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
#let dr = $dif r$
#let dth = $dif th$
#let lna(x) = $ln abs(#x)$
#let pm = $plus.minus$
#let ans(x) = $ #rect[$#x$] $
#let fto(x) = $lr(#x])$

#let um = "m"
#let ukg = "kg"
#let uN = "N"
#let ukm = "km"
#let us = "s"
#let uJ = "J"
#let ukJ = "kJ"


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
      f(r) & = 4 pi r^2 psi^2_100 (r) \
           & = A r^2 e^( (- 2 r) / a_0)
    $
    where $a_0$ is the Bohr radius.

  ]
  + #p[Find the cumulative distribution function $F(r)$.] <question1a>

    From the definition of the cumulative distribution function $F(r)$:

    $
      F(r) = int_(0)^(r) f(x) dx
    $
    Noting that in our case, the electron-proton distance cannot be negative, so the integral spans from $0$ to $r$ instead of from $-inf$ to $r$.

    So we can just compute the improper integral. 
    $
      F(r) & = int_(0)^(r) f(x) dx \
      F(r) & = int_(0)^(r) A x^2 e^( (- 2 x) / a_0) dx \
    $
    We can do integration by parts:
    $
      u = A x^2 wide dv = e^( (- 2 x) / a_0) dx \
      du = 2A x dx wide v = (a_0 ) / (- 2 ) e^( (- 2 x) / a_0)
    $

    $
      F(r) & = fto(((A x^2) ((a_0 ) / (- 2 ) e^( (- 2 x) / a_0))))_0^r - int_0^r (a_0 ) / (- 2 ) e^( (- 2 x) / a_0) 2A x dx \
      F(r) & = fto((- ( 1) / ( 2 ) A a_0 x^2 e^( (- 2 x) / a_0)))_0^r - int_0^r -a_0 A x e^( (- 2 x) / a_0) dx
    $

    Doing integration by parts again:
    $
      t = -a_0 A x wide dp = e^( (- 2 x) / a_0) dx \
      dt = -a_0 A dx wide p = ( a_0 / (- 2 )) e^( (- 2 x) / a_0) \
    $

    So we get:
    $
      F(r) & = fto((- ( 1) / ( 2 ) A a_0 x^2 e^( (- 2 x) / a_0)))_0^r - ( fto(((-a_0 A x)(( a_0 / (- 2 )) e^( (- 2 x) / a_0) )))_0^r - int_0^r ( a_0 / (- 2 )) e^( (- 2 x) / a_0) (-a_0 A) dx ) \
      F(r) & = fto((- ( 1) / ( 2 ) A a_0 x^2 e^( (- 2 x) / a_0)))_0^r - ( fto(( 1 / (2 ) a_0^2 A x e^( (- 2 x) / a_0) ))_0^r - int_0^r ( (a_0^2 A) / ( 2 )) e^( (- 2 x) / a_0) dx ) \
      F(r) & = fto((- ( 1) / ( 2 ) A a_0 x^2 e^( (- 2 x) / a_0)))_0^r - ( fto(( 1 / (2 ) a_0^2 A x e^( (- 2 x) / a_0) ))_0^r - fto(( ( (a_0^2 A) / ( 2 )) ( a_0 / (- 2 )) e^( (- 2 x ) / a_0) ))_0^r ) \
      F(r) & = fto((- ( 1) / ( 2 ) A a_0 x^2 e^( (- 2 x) / a_0)))_0^r - fto(( 1 / (2 ) a_0^2 A x e^( (- 2 x) / a_0) ))_0^r + fto(( 1 / ( -4 )a_0^3 A e^( (- 2 x) / a_0) ))_0^r \
      F(r) & =
      ((- ( 1) / ( 2 ) A a_0 r^2 e^( (- 2 (r)) / a_0))
        -
        (- ( 1) / ( 2 ) A a_0 0^2 e^( (- 2 (0)) / a_0)) )
      \
      &- (
        ( 1 / (2 ) a_0^2 A (r) e^( (- 2 (r)) / a_0) )
        -( 1 / (2 ) a_0^2 A (0) e^( (- 2 (0)) / a_0) )
      )
      \
      &+
      (( 1 / ( -4 )a_0^3 A e^( (- 2 (r)) / a_0) )) -
      (( 1 / ( -4 )a_0^3 A e^( (- 2 (0)) / a_0) ))
      \
    $

    Therefore, the cumulative distribution function is:
    $
      #rect[$ F(r) & =- ( 1) / ( 2 ) A a_0 r^2 e^( (- 2 r) / a_0)- 1 / (2 ) a_0^2 A r e^( (- 2 r) / a_0)- 1 / (4 )a_0^3 A e^( (- 2 r ) / a_0) + 1 / ( 4 )a_0^3 A \ $ ]
    $

    Or in a different form: 

    $
     F(r) & = -(1)/(2) a_0 A ( e^( (- 2 r) / a_0) ( r^2  + a_0 r + 1 / (2 )a_0^2) - 1 / ( 2 )a_0^2)
    $


    #todo[Check reduced form]

  + #p[Determine the value of $A$ (i.e., “normalize” the distribution).] <question1b>

    To normalize the function, we can set the value of its total indefinite integral equal to $1$, and solve for $A$. In effect ensuring that the probability of all possible outcomes (radii) sums to one. (In our case, the electron-proton distance cannot be negative, so the integral has bounds from $0$ to $inf$.)
    $
      int_(0)^(inf) f(x) dx = 1 \ 
      int_(0)^(inf) A x^2 e^( (- 2 x) / a_0) dx = 1
    $
    #todo[Check correct the bounds and the resoning]

    Fortunately, we already computed the integral as part of question #link(<question1a>, "1.a)"), so we can rewrite this integral in terms of the cumulative distribution function.
    $
      int_(0)^(inf) f(x) dx = lim_(r -> inf) int_(0)^(r) f(x) dx = lim_(r -> inf) F(r) = 1\
    $

    So we can write:
    $
      1 &= lim_(r->inf) F(r)\
      1 &= lim_(r->inf) ( ( 1) / ( 2 ) A a_0 r^2 e^( (- 2 r) / a_0)- 1 / (2 ) a_0^2 A r e^( (- 2 r) / a_0)- 1 / (4 )a_0^3 A e^( (- 2 r ) / a_0) + 1 / ( 4 )a_0^3 A ) \
      1 &= lim_(r->inf) ( ( 1) / ( 2 ) A a_0 r^2 e^( (- 2 r) / a_0))
      -
      lim_(r->inf) (1 / (2 ) a_0^2 A r e^( (- 2 r) / a_0))
      -
      lim_(r->inf)(1 / (4 )a_0^3 A e^( (- 2 r ) / a_0))
      +
      lim_(r->inf)(1 / ( 4 )a_0^3 A ) \
      1 &= lim_(r->inf) ( ( A a_0 r^2) / (2 e^( ( 2 r) / a_0)))
      -
      lim_(r->inf) (( A a_0^2 r) / (2 e^( ( 2 r) / a_0)))
      - 0 + 1 / (4) a_0^3 A \
    $

    Now we do L'Hôpital's rule on both the limits:
    $
      1 & =^("L.H") lim_(r->inf) ( ( 2 A a_0 r) / (2 ( a_0 / ( 2 )) e^( ( 2 r) / a_0)))
          -
          lim_(r->inf) (( A a_0^2 ) / (2 ( a_0 / ( 2 )) e^( ( 2 r) / a_0)))
          + 1 / (4) a_0^3 A \
      1 & = lim_(r->inf) ( ( 2 A a_0 r) / (2 ( a_0 / ( 2 )) e^( ( 2 r) / a_0))) - 0 + 1 / (4) a_0^3 A \
    $
    Doing L'Hopital's rule again on the limit:
    $
      1 & =^("L.H") lim_(r->inf) ( ( 2 A a_0) / (2 ( a_0 / ( 2 )) ( a_0 / ( 2 )) e^( ( 2 r) / a_0)))+ 1 / (4) a_0^3 A \
      1 & = 0 + 1 / (4) a_0^3 A \
    $

    Now solving for $A$:
    $
      (4(1)) / a_0^3 & = A \
    $

    Therefore, to normalize the distribution:

    $
      #rect($ A = 4 / a_0^3 $)
    $


  + #p[Determine the probability that the electron will be found within $2a_0$ of the proton. Does this seem reasonable?]

    To determine the probability that the electron will be found within $2a_0$ of the proton, we can evaluate the integral,
    $
      P(r < 2a_0) = int_0^(2a_0) f(x) dx
    $
    of the Probability Distribution Function $f(x)$.

    Noting that this is the same evaluating the Cumulative Probability Function $F(x)$ (as found in #link(<question1a>, "1.a)")) at $x = a_0$, we can simplify the problem:
    $
      P(r < 2a_0) = int_0^(2a_0) f(x) dx = F(2a_0) & = -( 1) / ( 2 ) A a_0 (2a_0)^2 e^( (- 2 (2a_0)) / a_0)- 1 / (2 ) a_0^2 A (2a_0) e^( (- 2 (2a_0)) / a_0)- 1 / (4 )a_0^3 A e^( (- 2 (2a_0) ) / a_0) + 1 / ( 4 )a_0^3 A \
    $

    Where $A = 4 / a_0^3$ as found in #link(<question1b>, "1.b)"). So we can rewrite:

    $
      P(r < 2a_0) & = -( 1) / ( 2 ) (4 / a_0^3) a_0 (2a_0)^2 e^( (- 2 (2a_0)) / a_0)- 1 / (2 ) a_0^2 (4 / a_0^3) (2a_0) e^( (- 2 (2a_0)) / a_0)- 1 / (4 )a_0^3 (4 / a_0^3) e^( (- 2 (2a_0) ) / a_0) + 1 / ( 4 )a_0^3 (4 / a_0^3) \
      & = -( 1) / ( 2 ) (4 ) (2)^2 e^( (- 2 (2)))
      - 1 / (2 ) (4) (2) e^( (- 2 (2)) )- 1 / (4 ) (4 ) e^( (- 2 (2) ) ) + 1 / ( 4 ) (4) \
      & = - (2) (4) e^( -4 )
      - 4 e^( -4 )- e^(- 4)
      + 1 \
      & = -13 e^( -4 ) + 1 \
    $

    Therefore the probability that the electron will be found within $2a_0$ of the proton is:

    $
      #rect[$ P(r < 2a_0) = -13 e^( -4 ) + 1 approx 0.7618966944 $]
    $

    This is reasonable, as there is about a 75% chance that the electron will be found within two Bohr Radii.


    #todo[Improve this statement of reasonability]


  + #p[Determine the "most probable" and the "expected" radius for the hydrogen atom in the ground state.]

   To find the most probable radius, we can just find the mode of the distribution. The mode is defined as the $r$ value for which the probability density function is maximized.

    Therefore, we must find the global maximum of $f(r)$.

    Taking a first derivative:
    $
            f (r) & = A r^2 e^( (- 2 r) / a_0) \
      f prime (r) & = A ( 2 r e^( (- 2 r) / a_0) + r^2 e^( (- 2 r) / a_0) ( - 2 / a_0)) \
    $

    Finding the place where the derivative is $0$:
    $
                      0 & = f prime (r) = A ( 2 r e^( (- 2 r) / a_0) + r^2 e^( (- 2 r) / a_0) ( - 2 / a_0)) \
                      0 & = e^( (- 2 r) / a_0) ( 2 r + r^2 ( - 2 / a_0)) \
                      0 & = 2 r + r^2 ( - 2 / a_0) wide e^( (- 2 r) / a_0) != 0 \
                      0 & = r ( 2 + r ( - 2 / a_0) ) \
                      0 & = 2 + r ( - 2 / a_0) wide r != 0 "as the electron cannot be on the nucleus" \
      -2( - a_0 /( 2) ) & = r \
                    a_0 & = r
    $

    To prove that $a_0$ is a global maximum, and not a global minimum, we can evaluate the function at an arbitrary point and show that its value is less than $f(a_0)$. I choose to evaluate at $2 a_0$
    $
           f (r) & = A r^2 e^( (- 2 r) / a_0) wide
                   A = 4 / a_0^3 \
         f (a_0) & = 4 / a_0^3 a_0^2 e^( (- 2 a_0) / a_0) = 4 / a_0 e^(- 2) \
      f (2 a_0 ) & = (4 / a_0^3) (2 a_0 )^2 e^( (- 2 (2 a_0 )) / a_0) = 8 / a_0 e^( - 4 ) \
    $
    $
      (f (2 a_0 )) / (f (a_0) ) = (8 / a_0 e^( - 4 )) / (4 / a_0 e^(- 2)) = 2 e^(-6) approx 0.004957504353 < 1 \ 
      // (f (2 a_0 )) / (f (a_0) ) < 1 wide f(a_0)  = 4 / a_0 e^(- 2) > 0 \ 
      // therefore f(2 a_0 ) < f(a_0)
    $
    By definition $f(r)  > 0$:

    So:
    $
      (f (2 a_0 )) / (f (a_0) ) < 1 \
      f (2 a_0 ) < f (a_0)
    $

    Hence $r = a_0$ is a global maximum of $f(r)$:

    Therefore the most probable radius is:
    $
      #rect[Most probable radius $ r = a_0 $]
    $


    The expected radius is characterized by the mean of the Probability Density Function.

    Using the definition of the mean: 
    $
      mu = int_(0)^inf x(f(x)) dx \
    $
    (in our case, the electron-proton distance cannot be negative, so $f(r) > 0$, thus the integral has bounds from $0$ to $inf$.)
    // Since by definition $f(x) > 0$, we can rephrase:
    // $
    //   mu = int_(0)^inf x(f(x)) dx \
    // $
    Computing the integral:
    $
      mu & = int_(0)^inf x (f(x)) dx \
         & = int_(0)^inf x A x^2 e^( (- 2 x) / a_0) dx \
         & = lim_(r -> inf) int_(0)^r A x^3 e^( (- 2 x) / a_0) dx \
         & = A lim_(r -> inf) int_(0)^r x^3 e^( (- 2 x) / a_0) dx \
    $

    For an integral with such a large exponent on $x$, it is helpful to use the DI method when doing integration by parts.

    #block(breakable: false)[#align(center)[
      #table(
        columns: (1fr, 1fr, 1fr),
        align: center,
        stroke: (x, y) => if x == 0 or x == 1 {
          (right: 0.7pt + black)
        },
        table.header([*Sign*], [*D*], [*I*]),
        [$+$], [$x^3$], [$e^( (- 2 x) / a_0)$],
        [$-$], [$3x^2$], [$(- a_0 / 2)e^((- 2 x) / a_0)$],
        [$+$], [$6x$], [$(- a_0 / 2)^2e^((- 2 x) / a_0)$],
        [$-$], [$6$], [$(- a_0 / 2)^3 e^((- 2 x) / a_0)$],
        [$+$], [$0$], [$(- a_0 / 2)^4 e^((- 2 x) / a_0)$],
      )
    ]]
    Then writing it all out, we get:

    $
      mu & = A lim_(r -> inf) fto(
      ((x^3)((- a_0 / 2)e^((- 2 x) / a_0))
      - (3x^2)((- a_0 / 2)^2e^((- 2 x) / a_0)) 
      + (6x) ((- a_0 / 2)^3 e^((- 2 x) / a_0)) 
      - (6) (- a_0 / 2)^4 e^((- 2 x) / a_0) )
      )_(0)^r \
    $

    At the limit to infinity, all these terms go to zero, as they turn into an indeterminate form, resulting in a polynomial on the top that differentiates (over several rounds of applying L'Hopital's rule) to a constant, and an exponential on the bottom that increases as $x$ goes to infinity.

    Writing it out for each term (with "L.H" signifying L'Hopital's): 
    $
      &lim_(r -> inf) (r^3)((- a_0 / 2)e^((- 2 r) / a_0)) =
       (- a_0 / 2) lim_(r -> inf)  (r^3) / (e^((2 r) / a_0)) 
       =^("L.H") (- a_0 / 2) lim_(r -> inf)  (3 r^2) / ( a_0 / (2 r) e^((2 r) / a_0))  
       =^("L.H") (- a_0 / 2) lim_(r -> inf)  (6 r) / ( (a_0 / (2 r))^2 e^((2 r) / a_0)) 
       =^("L.H") (- a_0 / 2) lim_(r -> inf)  (6) / ( (a_0 / (2 r))^3 e^((2 r) / a_0)) = 0 \ 


      &lim_(r -> inf) - (3r^2)((- a_0 / 2)^2e^((- 2 r) / a_0)) =  
      - (- a_0 / 2)^2 lim_(r -> inf) (3r^2) / (e^(( 2 r) / a_0))
      =^("L.H") - (- a_0 / 2)^2 lim_(r -> inf) (6r) / ( (a_0 / (2 r)) e^(( 2 r) / a_0))
      =^("L.H") - (- a_0 / 2)^2 lim_(r -> inf) (6) / ( (a_0 / (2 r))^2 e^(( 2 r) / a_0))
      = 0 
      \ 

      &lim_(r -> inf) (6r) ((- a_0 / 2)^3 e^((- 2 r) / a_0)) = 
      ((- a_0 / 2)^3 lim_(r -> inf) (6r)  / ( e^((2 r) / a_0)) ) 
       =^("L.H") ((- a_0 / 2)^3 lim_(r -> inf) (6)  / ( (a_0 / (2 r)) e^((2 r) / a_0)) )
       = 0 

      \ 
      &lim_(r -> inf) - (6) (- a_0 / 2)^4 e^((- 2 r) / a_0) ) = 0
      
      \ 
    $

    #todo[Check the write this out better]

    Since all of these terms sum to $0$, the bar expression can be simplified:

    $
      mu = A (lim_(r -> inf) (
      ((r^3)((- a_0 / 2)e^((- 2 r) / a_0))
      - (3r^2)((- a_0 / 2)^2e^((- 2 r) / a_0)) 
      + (6r) ((- a_0 / 2)^3 e^((- 2 r) / a_0)) 
      - (6) (- a_0 / 2)^4 e^((- 2 r) / a_0) ))
      \  - (((0)^3)((- a_0 / 2)e^((- 2 (0)) / a_0)) - (3(0)^2)((- a_0 / 2)^2e^((- 2 (0)) / a_0)) + (6(0)) ((- a_0 / 2)^3 e^((- 2 (0)) / a_0)) - (6) (- a_0 / 2)^4 e^((- 2 (0)) / a_0) ))  \
    $

    $
      mu & = A ( 0 - (- (6) (- a_0 / 2)^4 e^(0) ) ) \
    $

    Using $A = 4 / a_0^3$ found in part b, we can simplify:

    $
      // mu & = (4 / a_0^3)( - (((0)^3)((- a_0 / 2)e^((- 2 (0)) / a_0)) - (3(0)^2)((- a_0 / 2)^2e^((- 2 (0)) / a_0)) + (6(0)) ((- a_0 / 2)^3 e^((- 2 (0)) / a_0)) - (6) (- a_0 / 2)^4 e^((- 2 (0)) / a_0) ) ) \
      mu & = (4 / a_0^3)(0 - (- (6) (- a_0 / 2)^4 e^(0) ) )\
      mu & = (4 / a_0^3) (6) (a_0^4 / 2^4) \
      mu & = (4) (6) (a_0 / 2^4) \
      mu & = (24 / 16 ) (a_0) \
    $

    Therefore the expected radius is:
    $
      #rect[Expected radius $ r = mu = 3 / 2 a_0 $]
    $

   

+ #p[_Newton's universal law of gravitation_ states that the force of attraction between two point masses $m$ and $M$ has magnitude

    $
      F = (G m M) / r^2
    $

    where $r$ is the distance between the masses and $G = 6.67 times 10^(-11) uN dot um^2/(ukg^2)$ is a constant.
  ]
  + #p[
      If $M$ represents the mass of the centre of the earth and we regard it as a point mass concentrated at its centre, show that Newton's universal law of gravitation at the earth's surface reduces to $F = m g$, where $g = 9.82 m/s^2$. Assume for the calculation of $M$ that the earth is a sphere with radius $6370 ukm$ and mean density $5.52 times 10^3 ukg/um^3$.
    ]

    First some variable definitions and unit conversion. \
    Let:
    $
      R = 6370 ukm = (6370 ukm) ((1000 um )/(1 ukm)) = 6,370,000 um \
      rho = 5.52 times 10^3 ukg/um^3 \
    $

    Where $R$ is the radius of the earth, and $rho$ is the density of the earth.

    Approximating the earth as a sphere, its mass is approximately:
    $
      M = 4/3 pi R^3 rho
    $

    Approximating the mass of the earth as acting at a point at its center, the distance between any body sufficiently close to the earth's surface would be approximately equal to the radius of the earth. Therefore, from _Newton's universal law of gravitation_ the force experienced by such an object would be:

    $
      F & = (G m M) / r^2 \
      // F = (G m M) / R^2 \
      F & = m (G M) / R^2 \
    $
    Calculating $(G M) / R^2$
    $
      (G M) / R^2 & = (G ( 4/3 pi R^3 rho) ) / R^2 \
                  & = 4/3 G pi R rho \
                  & = 4/3 (6.67 times 10^(-11) N dot um^2 ukg^(-2)) (3.1415926536) (6,370,000 um) (5.52 times 10^3 ukg/um^3) \
      (G M) / R^2 & = 9.8241040437 um/us^2 approx 9.82 um/us^2
    $

    $
      F & = m (G M) / R^2 \
      F & = m (9.82 um / us^2)
    $

    Therefore, for objects close to earth's surface, _Newton's universal law of gravitation_ can be reduced to :
    $
      #rect[$ F & = m g $] \
    $
    where $g = 9.82 um / us^2$.


  + #p[Use the original $F = (G m M) / r^2$ with the earth regarded as a point mass to calculate the work required to lift a mass of 10kg from the earth's surface to a height of $10 ukm$.]

    #let DR = $Delta R$;

    Let $DR$ represent the change in $R$ from its initial height above the earth to its end position.

    $
      DR = 10 ukm = (10 ukm)((1000 um )/(1 ukm)) = 10000 um
    $

    Work $W$ is defined as:
    $
      W = int F dr
    $
    Where $F$ is the force, and $dr$ is the change in radius.

    Therefore we can express this work needed as an integral:
    $
      W = int_R^(R+DR) F dr \
    $

    Solving we get:
    $
      W & = int_R^(R+DR) (G m M) / r^2 dr \
        & = G m M int_R^(R+DR) r^(-2) dr \
        & = G m M ( fto(-r^(-1))_R^(R+DR) ) \
        & = G m M ( -(R+DR)^(-1) - ( -R^(-1) ) ) \
      W & = G m M ( -(R+DR)^(-1) + R^(-1) ) \
    $

    As we previously found:
    $
      M = 4/3 pi R^3 rho \
      M = 4/3 (3.1415926535) (6,370,000 um)^3 (5.52 times 10^3 ukg/um^3)
    $

    Plugging in our values:

    $
      W & = G m M ( -(R+DR)^(-1) + R^(-1) ) \
        \
        & = (6.67 times 10^(-11) N dot um^2 ukg^(-2)) (10 ukg) times \
        & (4/3 (3.1415926535) (6,370,000 um)^3 (5.52 times 10^3 ukg/um^3)) times \
        & ( -( (6,370,000 um) + 10000 um)^(-1) + (6,370,000 um)^(-1) ) \
        \
    $

    $
      #rect[$ W & = 980 870.576 uJ approx 981 ukJ $ ]
    $


  + #p[
      Calculate the work in part (b) using the constant gravitational force $F = m g$ in part (a). Is there a significant difference?
    ]

    As in part (b), let $DR$ represent the change in $R$ from its initial height above the earth to its end position.

    $
      W & = int_R^(R+DR) F dr \
        & = int_R^(R+DR) m g dr \
        & = fto(m g r)_R^(R+DR) \
        & = m g (R+DR) - m g (R) \
      W & = m g DR \
    $

    Using the value of $g$ we calculated from part $a$:
    $
      g = 9.8241040437 um/us^2 \
      DR = 10000 um
    $

    $
      W & = m g DR \
      W & = (10 ukg) (9.8241040437 um/us^2) (10000 um) \
    $

    $
      #rect[$ W & = 982 410.404 uJ approx 982 ukJ $]
    $

    Calculating the difference:
    $
      abs(982 410.404 "J" - 980 870.576 "J") = 1539.828 "J"
    $

    Dividing by the integrated form of work, and multiplying by $100 %$, we get a relative difference of:

    $
      (1539.828 "J" ) / (980 870.576 "J") times 100% = 0.157 %
    $

    #rect[
    Therefore there is a $0.157%$ difference between the values, totaling about $1539.828 uJ $, showing a small but apparent difference in using the actual equation compared to its reduced form #todo["check between what"].
    ]

+ #p[In the next problem you will be working with a couple of examples of a fractal. A fractal
    is a mathematical set that displays a self-similarity property; that is, it exhibits a repeating
    pattern that displays at every scale.]

  + #p[The Cantor set, named after the German mathematician Georg Cantor (1845-1918), is constructed as follows. We start with the closed interval $[0,1]$ and remove the open interval $(1/3,2/3)$. That leaves the two intervals $[0,1/3]$ and $[2/3,1]$. We then remove the open middle interval third of each of these two remaining intervals. We continue this procedure indefinitely, at each step removing the open middle third of every interval that remains from the preceding step. The Cantor set consists of the numbers that remain in the original interval $[0,1]$ after all those intervals have been removed.]

    + #p[Sketch a diagram that shows the first 5 iterations of the Cantor set.]

      #let draw_cantor(x) = {
        if x == 0 {
          line(length: 100%, stroke: 10pt)
        } else {
          let h = draw_cantor(x - 1)
          grid(
            columns: (1fr, 1fr, 1fr),
            h, [], h,
          )
        }
      }
      #block(breakable: false)[
        #for value in range(0, 7) {
          draw_cantor(value)
        }
      ]

      Where each bar is a closed sub-interval of $[0, 1]$.

      I wrote this myself using a recursive algorithm in the typst programming language. The code is below:

      #block(breakable:false)[```typ
      #let draw_cantor(x) = {
        if x == 0 { // base case for the recursive process
          line(length: 100%, stroke: 10pt,) // just draw the line.
        } else {
          let h = draw_cantor(x - 1);
          grid(columns:(1fr, 1fr, 1fr),h,[],h,)
        }
      }
      #for value in range(0, 10) {
        draw_cantor(value) // call the draw_cantor function 5 times, each with a
      }
      ```]

      #todo[Include a handwritten drawing as well]



    + #p[Give examples (at least 5) of some numbers in the Cantor set.]

      Since we are always removing the open interval in the middle of a closed interval, the numbers defining closed bounds themselves are never removed. Therefore we can just take the first 5 bounds.

      At each level of the set, to get the next level, we remove the middle third of each interval. Therefore to get the next set of bounds, we can add one third the width of each interval to each lower bound, and subtract one third from each upper bound.

      #align(center)[
        #table(
          columns: (1fr, 1fr),
          stroke: { none },
          align: center,
          table.header("Bounds", "One-third the Width of each Interval"),
          $ [0, 1] $, $ 1/3 $,
          $ [0, 1/3] union [2/3, 1] $, $ 1/9 $,
          $ [0, 1/9] union [2/9, 1/3] union [2/3, 7/9] union [8/9, 1] $, $ 1/27 $,
        )
      ]
      This leaves us with our final list:
      $
        #rect[$ 0, 1/9, 2/9, 1/3, 2/3, 7/9, 8/9, 1 $]
      $
      are all in the cantor set.


    + #p[Show that the total length of all the intervals that are removed is $1$. Despite that, the Cantor set is not an empty set.]

    In the first level of recursion, we remove the open middle third of one interval of length $1$, for a total of $(1/3)(1)(1)$ length removed.

    In the second level of recursion we remove the open middle third of the two sub-intervals we just created, each spanning a length of $1/9$, for a total of $(1/3)(2)(1/9)$ length removed.

    For the $n^"th"$ level of recursion, we remove the middle third of $2^(n - 1)$ intervals, spanning a length of $1 / 3^(n - 1)$, for a total of $(1/3)(2^(n - 1)) (1 / 3^(n - 1))$. Therefore, to get the total length removed, we can simply take the sum of these removals for an infinite recursion depth.

    #todo[Check the clean.]

    $
      L = sum_(n=1)^inf (1/3)(2^(n - 1)) (1 / 3^(n - 1)) = sum_(n=1)^inf (1/3)(2 / 3)^(n - 1)
    $
    Where $L$ represents the length removed.

    Now we can show that this infinite series converges to a value.

    This is just a geometric series. 

    // With some algebraic manipulation, we can form this into a geometric series:

    // $
    //   L & = sum_(n=1)^inf (2^(n - 1) )/3^n \
    //     & = sum_(n=1)^inf (2^(n - 1) )/(3 (3^(n-1))) \
    //     & = sum_(n=1)^inf (1/3) (2/3)^(n - 1) \
    // $
    // 
    Since $abs(2/3) < 1$, we can use the formula:
    $
      sum_(n=1)^inf a r^(n - 1) = a / (1 - r)
    $

    So:
    $
      L = sum_(n=1)^inf (1/3) (2/3)^(n - 1) = (1/3) / (1 - (2/3)) = ((1/3)) / ((1/3)) = 1
    $

    $ #rect[Hence, the length removed is equal to 1.] $

  // Let $S_n$ represent the $n$th partial sum of $L$:
  // $
  //   S_n = sum_(i = 1) ^ n n/3^n
  // $

  // Now we can take the limit as $n$ approaches infinity:
  // $
  //   S &= lim_(n -> inf) S_n \
  //   & = lim_(n -> inf)  sum_(i = 1) ^ n n/3^n
  // $

  // Taking the limit of the terms as $n$ approaches infinity:
  // $
  //   lim_(n -> inf) n (1/3^n) &= lim_(n -> inf) n /3^n \
  // $
  // Since this is an indeterminate form, we can use l'Hopital's rule.
  // $
  //   lim_(n -> inf) 1 /( 3^n ln(3)) = 0
  // $
  // Therefore the terms approach 0.

  // #todo[Show that this infinite series sums to 1.]


  + #p[The Sierpinski carpet is a two-dimensional counterpart of the Cantor set. It is constructed by removing the centre one-ninth of a square of side 1, then removing the centres of the eight smaller remaining squares, and so on. A visualization of the Sierpinski carpet is available on Wikipedia (https://en.wikipedia.org/wiki/Sierpinski_carpet).]

    + #p[Show that the sum of the areas of the removed squares is 1. This implies that the Sierpinski carpet has area 0.]

    Just like problem a)ii., we can construct a series representing the area removed.

    In the first level of recursion we remove the center one-ninth of one square of area $1$, for a total of $(1/9)(1)(1)$ area removed.

    In the second level of recursion we remove the center one-ninth of $8$ squares of area $1/9$, for a total of $(1/9)(8)(1/9)$ area removed.

    For the $n^"th"$ level of recursion, we remove the center one-ninth of $8^(n - 1)$ squares of area $1/9^(n - 1)$, for a total of $(1/9)(8^(n - 1))(1/9^(n-1))$

    Therefore, to get the total area removed, we can simply take the sum of these removals for an infinite recursion depth.

    $
      A = sum_(n=1)^inf (1/9) (8^(n - 1))(1/9^(n-1))
    $
    Where $A$ represents the length removed.

    Now we can show that this infinite series converges.
    // #todo[Show that this infinite series converges.]

    Similar to the previous question, we can rearrange it into a geometric series:
    $
      A & = sum_(n=1)^inf (1/9) 8^(n - 1)/9^(n-1) \
        & = sum_(n=1)^inf (1/9) (8/9)^(n-1) \
    $

    Since $abs(8/9) < 1$, we can use the formula:
    $
      sum_(n=1)^inf a r^(n - 1) = a / (1 - r)
    $

    So:
    $
      A = sum_(n=1)^inf (1/(9)) (8/9)^(n - 1) = (1/9) / (1 - (8/9)) = ((1/9)) / ((1/9)) = 1
    $

    $ #rect[Therefore the total area removed is 1.] $

