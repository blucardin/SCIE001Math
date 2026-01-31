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

    // #todo("Include a proof by FTC")
    *True*

    Taking the derivative of both sides:
    $
      dif/(dif x) F(x) = dif/(dif x) int_0^x f(t) dif t
    $
    By the Fundamental Theorem of Calculus:
    $
      dif/(dif x) F(x) = f(x)
    $

    We know $f(x)$ exists for all $x$, therefore $dif/(dif x) F(x)$ must exist for all $x$, hence $F(x)$ is differentiable for all $x$. Since differentiability implies continuity $F(x)$ must therefore be continuous for all $x$.

    Therefore $F(x)$ is continuous for all $x$.

    *A different proof is given below for fun.*


    For $F(x)$ to be continuous for all $x$:
    $
      lim_(a->x) F(a) = F(x)
    $
    Therefore we must prove:
    $
      lim_(a->x) int_0^a f(t) dif t = int_0^x f(t) dif t \
    $
    To do this, we can show that we can rearrange the left side to equal the right side.

    Expanding the left integral to a Riemann Sum gives:
    $
      lim_(a->x) (lim_(n->infinity) sum_(i=1)^n (a-0)/n f(i(a-0)/n +0) )\
      =lim_(a->x)( lim_(n->infinity) sum_(i=1)^n (a)/n f(i a/n ))
    $
    Since we know $f(x)$ is differentiable, it must also be continuous, as differentiability implies continuity. For any $n in RR, n !=0$, $a/n$ is continuous for all $a$. Consequently, for any $i in RR$:
    $
      (a)/n f(i a/n )
    $
    is also continuous for all $a$.

    The sum of any continuous functions is also continuous. Therefore:
    $
      sum_(i=1)^n (a)/n f(i a/n )
    $
    is continuous for all $a$. More precisely, this expression is continuous for all $a$ independently of the value of $n$. Therefore,

    $
      lim_(n->infinity) sum_(i=1)^n (a)/n f(i a/n )
    $

    is continuous for all $a$.


    So, we can rewrite our limit:
    $
      & lim_(a->x)( lim_(n->infinity) sum_(i=1)^n (a)/n f(i a/n )) \
      & =lim_(n->infinity) sum_(i=1)^n (x)/n f(i x/n ) \
      // &=  int_0^x f(t) dif t
    $

    Summarizing with integral notation:
    $
      lim_(a->x) int_0^a f(t) dif t =lim_(a->x)( lim_(n->infinity) sum_(i=1)^n (a)/n f(i a/n )) = lim_(n->infinity) sum_(i=1)^n (x)/n f(i x/n ) = int_0^x f(t) dif t\
    $

    // #todo("Add to the right that theis expession is euqal to the limit of F(x), and to the left that this is equal to F(x)")


    So:
    $
      lim_(a->x) int_0^a f(t) dif t = int_0^x f(t) dif t \
      lim_(a->x) F(a) = F(x)
    $
    Therefore $F(x)$ is continuous for all $x$.


  + #p[The function $F(x)$ is not twice differentiable. ]
    *False*

    We know:
    $
      F(x) = int_0^x f(t) dif t
    $

    Taking the derivative of both sides:
    $
      dif/(dif x) F(x) = dif/(dif x) int_0^x f(t) dif t
    $
    By the Fundamental Theorem of Calculus:
    $
      dif/(dif x) F(x) = f(x)
    $

    Taking a second derivative:
    $
      dif^2/(dif x^2) F(x) = dif/(dif x) f(x)
    $

    By definition, $f$ is differentiable for all $x$, hence $dif/(dif x) f(x)$ exists for all $x$, therefore $dif^2/(dif x^2) F(x)$ exists for all $x$.

    Therefore $F(x)$ is twice differentiable.

  + #p[The value x = 1 is a critical point of $F$.]

    *True*

    By definition, for $x = 1$ to be a critical point of $F$:
    $
      dif/(dif x) F(1) = 0
    $

    From part b we know:

    $
      dif/(dif x) F(x) = f(x)
    $

    And by definition we know:
    $
      f(1) = 0.
    $

    Hence:
    $
      dif/(dif x) F(1) = f(1) = 0
    $

    Therefore, $F(x)$ has a critical point at $x = 1$.


  + #p[The function $F(x)$ takes on a local minimum at $x = 1$. ]

    *True*

    From part b we know:

    $
      dif^2/(dif x^2) F(x) = dif/(dif x) f(x)
    $

    And by definition, $f prime (x) > 0$ for all $x$. Hence:
    $
      dif^2/(dif x^2) F(x) = f prime (x) > 0 \
      dif^2/(dif x^2) F(x) > 0
    $

    Therefore, $F(x)$ is concave up for all $x$.

    From part c we know $F(x)$ has a critical point at $x = 1$.

    By the second derivative test, if a function has a critical point at $x = c$ and is concave up for all $x$ including $x = c$, it must therefore have have a local minima at $x = c$.

    // This is because, by contradiction, if the function has a local maximum, or no extrema at $x = c$, either it must have some point where it is concave down, or it would not have a critical point at $x = c$.

    Therefore $F(x)$ has a local minimum at $x = 1$.

  + #p[$F(1) > 0$.]

    *False*

    #todo("Add a proof by intuition showing that since f(x) is always increasing and f(1) = 0, for all x < 1, f(x) < 0, therefore its integral up to one should be below 0")

    Proof by counterexample.

    Let $f(x) = x - 1$. This satisfies our definition. $f$ is differentiable.
    $
      f(1) = 1 - 1 = 0 \
      f prime (x) = 1 > 0
    $
    Setting:
    $
      F(x) = int_0^x f(t) dif t = int_0^x t - 1 dif t
    $
    We can solve:
    $
      F(x) = 1/2x^2 - x
    $

    $
      F(1) = 1/2(1)^2 - (1) = -0.5
    $

    Therefore there exists at least one example of some $f(x)$ for which $F(1) < 0$, so the statement $F(1) > 0$ is false.

    *Another proof is included for fun below. *

    Since by definition: 
    $
      F(x) = int_0^x f(t) dif t
    $
    $F(x)$ represents the signed area under the curve of $f(t)$ from $t=0$ to $t = x$. 

    We know that $f'(t) > 0$ for all $t$, therefore $f(t)$ is always increasing as $t$ approaches $infinity$. 

    We also know, $f(1) = 0$. 
    
    If a function is always increasing as $t$ approaches $infinity$, it must be always decreasing as $t$ approaches $-infinity$. 
    As a result for all $x < t$: 
    $
      f(x) < f(t)
    $
    
    Therefore, for all $x < 1$, $
    f(x) < f(1) = 0\ 
    f(x) < 0
    $

    Since the area under a curve below $0$ is negative, and all sections of $f(x)$ are negative for all $x < 1$ (and at $x = 1, f(x) = 0$). It is intuitive that the area under the curve of $f(t)$ from $t=0$ to $t=1$ should be negative. 

    Therefore: 
    $
      0 > int_0^1 f(t) dif t = F(1) \
      therefore F(1) < 0
    $


  // *Lemma 1: If a continuous function has a critical point at $x = 1$ and is concave up for all $x$, it must therefore take a global minimum at $x = 1$. *

  // Recall by the Fundamental Theorem of Calculus:
  // $
  // f(x) = dif/(dif x) F(x)
  // $

  // If the function $F(x)$ is concave up for all $x$, its derivative is always increasing. More precisely:
  // $
  //   dif/(dif x) f(x) > 0 \
  // $

  // Since part a showed $F(x)$ is a continuous function, local extrema can only form at a critical point - when:
  // $
  //   f(x) = 0 \
  // $

  // For our function, this occurs at $x = 1$:
  // $
  //   f(1) = 0
  // $

  // Proof by contradiction, assume there is a point $x = c_2$ which is some other local extrema. So we have:

  // $
  //   f(1) = 0 \
  //   f(c_2) = 0 \
  // $

  // By Rolle's Theorem there must exist some number $p in (1, c_2)$ (or $p in (c_2, 1)$ if $c_2 < 1$) such that:
  // $
  //   dif/(dif x) f(p) = 0
  // $

  // However, this contradicts the definition of $f(x)$ such that $dif/(dif x) f(x) > 0$.

  // Hence, $F(x)$ can have no other local extrema, and therefore takes a global minimum at $x = 1$.

  // With *Lemma 1*, we know that for all $u != 1$:
  // $
  //   F(u) > F(1)
  // $

  // Starting with our definition of $F(x)$, we can decompose the integral
  // $
  //   F(x) &= int_0^x f(t) dif t \
  //   &= int_0^1 f(t) dif t + int_1^x f(t) dif t \
  //   &= int_0^1 f(t) dif t + int_0^x f(t) dif t - int_0^1 f(t) dif t \
  //   &= F(1) + F(x) - F(1)

  // $


  #p[Based on your answers above, make a rough sketch of the graph of $F(x)$. ]

  As in part c, let $f(x) = x - 1$. This satisfies our definition. $f$ is differentiable.
  $
    f(1) = 1 - 1 = 0 \
    f prime (x) = 1 > 0
  $
  Setting:
  $
    F(x) = int_0^x f(t) dif t
  $
  We can solve:
  $
    F(x) = 1/2x^2 - x
  $


  #let fn = (
    ($ F(x) = int_0^x t - 1 dif t $, x => (((1 / 2) * x * x) - x), (stroke: red)),
  )

  #align(center)[#canvas({
    import draw: *

    // Set-up a thin axis style
    set-style(
      axes: (stroke: .5pt, tick: (stroke: .5pt)),
      legend: (stroke: none, orientation: ttb, item: (spacing: .3), scale: 80%),
    )

    plot.plot(
      size: (8, 8),
      x-label: "x",
      y-label: "y",
      x-tick-step: 1,
      y-tick-step: 1,
      axis-style: "school-book",
      // x-format: plot.formats.multiple-of,
      // y-tick-step: 0.25,
      // y-min: -30, y-max: 30,
      legend: "inner-north",
      {
        let domain = (-2, 4)

        for (title, f, style) in fn {
          plot.add(f, domain: domain, style: style, label: title, samples: 50)
        }

        // let domain = (2.06, 5)
        // let s = 0.1;

        // for ((title, f, style)) in fn {
        //   plot.add(f, domain: domain,
        //     style: style, label: none,
        //   samples: 500)
        // }
      },
    )
  })]

  #todo("Include a hand-drawn sketch")

  #colbreak()

