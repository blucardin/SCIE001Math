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
        S = int_0^(2pi) sin^k (x) dif x
      $
      If $k$ is an odd positive integer, determine the value of S.
    ]

  // First, we can evaluate the case where $k = 1$:

  // #todo("Maybe remove this")

  // $
  //   S & = int_0^(2pi) sin^1 (x) dif x \
  //     & = lr(- cos (x) bar)_0^(2pi) \
  //     & = - cos (2pi) - (- cos (0) ) \
  //   S & = 0
  // $

  // By definition, for all $k != 1$:
  // $ k > 1 $

  // For all $k > 1$:
  $
    S = int_0^(2pi) sin^k (x) dif x & = int_0^(2pi) sin^(k - 1) (x) sin^(1) (x) dif x \
  $
  All odd numbers subtract 1 are even. And all even numbers are divisible by $2$, and hence are representable by some integer times 2.

  Since $k$ is odd, $k - 1$ must be even. Therefore, we can let $2p = k - 1$, where $p$ is some positive integer such that $p >= 0$.

  $
    S & = int_0^(2pi) sin^(2p) (x) sin^(1) (x) dif x \
      & = int_0^(2pi) (sin^(2) (x))^p sin^(1) (x) dif x \
      & = int_0^(2pi) (1 - cos^(2) (x))^p sin^(1) (x) dif x wide "since " sin^2(x) + cos^2(x) = 1 \
  $
  $u$-substitution for $cos(x)$:
  $
    u = cos(x) wide dif u = -sin(x) dif x \
  $
  $
    S & = int_0^(2pi) - (1 - cos^(2) (x))^p ( - sin^(x)) dif x \
      & = - int_cos(0)^(cos(2pi)) (1 - u^2)^p dif u \
      & = - int_1^(1) (1 - u^2)^p dif u \
  $
  Any integral from one number to itself is 0. So:
  $
    S & = - int_1^(1) (1 - u^2)^p dif u = 0 \
  $
  Therefore for any odd positive integer $k$:
  $
    #rect[S = 0]
  $


  + #p[Calculate
      $
        integral 1/x sqrt(a^2 - x^2) dif x
      $

      + by using a $u$-substitution.
      + by using a trig substitution.
      Then compare your results.
    ]
    *First a $u$-substitution:*
    $
      u &= sqrt(a^2 - x^2) wide & u^2 = a^2 - x^2\
      du &= (1/2)(a^2 - x^2)^(-1/2)(-2x) dx wide& x^2 = a^2 - u^2 \
      du &= (-x)/sqrt(a^2 - x^2) wide &x = sqrt(a^2 - u^2)\ 
       
    $
    $
      & int 1/x sqrt(a^2 - x^2) dif x \
      // = int x^(-1) sqrt(a^2 - x^2) dif x
      & = int (sqrt(a^2 - x^2)/x)((-x sqrt(a^2 - x^2))/(-x sqrt(a^2 - x^2))) dif x \
      
      & = int ((sqrt(a^2 - x^2))^2/(-x^2))((-x)/(sqrt(a^2 - x^2))) dif x \

      & = int u^2/(-(sqrt(a^2 - u^2))^2) du \

      & = - int u^2/(a^2 - u^2) du \
    $
    Now we do a quick polynomial division:
    #align(center)[
      #tablex(columns: 4, auto-lines: false, stroke: 0.5pt, align: center,
      $$, vlinex(start: 1, end: 2), $$, $$, $-1$,
      hlinex(start: 1, end: 5),
      $- u^2 + a^2$, $u^2$, $+ 0 u$, $+0$, 
      [], $-(u^2 $, $+ 0u$, $- a^2)$,
      [], [], [], $ a^2$,
    )
    ]
    Rewriting:
    $
      & - int u^2/(a^2 - u^2) du \
      & = - int -1 +  a^2 / (a^2 - u^2) du \
      // & = - int -1 +  a^2 / (a^2 - u^2) du \
      & = - ( -u + int a^2 / (a^2 - u^2) du )  \
      & = u - int a^2 / (a^2 - u^2) du   \
    $

    Followed by some partial fractions: 
    $
      a^2 /( a^2 - u^2) = a^2 / ( (a + u) (a - u)) = A / (a + u) + B /(a - u) \
      A(a - u) + B(a + u) = a^2 \
      A a - A u + B a + B u = a^2 \
    $
    $
      A a + B a = a^2 & wide - A u + B u = 0 u \
            A + B = a & wide - A + B = 0 \
               2B = a & wide B = A \
            B = a/2 & wide A = a/2 \
    $
    So we can rewrite:
    $
      & = u - int a^2 / (a^2 - u^2) du \
      & = u - int (a/2) / (a + u) + (a/2) /(a - u) du \
      & = u - ( a/2lna(a + u) - a/2lna(a - u)) + C \
      & = u - a/2lna(a + u) + a/2lna(a - u)) + C 
    $
    // Then we can do one more u-sub: 
    // $
    //   p = u \ 
    //   dp = (1/2)u^(-1/2)
    // $
    Therefore:
    $
      integral 1/x sqrt(a^2 - x^2) dx = sqrt(a^2 - x^2) - a/2lna(a + sqrt(a^2 - x^2)) + a/2lna(a - sqrt(a^2 - x^2)) + C 
    $

    *Now to do it with trigonometric substitution:*
    $
      & integral 1/x sqrt(a^2 - x^2) dx \
      & = integral 1/x sqrt(a^2 - x^2) dx wide x = a sin th wide dx = a cos th dth wide th = arcsin(x / a) \
      & =int 1/(a sin th)sqrt(a^2 - (a sin th)^2) a cos th dth \
      & =int (cos th) /( sin th)sqrt(a^2 - (a^2 sin^2 th)) dth \
      & =int (cos th) /( sin th)sqrt(a^2 - (a^2 - a^2cos^2 th)) dth wide "using" sin^2 th = 1 - cos^2 th \
      & =int (a cos^2 th) /( sin th) dth \
      & = a int ( 1 - sin^2 th) /( sin th) dth wide "using" cos^2 th = 1 - sin^2 th \
      & = a int 1/( sin th) - sin th dth \
      & = a cos th + a int 1/( sin th) dth \
      // & = - a cos th + a int 1/( sin th) dth \
    $
    The integral of $1/(sin th)$ can be done separately:
    $
      int 1/( sin th) dth & = int (sin th )/( sin^2 th) dth \
                          & = int (sin th )/( 1 - cos^2 th) dth wide "using" sin^2 th = 1 - cos^2 th \
                          & = int (sin th )/( 1 - cos^2 th) dth wide u = cos th wide du = - sin th \
                          & = - int (1) / (1 - u^2) du \
    $
    This becomes a partial fractions:
    $
      1 /( 1 - u^2) = 1 / ( (1 + u) (1 - u)) = A / (1 + u) + B /(1 - u) = 1\
      A(1 - u) + B(1 + u) = 1 \
      A - A u + B + B u = 1 \
    $
    $
      A + B = 1 & wide -A u + B u = 0 u \
      A + A = 1 & wide A = B \
        A = 1/2 & wide B = 1/2 \
    $

    So we can rewrite:
    $
      int 1/( sin th) dth & = - int (1/2) / (1 + u) + (1/2) /(1 - u) dth \
                          & = - (1/2 lna(1 + u) - 1/2 lna(1 - u)) + C \
                          & = -1/2 lna(1 + cos(theta)) + 1/2 lna(1 - cos(theta)) + C \
    $
    Returning to our original integral:
    $
      & integral 1/x sqrt(a^2 - x^2) dx \
      & = a cos th + a int 1/( sin th) dth \
      & = a cos th + a (- 1/2 lna(1 + cos(theta)) + 1/2 lna(1 - cos(theta)) + C) \
    $
    Therefore:
    $
      integral 1/x sqrt(a^2 - x^2) dx = a cos (arcsin(x / a)) + a (-1/2 lna(1 + cos((arcsin(x / a)))) + 1/2 lna(1 - cos((arcsin(x / a)))) + C)
    $

    However, this can be simplified. As we know: 
    $
      cos^2 th + sin^2 th = 1 \ 
      cos th = sqrt(1 - sin^2 x) \ 
    $
    Since $th = arcsin(x / a) $: 
    $
      cos (arcsin(x / a)) &= sqrt(1 - sin^2 (arcsin(x / a))) \ 
       &= sqrt(1 - (x / a)^2) \ 
      cos (arcsin(x / a)) &= sqrt(1 - x^2 / a^2) \ 
    $

    Plugging this into our expression: 

    $
      integral 1/x sqrt(a^2 - x^2) dx &= \
      &= a cos (arcsin(x / a)) + a (-1/2 lna(1 + cos((arcsin(x / a)))) + 1/2 lna(1 - cos((arcsin(x / a)))) + C) \

      &= a sqrt(1 - x^2 / a^2) + a (-1/2 lna(1 + sqrt(1 - x^2 / a^2) ) + 1/2 lna(1 - sqrt(1 - x^2 / a^2))) + C \ 

      &= sqrt(a^2( 1 - x^2 / a^2)) - a (1/2 lna(1 + sqrt(1 - x^2 / a^2) ) + 1/2 lna(1 - sqrt(1 - x^2 / a^2))) + C \ 
    $

    Now we can do some rearranging and logarithm shenanigans: 

    $
    integral 1/x sqrt(a^2 - x^2) dx &= sqrt(a^2 - x^2) + a/2 ( -lna(1 + sqrt(1 - x^2 / a^2) ) + lna(1 - sqrt(1 - x^2 / a^2))) + C \ 

      &= sqrt(a^2 - x^2) + a/2 ( -lna(1 + sqrt(1 - x^2 / a^2) ) + lna(1 - sqrt(1 - x^2 / a^2)) + lna(a) - lna(a)) + C \ 

      &= sqrt(a^2 - x^2) + a/2 ( (-lna(1 + sqrt(1 - x^2 / a^2) ) + lna(a)) + ( lna(1 - sqrt(1 - x^2 / a^2)) + lna(a) ) ) + C \ 

      &= sqrt(a^2 - x^2) + a/2 ( -lna(a(1 + sqrt(1 - x^2 / a^2))))  + lna(a(1 - sqrt(1 - x^2 / a^2))) ) + C \ 

      &= sqrt(a^2 - x^2) + a/2 ( -lna(a + sqrt(a^2 - x^2))  + lna(a - sqrt(a^2 - x^2 )) ) + C \ 

      integral 1/x sqrt(a^2 - x^2) dx &= sqrt(a^2 - x^2) -  a/2 lna(a + sqrt(a^2 - x^2))  + a/2 lna(a - sqrt(a^2 - x^2 )) + C \ 
    $
    * Comparing the two results:*

    Result 1: 
    $
      integral 1/x sqrt(a^2 - x^2) dx = sqrt(a^2 - x^2) - a/2lna(a + sqrt(a^2 - x^2)) + a/2lna(a - sqrt(a^2 - x^2)) + C 
    $
    Result 2: 
    $
      integral 1/x sqrt(a^2 - x^2) dx &= sqrt(a^2 - x^2) -  a/2 lna(a + sqrt(a^2 - x^2))  + a/2 lna(a - sqrt(a^2 - x^2 )) + C \
    $

    Result 1 is the same as result 2, therefore the method that you take to solve this integral does not impact the result. 

