// math template
#import "@preview/numbly:0.1.0": numbly

#import "@preview/dashy-todo:0.1.2": todo


#set enum(
  full: true,
  numbering: numbly("{1:1}.", "{2:(a)}"),
)

#let lim = math.limits(math.lim)

// #set heading(numbering: "1.")

#align(center + horizon)[

  _#text(30pt)[
      HW1.2
    ] \ \
  _

  // #show heading: it => pad(left: 1em * (it.level - 1), it)

  SCIE 001 Math

  #let today = datetime.today()

  #today.display("[month repr:long]")
  #today.day(), #today.year()// or another custom format

]

#pagebreak()

+ *Show that if $x>0$ and $x != 1$ then,
    $ ln(x) < x - 1 $
    Justify your claims.*

  Let $f(x) = ln(x)$

  *Lemma 1: $ln(c) < (c - 1)$ for all $c > 1$*

  $f(x)$ is continuous on $[1, infinity)$ and differentiable on $(1, + infinity) in in$

  By the Mean Value Theorem there exists some $c in (1, + infinity)$ such that:

  $
    f prime (c) = (f(c) - f(1))/(c - 1) \
    1/c = (ln(c) - ln(1))/(c - 1)
  $
  Since we are only looking at $c > 1$:
  $
    0 < 1/c < 1 \
    (ln(c) - ln(1))/(c - 1) = 1/c < 1 \
    (ln(c) - ln(1))/(c - 1) < 1
  $

  Since $c > 1$, $c - 1 > 0$:
  $
    ln(c) - ln(1) < c - 1
  $

  $ln(1) = 0$ therefore:
  $
    #rect[For  $c > 1 ":" wide ln(c) < c - 1$]
  $

  *Lemma 2: $ln(c) < (c - 1)$ for all $0 < c < 1$*

  $f(x)$ is continuous on $[0, 1]$ and differentiable on $(0, 1)$

  By the Mean Value Theorem there exists some $c in (0, 1)$ such that:

  $
    f prime (c) = (f(c) - f(1))/(c - 1) \
    1/c = (ln(c) - ln(1))/(c - 1)
  $
  Since we are only looking at $0 < c < 1$:
  $
                        1/c & > 1 \
    (ln(c) - ln(1))/(c - 1) & = 1/c > 1 \
    (ln(c) - ln(1))/(c - 1) & > 1
  $

  Note that since $0 < c < 1$, $c-1 < 0$, so we flip the comparison when we multiply.

  $
    ln(c) - ln(1) < c - 1
  $

  $ln(1) = 0$ therefore:
  $
    #rect[For  $x > 1 ":" wide ln(c) < c - 1$]
  $

  Combining the equalities from *Lemma 1* and *Lemma 2* we get:

  $
    #rect[For  $x > 0, x != 1 ":" wide ln(c) < c - 1$]
  $

  Q.E.D



+ *Consider the “Gompertz” model of population dynamics,
    $ (d P)/(d t) = c P ln(K/P), wide P(0) = P_0 $
    where c and K are positive constants. Verify that the functions $P(t) = K e^((-b e^((-c t))))$, where b is a
    constant, are solutions of the Gompertz equation. Then find an expression for $b$ in terms of $P_0$.*

  If the functions $P(t) = K e^((-b e^((-c t))))$ are solutions of the Gompertz equation, then it should satisfy the ordinary differential equation:

  $
    (d P)/(d t) = c P ln(K/P)
  $

  To prove this, we can use just rearrange them to show they are equal:

  $ (d P)/(d t) = (d P)/(d t) $
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
        & = d/(d t)(K e^((-b e^((-c t))))) \
        & = K e^((-b e^((-c t))))(-b e^((-c t)))(-c) \
        & = K c b e^((-c t))e^((-b e^((-c t)))) \
        & = K c b e^((-c t))e^((-b e^((-c t)))) \
      $,

      $
        & = c P ln(K/P) \
        & = c K e^((-b e^((-c t)))) ln(e^(-(-b e^((-c t)))))) \
        & = c K e^((-b e^((-c t)))) b e^((-c t)) \
        & = K c b e^((-c t)) e^((-b e^((-c t)))) \
      $,
    )

    *  Left Side = Right Side
    *
  ]

  #rect[Therefore $P(t) = K e^((-b e^((-c t))))$ are a family of solutions.]

  To find $b$ in terms of $P_0$, we just need to solve $P(0)$ for $b$:
  // $ (d P)/(d t) = c P ln(K/P) wide P(0) = P_0 $

  $
    P_0 & = P(0) \
        & = K e^((-b e^((-c (0))))) \
    P_0 & = K e^((-b)) \
        & #rect[$ therefore b & = - ln(P_0 / K) $]
  $