+ #p[Recall in class we proved that $display(sum_(i = 1)^k i = (k(k+1))/2)$. In this problem, we will construct a proof of #block($display(S = sum_(i = 1)^k i^2)$)]

  + #p[Calculate the value of $S$ for $k = 1,2,3$ and $4$.]
    $
      S_(k=1) &= sum_(i = 1)^1 i^2 = 1^2 &= 1 \
      S_(k=2) &= sum_(i = 1)^2 i^2 = 1^2 + 2^2 &= 5 \
      S_(k=3) &= sum_(i = 1)^3 i^2 = 1^2 + 2^2 + 3^2 &= 14 \
      S_(k=4) &= sum_(i = 1)^4 i^2 = 1^2 + 2^2 + 3^2 + 4^2 &= 30 \
    $

  + #p[Calculate the value of $display((k(k+1)(2k+1))/6)$ for $k = 1, 2, 3$, and $4$]

    $
      #for n in (1, 2, 3, 4) [
        $ & k = #n wide (#n (#n+1)(2(#n)+1))/6 = #{ (n * (n + 1) * (2 * (n) + 1)) / 6 } $ \
      ]
    $


  + #p[Show that $display(sum_(i = 1)^k i^2 = (k(k+1)(2k+1))/6)$ by constructing a proof by induction by:
      + showing the equality is true for the base case (i.e., $k=1$).
      + for each positive integer $N$, the equality holds for $k = N$ implies the equality for $k = N + 1$.

        Be sure to end your proof with an appropriate conclusion statement (i.e., "Therefore, by induction, ...").
    ]

    * Lemma 1 :   $display(sum_(i = 1)^k i^2 = (k(k+1)(2k+1))/6)$ holds for $k = 1$. *

    $
                      "Left Hand" & wide "Right hand" \
      sum_(i = 1)^1 i^2 = 1^2 = 1 & wide (1(1+1)(2(1)+1))/6 = #{
                                      let n = 1
                                      (n * (n + 1) * (2 * (n) + 1)) / 6
                                    } \
    $

    $
      therefore & sum_(i = 1)^1 i^2 = (1(1+1)(2(1)+1))/6 \
    $

    Therefore $display(sum_(i = 1)^k i^2 = (k(k+1)(2k+1))/6)$ holds for $k = 1$.

    * Lemma 2 :  For each positive integer $N$, the equality holding for $k = N$ implies the equality for $k = N + 1$. *

    Let $display(f(x) = sum_(i = 1)^x i^2)$.  #h(4em) Let $display(g(x) = (x(x+1)(2x+1))/6)$

    Let $n$ be some positive integer such that the equality $display(sum_(i = 1)^n i^2 = (n(n+1)(2n+1))/6)$ holds. Therefore $f(n) = g(n)$

    Consider $f(n + 1)$.
    $
      f(n + 1) & = sum_(i = 1)^(n + 1) i^2 = (sum_(i = 1)^(n) i^2 ) + (n + 1)^2 \
        f(n+1) & = f(n) + (n + 1)^2 // &= f(n) + (n^2 + 2n + 1)
    $
    Then consider $g(n + 1)$.
    $
      g(n + 1) & = ((n + 1)((n + 1)+1)(2(n + 1)+1))/6 \
               & = ((n + 1)(n + 2)(2n + 3))/6 \
      // &= ((n + 1)(2n^2 + 3n + 4n + 6))/6 \
      // &= ((n + 1)(2n^2 + 7n + 6))/6 \
      // &= ((2n^3 + 7n^2 + 6n + 2n^2 + 7n + 6))/6 \
               & = ((2n^3 + 9n^2 + 13n + 6))/6 \
               & = ((2n^3 + 3n^2 + 1n) + (6n^2 + 12n + 6))/6 \
               & = (n(2n^2 + 3n + 1))/6 + (n^2 + 2n + 1) \
      // &= (n(2n^2 + 3n + 1))/6 + (n + 1)^2 \
      // &= (n(2n(n + 1) + 1(n + 1)))/6 + (n + 1)^2 \
               & = (n(2n + 1)(n + 1))/6 + (n + 1)^2 \
               & = g(n) + (n + 1)^2
    $
    Putting them together, by definition
    $
      f(n) = g(n) \
      f(n) + (n + 1)^2 = g(n) + (n + 1)^2 \
      therefore f(n + 1) = g(n + 1)
    $

    Therefore for every $N in ZZ^+$, $f(N) = g(N)$ implies that $f(N + 1) = g(N + 1)$. i.e  the equality holding for $k = N$ implies that it holds for $k = N + 1$

    \

    Therefore by induction, since $display(sum_(i = 1)^k i^2 = (k(k+1)(2k+1))/6)$ holds for $k = 1$ and this equality holding for $k = N$ implies that it holds for $k = N + 1$ provided that $N in ZZ^+$:

    $ S = sum_(i = 1)^k i^2 = (k(k+1)(2k+1))/6 $
    holds for all $k in ZZ^+$





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
      abs(int_a^b f(x) dif x - (b-a)/N sum^N_(k=1) (f(x_k) + f(x_(k-1)) ) / 2,) <= (b-a)^3 / (12 N^2)K_2
    $

    where $K_2$ is any number such that $abs(f prime prime (x)) <= K_2$ for all $x in [a,b]$.

    Consider the #link("https://en.wikipedia.org/wiki/Fresnel_integral")[Fresnel integral]

    $
      int_0^sqrt(pi/2) sin(x^2) dif x
    $]

  + #p[Write out and calculate the Left and Right Riemann sums for $N = 4$.]

    *Left Riemann Sum*
    $
      int_0^sqrt(pi/2) sin(x^2) dif x approx sum_(k = 1)^N sin(((k-1) Delta x )^2) Delta x \
      = sum_(k = 1)^4 sin(((k-1) ((sqrt(pi/2))/4) )^2) ((sqrt(pi/2))/4) = \
      =
      #for k in (1, 2, 3, 4) [
        $ sin(( (#{ k - 1 } sqrt(pi/2))/4)^2) ((sqrt(pi/2))/4) #{ if k != 4 [$+$

        ] } $
      ]\
      =
      #{
        let sum = 0
        for k in (1, 2, 3, 4) {
          sum = sum + calc.sin(calc.pow(((k - 1) * calc.sqrt(calc.pi / 2)) / 4, 2)) * ((calc.sqrt(calc.pi / 2)) / 4)
        }
        sum
      }
    $

    *Right Riemann Sum*
    $
      int_0^sqrt(pi/2) sin(x^2) dif x approx sum_(k = 1)^N sin(x_k^2) Delta x \
      = sum_(k = 1)^4 sin((k ((sqrt(pi/2))/4) )^2) ((sqrt(pi/2))/4) = \
      =
      #for k in (1, 2, 3, 4) [
        $ sin(( (#k sqrt(pi/2))/4)^2) ((sqrt(pi/2))/4) #{ if k != 4 [$+$

        ] } $
      ]\
      =
      #{
        let sum = 0
        for k in (1, 2, 3, 4) {
          sum = sum + calc.sin(calc.pow((k * calc.sqrt(calc.pi / 2)) / 4, 2)) * ((calc.sqrt(calc.pi / 2)) / 4)
        }
        sum
      }
    $


  + #p[Write our and calculate the Trapezoid rule for $N = 4$.]

    $
      int_a^b sin(x^2) dif x approx Delta x sum^N_(k=1) (sin(x_k^2) + sin(x_(k-1)^2) ) / 2 \
      = ((sqrt(pi/2))/4) sum^4_(k=1) (sin((k((sqrt(pi/2))/4))^2) + sin(((k-1)((sqrt(pi/2))/4))^2) )/2 \
      // = ((sqrt(pi/2))/4) sum^4_(k=1) (sin(((k sqrt(pi/2))/4)^2) + sin((((k-1) sqrt(pi/2))/4)^2) )
      =((sqrt(pi/2))/4) (
        #for k in (1, 2, 3, 4) [
          $ (sin(( ( #k sqrt(pi/2))/4)^2) + sin((((#k -1) sqrt(pi/2))/4)^2))/2
          #{ if k != 4 [
            $+ \ $
          ] } $
        ]
      ) \
      =
      #{
        let sum = 0
        for k in (1, 2, 3, 4) {
          sum = sum + (calc.sin(calc.pow((k * calc.sqrt(calc.pi / 2)) / 4, 2)) + calc.sin(calc.pow(((k - 1) * calc.sqrt(calc.pi / 2)) / 4, 2))) / 2
        }
        sum = sum * ((calc.sqrt(calc.pi / 2)) / 4)

        sum
      }
    $

  + #p[Find an appropriate value of $K_2$ for the Fresnel integral. Be sure to justify your answer.]

    By definition "$K_2$ is any number such that $abs(f prime prime (x)) <= K_2$ for all $x in [a,b]$."

    In our case, $f(x) = sin(x^2)$ and $a = 0, b = sqrt(pi/2)$. Therefore, we must bound $f prime prime (x)$ on $[0, sqrt(pi/2)]$:
    $
      // dif /(dif x) sin(x^2) &= 2x cos(x^2) \
      f prime prime (x) = dif^2/(dif x^2) sin(x^2) = dif /(dif x) 2x cos(x^2) = 2cos(x^2) - 4x^2 sin(x^2)\
    $

    // Using the Triangle Inequality:
    // $
    //   abs(2cos(x^2) - 4x^2 sin(x^2)) <= abs(2cos(x^2)) + abs(- 4x^2 sin(x^2))
    // $
    // Therefore:
    // $
    //   abs(f prime prime (x)) <= abs(2cos(x^2)) + abs(- 4x^2 sin(x^2))
    // $
    // We can improve this by noting that $x > 0$ for all $x in [0, sqrt(pi/2)]$:
    // $
    //   abs(f prime prime (x)) <= abs(2cos(x^2)) + 4x^2abs(sin(x^2))
    // $

    // $
    //   abs(2cos(x^2)) <= 2  wide abs(sin(x^2)) <= 1
    // $
    // For $4x^2$ we can look at critical points and endpoints:
    // $
    //   dif/(dif x) 4x^2 = 8x \
    //   8x = 0  \
    //   x = 0  \

    // $
    // So only one critical point at $x = 0$.
    // Evaluating,
    // $
    // 4(0)^2 = 0 \
    // 4(sqrt(pi/2))^2 = 2pi > 0
    // $
    // Therefore $max(4x^2)$ for all $x in [0, sqrt(pi/2)]$ is $2pi$.

    // So:
    // $
    //   abs(f prime prime (x)) <= abs(2cos(x^2)) + 4x^2abs(sin(x^2)) \
    //   abs(f prime prime (x)) <= 2 + 2pi
    // $

    // So we can set a good bound:

    // $
    //   K_2 = 2 + 2pi
    // $



    // For $abs(- 4x^2 sin(x^2))$ we can evaluate at endpoints:
    // $
    //   abs(- 4(0)^2 sin(0^2)) = 0 \
    //   abs(- 4(sqrt(pi/2))^2 sin(sqrt(pi/2)^2)) = 2pi
    //   dif /(dif x) (- 4x^2 sin(x^2)) =
    // $

    // Unmark this!
    Let $g(x) = f prime prime (x) = 2cos(x^2) - 4x^2 sin(x^2)$

    In other words, we must find $max(abs(g(x)))$ on $[0, sqrt(pi/2)]$.

    First, we can  find critical points:
    $
      0 & = dif /(dif x) g(x) \
        & = dif /(dif x) ( 2cos(x^2) - 4x^2 sin(x^2) ) \
        & = -4x sin(x^2) - 8x sin(x^2) - 8x^3 cos(x^2) \
        & = -12x sin(x^2) - 8x^3 cos(x^2) \
      0 & = -4x (3sin(x^2) + 2x^2 cos(x^2)) \
      0 & = 3sin(x^2) + 2x^2 cos(x^2) wide x = 0
    $


    We now must show that $g(x)$ has no more critical points other than $x = 0$. In other words, showing that $3sin(x^2) + 2x^2 cos(x^2) != 0$ for all $x in (0, sqrt(pi/2)]$. 

    At $x = sqrt(pi/2)$, $3sin(x^2) + 2x^2 cos(x^2) = 3 $. So now we only have to check $x in (0, sqrt(pi/2))$
    

    For all $x in (0, sqrt(pi/2))$:
    $
      x^2 > 0 \
      sin(x^2) > 0 \
      cos(x^2) > 0 \
      // #todo[This is wrong, should be greater than or euqals or adjust bounds]

    $
    Hence:
    $
      3sin(x^2) > 0\
      2x^2 cos(x^2) > 0\
      3sin(x^2) + 2x^2 cos(x^2) > 0\
      3sin(x^2) + 2x^2 cos(x^2) != 0 \
    $
    Therefore there are no solutions to:
    $
      0 = 3sin(x^2) + 2x^2 cos(x^2) "for" x in (0, sqrt(pi/2))
    $
    So $g(x)$ has only one critical point at $x = 0$, and two end points at $x = 0, sqrt(pi/2)$ on $[0, sqrt(pi/2)]$.
    $
               g(0) & = 2cos(0^2) - 4(0^2) sin(0^2) = 2 \
      g(sqrt(pi/2)) & = 2cos(sqrt(pi/2)^2) - 4(sqrt(pi/2)^2) sin(sqrt(pi/2)^2) = -2pi \
    $

    Therefore, the global extrema of $g(x)$ on $[0, sqrt(pi/2)]$ are $g(0) = 2$ and $g(sqrt(pi/2)) = -2pi$. So:
    $
      max(abs(g(x))) = 2 pi \
      max(abs(f''(x))) = 2 pi \
      abs(f''(x)) <= 2 pi
    $

    So a good value of $K_2$ would be:
    $
      K_2 = 2pi
    $

  //   $
  //   12x sin(x^2) &= - 8x^3 cos(x^2)  \
  //   sin(x^2) / cos(x^2) &= (- 8x^3)   / (12x)  \
  //   tan(x^2) &= (- 8 / 12) x^2   \
  // $

  // There doesn't seem to be any apparent zeros between


  + #p[Find the value of (the smallest) $N$ which guarantees the trapezoid rule approximates the Fresnel Integral with errors less than $10^(-1)$ and $10^(-2)$. Be sure to justify your answers.]


  The bound on the error from the trapezoid rule is:
  $
    abs(int_a^b f(x) dif x - (b-a)/N sum^N_(k=1) (f(x_k) + f(x_(k-1)) ) / 2,) <= (b-a)^3 / (12 N^2)K_2
  $
  In our case, $f(x) = sin(x^2)$ and $a = 0, b = sqrt(pi/2)$.
  $
    abs(int_0^sqrt(pi/2) sin(x^2) dif x - (sqrt(pi/2))/N sum^N_(k=1) (sin(x_k^2) + sin(x_(k-1)^2) ) / 2,) <= (sqrt(pi/2))^3 / (12 N^2)K_2
  $

  // #todo("Add the bounds here, a, b")

  Therefore we can just find values of $N$ for which:
  $
    (sqrt(pi/2))^3 / (12 N^2)K_2 < 10^(-1) wide
    "and" wide
    (sqrt(pi/2))^3 / (12 N^2)K_2 < 10^(-2)
  $

  Starting off with $10^(-1)$:
  $
    (sqrt(pi/2))^3 / (12 N^2)K_2 & < 10^(-1) \
                      1 / ( N^2) & < ((12) (10^(-1))) / (K_2 (sqrt(pi/2))^3) wide 12, (sqrt(pi/2))^3, K_2 > 0 \
                             N^2 & > (K_2 (sqrt(pi/2))^3)/((12) (10^(-1))) \
                               N & > sqrt((K_2 (sqrt(pi/2))^3)/((12) (10^(-1))))
  $

  With $K_2 = 2pi$ from part c:
  $
    //  N &>  sqrt((K_2 (sqrt(pi/2))^3)/((12) (10^(-1)))) \
    N & > sqrt((( 2pi) (sqrt(pi/2))^3)/((12) (10^(-1)))) approx 3.21062230801
  $
  Therefore, since $N in ZZ$ the smallest $N$ for which the approximation is within $10^(-1)$ is:
  $
    #rect($ N = 4 $)
  $


  Similarly, for $10^(-2)$:
  $
    //  N &> sqrt((K_2 (sqrt(pi/2))^3)/((12) (10^(-2)))) \
    N & > sqrt(((2pi) (sqrt(pi/2))^3)/((12) (10^(-2)))) approx 10.1528791998 \
  $

  Therefore the smallest $N$ for which the approximation is within $10^(-2)$ is:
  $
    #rect($ N = 11 $)
  $