+ #p[
    In tutorial, we looked at metapopulations and the Levins model derived by Richard Levins in 1969 which describes metapopulations as a means for studying spatially structured populations. In particular, the model tracks the proportion of patches that are occupied by the population, but does not track the density of the population nor which specific patches are inhabited. These subpopulations are modelled through the Levins model
    $
      (dif p)/ (dif t) = c p (1 - p) - m p
    $
    where $p = p(t)$ is the fraction of patches occupied, $m > 0$ is the mortality of a subpopulation, and $c > 0$ is the colonization of a vacant subpopulation. Recall that vacant patches can be colonized at a rate proportional to the fraction of occupied patches as $1 - p$.]

  + #p[Set $m = 1$ and $c = 3$.]
    + #p[Algebraically solve, using an appropriate integration technique, the Levins model and determine the long term behaviour (i.e., equilibria). Be sure to include all steps in your solution.]
      Setting $m = 1$ and $c = 3$:
      $
        (dif p)/ (dif t) & = 3 p (1 - p) - (1) p \
                         & = 3 p - 3 p^2 - p \
        (dif p)/ (dif t) & = - 3 p^2 + 2 p
      $
      Integrating:
      $
        int 1 / (- 3 p^2 + 2 p) dp = int 1 dt \
        t = int 1 / ( p (- 3 p + 2)) dp
      $
      Using partial fractions:
      $
        1 / ( p (- 3 p + 2)) = A / p + B/ (- 3 p + 2)
      $
      $
        A (- 3 p + 2) + B p = 1 \
        -3p A + B p = 0 wide 2A = 1 \
        -3A + B = 0 wide A = 1/2 \
        B = 3A wide B = 3/2
      $

      So our integral becomes:
      $
        t = int (1/2) / p + (3/2)/ (- 3 p + 2) dp \
        #todo[This just becomes a very nice u-sub, however I ran out of time.]
        t = int (1/2) (1 / p) + ((-1/2) / ( p + 2/(-3))) dp \

        t = (1/2) ( lna( p )) - (1/2) lna(  p - 2/(3)) + C \

        t = (1/2) ( lna( p )) - (1/2) lna(  p) lna(- 2/(3)) + C \
        t = (1/2) ( lna( p )) ( 1 - lna(2/(3))) + C \
        e ^ t = e^( (1/2) ( lna( p )) ( 1 - lna(2/(3))) ) + C \
        e ^ t = abs(p) ^( (1/2)( 1 - lna(2/(3))) ) + C \
      $

      Population is always greater than 0, so we can rewrite $abs(p) = p$: 

      $
        p = (e^t) ^ (1/ ( e^(1/2) e^( 1 - lna(2/(3))) )) + C \
      $
      // Solving for $p$: 
      // $
      //   t =  ln(abs(p) ^ (1/2) ) +  ln(  abs( p - 2/(3)) ^ (-9/2)) + C \
      //   e^t =  e^ln(abs(p) ^ (1/2) )e^(ln(  abs( p - 2/(3)) ^ (9/2))) + C \
      //   e^t =  abs(p) ^ (1/2) abs( p - 2/(3)) ^ (9/2) + C \
      //   $
      //   For all $p > 2/3$: 
      //   $
      //   p > 0 \ 
      //   p - 2/(3) >= 0 \ 

      //   e^t =  p^(1/2) ( p - 2/(3)) ^ (9/2) + C \
      // $
      // $
      //   therefore t = 1/2 lna(p) - 1/2lna(-3p + 2) + C \
      // $


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
                    Gamma(1) & = int_0^infinity t^(1-1)e^(-t) dif t \
                             & = int_0^infinity (1)e^(-t) dif t \
                             & = lim_(T -> inf) int_0^T e^(-t) dif t \
                             & = lim_(T -> inf) lr(-e^(-t) |)_0^T \
                             & = lim_(T -> inf) -e^(-T) - (-e^(-0) ) \
                             & = lim_(T -> inf) (-e^(-T)) + 1 \
                             & = 0 + 1 \
      therefore Gamma(1) &= 1
      //
      //  & = int_0^1 e^(-t) dt + int_1^infinity e^(-t) dt\
      //  & = - int_1^0 e^(-t) dt + int_1^infinity e^(-t) dt\
      //  & = lim_(R -> 0) ( - int_1^R e^(-t) dt) + lim_(T -> inf)  ( int_1^infinity e^(-t) dt) \
      //  & = - lim_(R -> 0) (lr(-1/t e^(-t) |)_1^R)  + lim_(T -> inf)  (lr(-1/t e^(-t) |)_1^T) \
      //  & = - lim_(R -> 0) (-1/R e^(-R) - (-1)/1 e^(-1)) + lim_(T -> inf) (-1/T e^(-T) - (-1)/1 e^(-1))  \
      //  & = - lim_(R -> 0) (-e^(-R)/R ) cancel(- e^(-1)) + lim_(T -> inf) (- e^(-T)/T) + cancel(e^(-1) )  \
      //  & = - lim_(R -> 0) (-e^(-R)/R )  + lim_(T -> inf) (- e^(-T)/T)  \
      //          & = lim_(T -> inf) int_0^T e^(-t) dif t \
      //          & = lim_(T -> inf) lr(-1/t e^(-t) |)_0^T  = \
      //          & = lim_(T -> inf) lr(-1/t e^(-t) |)_0^T  \
      // // Gamma(1) &= - e^(-t) + C wide "where C is a constant"
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
    $
      Gamma(x + 1) & = int_0^infinity t^((x + 1)-1)e^(-t) dif t \
                   & = lim_(T->inf) int_0^T t^x e^(-t) dt \
    $
    Using integration by parts:
    $
      u = t^x wide dv = e^(-t) dt \
      du = x t^(x - 1) dt wide v = -e^(-t) \
    $
    $
      Gamma(x + 1) & = lim_(T->inf) ( lr(- t^x e^(-t)|)_0^T - int_0^T - e^(-t) x t^(x - 1) dt ) \
            
                   & = lim_(T->inf) (  - T^x e^(-T) - (-(0)^x e^(-0))  ) + lim_(T->inf) ( x int_0^T e^(-t) t^(x - 1) dt ) \
                   & = lim_(T->inf) (  - T^x  / e^(T)) + x lim_(T->inf) ( int_0^T e^(-t) t^(x - 1) dt ) \
                   
    $

    If $x > 1$, we can apply L'Hopital's rule and differentiate both sides of the quotient. And noting that $lim_(T -> inf) int_0^T f(x) dx = int_0^inf f(x) dx $, we can rewrite: 
    $
      Gamma(x + 1) & = lim_(T->inf) (  - (x T^(x-1) ) / e^(T)) + x int_0^inf e^(-t) t^(x - 1) dt  \
    $

    If $x>2$ we can do L'Hopital's rule again to give us: 
    $
      Gamma(x + 1) & = lim_(T->inf) (  - (x (x - 1) T^(x-2) ) / e^(T)) + x int_0^inf e^(-t) t^(x - 1) dt  \
    $

    For any $x$, do L'Hopital's rule $x$ times, giving you: 
    $
      Gamma(x + 1) & = lim_(T->inf) (  - (x (x - 1) (x - 2) (x - 3) (...) T^(x-x) ) / e^(T)) + x int_0^inf e^(-t) t^(x - 1) dt  \
    $

    Noting that $x (x - 1) (x - 2) (x - 3) (...)$ exactly $x$ times is equal to $x!$, and $x!$ is finite: 

    $
      Gamma(x + 1) & = lim_(T->inf) (  - (x! T^(0) ) / e^(T)) + x int_0^inf e^(-t) t^(x - 1) dt  \
      & = lim_(T->inf) (  - ( x! ) / e^(T)) + x int_0^inf e^(-t) t^(x - 1) dt  \
      & = lim_(T->inf) (  - ( x! ) / e^(T)) + x int_0^inf e^(-t) t^(x - 1) dt  \
      & = 0 + x int_0^inf e^(-t) t^(x - 1) dt  \
    $

    Therefore: 
    $
      Gamma(x + 1) & = x ( int_0^inf e^(-t) t^(x - 1) dt)  \ 
    $

    Since we know that: 
    $
      Gamma(x ) & = int_0^inf t^(x - 1) e^(-t) dt 
    $

    We have shown that: 

    $
      Gamma(x + 1) & = x Gamma(x )  \ 
    $


  // If $x = -1$:
  // $
  //    Gamma(x + 1) &= int_0^infinity t^x e^(-t) dif t \
  // $



  + #p[Using the fact that $int_0^infinity e^(-t^2) dif t = sqrt(pi)/ 2$, compute $Gamma (1/2)$. Hint: Make a substitution. ]
    $
      Gamma(1/2) & = int_0^infinity t^((1/2)-1)e^(-t) dif t \
                 & = int_0^inf e^(-t) / sqrt(t) dif t wide u = sqrt(t) wide du = (1/2) t^(-1/2) dt wide t = u^2 \
                 & = int_0^inf (2) e^(-u^2) dif u \
                 & = 2 int_0^inf e^(-u^2) dif u \
    $
    Given $int_0^infinity e^(-t^2) dif t = sqrt(pi)/ 2$:
    $
      Gamma(1/2) & = 2 int_0^inf e^(-u^2) dif u = 2 (sqrt(pi)/ 2)
    $
    $
      therefore Gamma(1/2) = sqrt(pi)
    $


  + #p[Find $Gamma(3/2)$.]

    In question b we showed that $Gamma(x + 1) = x Gamma(x)$ for $x > 0$, and in question c we found that $Gamma(1/2) = sqrt(pi)$. So we can express our problem to take advantage of this:
    $
      Gamma(3/2) = Gamma(1/2 + 1) = 1/2Gamma(1/2) = (1/2)sqrt(pi)
    $
    Therefore:
    $
      Gamma(3/2) = sqrt(pi)/2
    $
// $
//   Gamma(3/2) & = int_0^infinity t^((3/2)-1)e^(-t) dif t \
//              & = int_0^inf e^(-t) sqrt(t) dif t wide u = sqrt(t) wide du = (1/2) t^(-1/2) dt wide t = u^2 \
//   //  & = int_0^inf (2) e^(-u^2) dif u \
//   //  & = 2 int_0^inf e^(-u^2) dif u \
// $


// #todo("Content taught after reading break. ")

#p[
  _Remark:_ Using the recurrence relation in (b), it can be proved that $Gamma(n + 1) = n!$ when $n$ is a positive integer. (Recall that the factorial is defined as $n! = n ·(n -1) ·... ·3 ·2 ·1$, but this formula is only valid when n is a natural number.)

  In view of this property,$Gamma(x + 1)$ is often written as $x!$ and regarded as an extension of the factorial function to real numbers. Some scientific calculators with the factorial function $n!$ built in actually calculate the gamma function rather than the simpler formula of products of integers. Check whether your calculator does this by asking it for $0.5!$. If you get an error message, it is not using the gamma function. If you get a numerical value, compare it with your answer in (c).
]