+ *Let
    $ f(x) = cases(x^n cos(1/x) wide &"if" x > 0, x^n &"if" x <= 0) $
    for $n > 0$. *
  + *For what values of $n$ is $f prime$ differentiable at $x = 0$?*

    For $f prime$ to be differentiable at $x = 0$:
    $ lim_(h -> 0 ) (f prime (0 + h) - f prime (0))/h $
    must exist.

    So we can attempt to solve this equation for our possible values of $n$. This first involves finding the derivative of $f$.

    Based on the definition of the derivative:
    $
      f prime (a) & = lim_(h -> 0 ) (f(a + h) - f(a))/h \
    $
    This can be seen as a piecewise function for values of $a$ below 0, at 0, or above 0. Below and above zero we can just take the derivative of the respective piecewise cases of $f$, but at zero we need to use the definition of the derivative.

    #align(center)[
      #table(
        columns: (auto, auto),
        inset: 10pt,
        align: center,
        stroke: (x, y) => if x == 0 and y >= 1 {
          (right: 0.7pt + black)
        },
        table.header([*$a>0$*], [*$a<0$*]),

        $
          f prime (a) & = (n x^(n - 1))cos(1/x) + (x^n)(-sin(1/x))(-1x^(-2))
        $,

        $
          f prime (a) & = n x^(n - 1) \
        $,
      )
    ]
    *$ a = 0 $*
    $
      f prime (a) = f prime (0) & = lim_(h -> 0 ) (f(0 + h) - f(0))/h \
                                & = lim_(h -> 0 ) (f(h) - 0^n)/h
    $

    This splits to left and right hand limits:
    #align(center)[
      #table(
        columns: (auto, auto),
        inset: 10pt,
        align: center,
        stroke: (x, y) => if x == 0 {
          (right: 0.7pt + black)
        },
        table.header([$&=lim_(h -> 0^- ) (f(h) - 0^n)/h$], [$=lim_(h -> 0^+ ) (f(h) - 0^n)/h$]),

        $
          =lim_(h -> 0^- ) (h^n - 0^n)/h \
          "For all" n != 0: \
          =lim_(h -> 0^- ) (h^n)/h \
          =lim_(h -> 0^- ) (h^(n-1)) \
          =0 \
        $,
        $
          = lim_(h -> 0^+ ) (h^n cos (1/h) - 0^n)/h \
          "For all" n != 0: \
          = lim_(h -> 0^+ ) h^(n-1) cos (1/h) \
          -1 < cos(h) < 1 \
          "For all" n in ZZ: \
          #table(
            columns: (auto, auto),
            inset: 10pt,
            align: center,
            stroke: (x, y) => if x == 0 { (right: 0.7pt + black) },
            table.header([$n$ is odd], [$n$ is even]),
            $ -h^(n-1) < cos(h) < h^(n-1) \ $, $$,
          ) \
          "Squeeze Theroem"
        $,
      )
    ]

    Now we have the tools to solve the original limit.

    $
      f prime prime (0) & = lim_(h -> 0 ) (f prime (0 + h) - f prime (0))/h wide "must exist" \
                        & = lim_(h -> 0 ) (f prime (h) - 0)/h \
    $
    This splits to left and right hand limits:
    #align(center)[
      #table(
        columns: (auto, auto),
        inset: 10pt,
        align: center,
        stroke: (x, y) => if x == 0 {
          (right: 0.7pt + black)
        },
        table.header([$lim_(h -> 0^- ) (f^prime (h))/h$], [$lim_(h -> 0^+ ) (f^prime (h))/h$]),

        $
          f prime (a) & = (n x^(n - 1))cos(1/x) + (x^n)(-sin(1/x))(-1x^(-2))
        $,

        $
          f prime (a) & = n x^(n - 1) \
        $,
      )
    ]





  + *For what values of $n$ is $f prime$ is continuous at $x = 0$?*

  For $f prime$ to be continuous at $x = 0$:


  $ lim_(x -> 0) f prime (x) = f prime (0) $

+ *Escaping a predator. A large fish (predator) of (vertical) size $S$ is approaching a small fish (prey) at a constant speed $v$. Let $x(t)$ be the distance between the predator and the prey at time $t$.*

  #image("fishes.png")

  + *Find an expression for the rate of change of the visual angle θ perceived by the prey in terms of the size and speed of the approaching predator, and the predator's distance away from its prey. The visual angle is the angle subtended by an object at the eye of the observer.*
  + *As the predator approaches its prey, we expect the visual angle perceived by the prey to increase, as objects appear bigger when they are closer. Verify this is consistent with your result from part (a). Is the visual angle getting bigger faster or slower as the predator approaches its prey?*
  + *Visual angles are important factors in studies of predator avoidance. A model proposed by L. Dill, a behavioural ecologist at Simon Fraser University, about the behaviour of the Zebra Danio (a small tropical fish) suggested that “Zebra Danios react to an approaching predator when the rate of change of the angle subtended by the predator at the prey's eye exceeds some threshold level” (L. Dill (1974) “The escape response of the Zebra Danio (Brachydanio rerio). I. The stimulus for escape.”, Animal Behaviour, 22, 711-722). Suppose an escape reaction is triggered when the rate of change of the visual angle reaches the threshold value $r_"crit"$. Using the model developed in part (a), find the distance xreact between prey and predator at which an escape response is triggered.*
  + *Using the model developed in part (a) and (c), explain why for a predator of a given size S your model requires a “hunting speed” $v > (S r_"crit") / 4$ in order to trigger an escape response by the prey.*
  + *Again, using the model developed in part (a) and (c), for a given “hunting speed” $v$, what size S would not result in an escape response by the prey?*
  + *Using your results found in parts (d) and (e), explain why large predators and slowing moving predators would have higher success rate at eating the small Zebra Danio.*