+ #p[In class, we proved Part 2 of the Fundamental Theorem of Calculus, which states that if $f$ is a continuous function on the interval $[a, b]$ and F is any antiderivative of $f$, then

    $
      F(b)-F(a) = int_a^b f(x) dif x
    $

    Here, you will construct another proof of Part 2 of the Theorem.]

  + #p[Divide the interval $[a, b]$ in $n$ subintervals with endpoints $a = x_0 < x_1 < x_2 < ... < x_n = b$. Show that

      $
        F(b) - F(a) = sum_(i=1)^n (F(x_i) - F(x_(i-1)))
      $]

    Let $a = x_0 < x_1 < x_2 < ... < x_n = b$

    Consider the sum:
    $
      sum_(i=1)^n (F(x_i) - F(x_(i-1)))
    $

    Expanding, we get:
    $
      sum_(i=1)^n (F(x_i) - F(x_(i-1))) \
      = (sum_(i=1)^n F(x_i)) - sum_(i=1)^n F(x_(i-1))) \
      //  sum_(i=1)^n (F(x_i) - F(x_(i-1))) = F(x_1) - F(x_(0)) + F(x_2) - F(x_(1)) + ... + F(x_n) - F(x_(n-1))
      // $
      // We can further expand:
      // $
      // (sum_(i=1)^n F(x_i))  - sum_(i=1)^n F(x_(i-1))) \
      = ( F(x_1) + F(x_2) + ... + F(n - 1) + F(x_n) ) - ( F(x_0) + F(x_1) + F(x_2) + ... + F(x_n-1) )
    $

    All terms except for $F(x_0)$ and $F(x_n)$ cancel, leaving:
    $
      sum_(i=1)^n (F(x_i) - F(x_(i-1))) = F(x_n) - F(x_0)
    $
    By definition $x_n = b$ and $x_0 = a$, therefore
    $
      #rect($ sum_(i=1)^n (F(x_i) - F(x_(i-1))) = F(b) - F(a) $)
    $

  + #p[Now suppose that $F$ is any antiderivative of $f$. Show that there exists a number $c_i$ in
      each interval $[x_(i-1), x_i]$ such that

      $
        F(x_i) - F(x_(i-1)) = f(c_i)(x_i - x_(i-1))
      $
    ]


    // * Could be made more concise*

    // #todo("Remove this")


    Let $g(x)$ be a function continuous on the interval $[j, k]$.

    Let $G(x)$ be any antiderivative of a function $g(x)$.

    By definition, $G(x)$ is differentiable on $[j, k]$, and since differentiability implies continuity, is also continuous on $[j, k]$.

    By the Mean Value Theorem, there must exist some $u in (j, k)$ such that:

    $
      (G(k) - G(j))/(k - j) = G prime (u)
    $

    Since by definition, $G prime (u) = g(u)$, we can rearrange:

    $
      G(k) - G(j) = g (u) (k - j)
    $

    Now we can show that this holds for our original functions $f$ and $F$.

    $f(x)$ is a function continuous on the interval $[a, b]$ and is therefore continuous on $[x_(i-1), x_i]$ as by definition, $a <= x_(i-1) < x_i <= b$.

    $F(x)$ is an antiderivative of a function $f(x)$.

    Therefore, $f(x)$ and $F(x)$ on $[x_(i-1), x_i]$ is analogous to $g(x)$ and $G(x)$ on $[j, k]$. Therefore, there must exist some $c_i$ in $(x_(i-1), x_i)$ such that:

    $
      F(x_i) - F(x_(i-1)) = f(c_i)(x_i - x_(i-1))
    $

  // * Remember to rewrite this with proper logic *


  // Take the derivative of both sides:
  // $
  //   dif / (dif x) (F(x_i) - F(x_(i-1))) = dif / (dif x) (f(c_i)(x_i - x_(i-1))) \
  //   dif / (dif x) (F(x_i)) - dif / (dif x)  (F(x_(i-1))) = dif / (dif x) (f(c_i)(x_i - x_(i-1))) \
  // $

  // Since $F$ is an antiderivative of $f$:
  // $
  //   dif / (dif x)  (F(x)) = f(x)
  // $

  // Therefore:
  // $
  //   f(x_i) - f(x_(i-1)) = (x_i - x_(i-1)) dif / (dif x) (f(c_i))
  // $
  
    #colbreak()


  + #p[Now build an appropriate Riemann sum for $f$ on $[a,b]$ and show that
      $
        F(b) - F(a) = int^b_a f(x) dif x
      $]

    We have shown that:
    $
      F(b) - F(a) = sum_(i=1)^n (F(x_i) - F(x_(i-1)))
    $
    And that there exists some $c_i in (x_i, x_(i-1))$ such that
    $
      F(x_i) - F(x_(i-1)) = f(c_i)(x_i - x_(i-1))
    $

    for any $f(x)$ continuous on the interval $[a, b]$, any antiderivative of $f(x)$, $F(x)$, any intervals $a = x_0 < x_1 < x_2 < ... < x_n = b$.

    Combining these statements we get:
    $
      F(b) - F(a) = sum_(i=1)^n (f(c_i)(x_i - x_(i-1)))
    $

    Taking the limit of both sides as $n$ approaches $infinity$:
    $
      lim_(n -> infinity) (F(b) - F(a)) = lim_(n -> infinity) ( sum_(i=1)^n (f(c_i)(x_i - x_(i-1)))) \
      F(b) - F(a) = lim_(n -> infinity) ( sum_(i=1)^n (f(c_i)(x_i - x_(i-1))))
    $

    Noting that the right hand is equivalent to the limit of the Riemann sum of $f(x)$ as the number of intervals approaches infinity, we can rewrite it in integral notation.

    Since for any function $g(x)$ defined on any interval $[u, v]$:
    $
      lim_(n->infinity)sum_(i = 1)^n g(x + i Delta x) Delta x = int_u^v g(x)
    $
    Where $Delta x = display((u - v) / n)$.

    In our case $Delta x = x_i - x_(i-1)$. By definition $c_i$ exists in the interval $(x_i, x_(i-1))$, therefore we can substitute $x + i Delta x$ as $c_i$ as this equality holds as long as the sampled point of the function lies within each interval of the sum (i.e the limit of left, right, and midpoint Riemann sums are equivalent).

    #todo("Look into improving this proof")

    So we can rewrite:
    $
      lim_(n -> infinity) ( sum_(i=1)^n (f(c_i)(x_i - x_(i-1)))) = int_(x_0)^x_n f(x) = int_(a)^b f(x)
    $

    Therefore:
    $
      #rect($ F(b) - F(a) = int^b_a f(x) dif x $)
    $




// #show: appendix

// = Guide to Finding Intersection Points of $P_"in"$ and $P_"out"$ in Python<app1>
// Create a new Jupyter notebook using anaconda. Copy and paste the following lines of code into a new cell.

// + #p[
//     #underline[*Your task:*] Derive the EBM given above and verify that the units on both sides of the
//   ]

//   #align(center)[
//     #table(
//       columns: (auto, auto),
//       inset: 10pt,
//       align: center,
//       stroke: (x, y) => if x == 0 and y >= 1 {
//         (right: 0.7pt + black)
//       },
//       table.header([*Left Side*], [*Right Side*]),

//       $
//         & = J K^(-1) K / s \
//         & = J / s \
//         & = W
//       $,

//       $
//         & = W - W \
//         & = W \
//       $,
//     )

//     $
//       W = W
//     $
//     *  Left Side = Right Side
//     *
//   ]

//   Therefore, the units are consistent.

//     $
//     lim_(T -> 247^- )alpha(T) = alpha(247) wide lim_(T -> 247^+ )alpha(T) = alpha(247) wide lim_(T -> 282^- )alpha(T) = alpha(282) wide lim_(T -> 282^+ )alpha(T) = alpha(282)
//   $

//   #colbreak()
