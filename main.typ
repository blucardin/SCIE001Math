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
          f prime (a) & = (n a^(n - 1))cos(1/a) + (x^n)(-sin(1/a))(-1a^(-2))
        $,

        $
          f prime (a) & = n a^(n - 1) \
        $,
      )
    ]
    *$ a = 0 $*
    $
      f prime (a) = f prime (0) & = lim_(h -> 0 ) (f(0 + h) - f(0))/h \
                                & = lim_(h -> 0 ) (f(h) - 0^n)/h
    $

    This splits to left and right hand limits:

    $
      lim_(h -> 0^- ) (f(h) - 0^n)/h \
      =lim_(h -> 0^- ) (h^n - 0^n)/h \
      "For all" n != 0: \
      =lim_(h -> 0^- ) (h^n)/h \
      =lim_(h -> 0^- ) (h^(n-1)) \
      =0 \
    $

    $
      lim_(h -> 0^+ ) (f(h) - 0^n)/h \
      = lim_(h -> 0^+ ) (h^n cos (1/h) - 0^n)/h \
      "For all" n != 0: \
      = lim_(h -> 0^+ ) h^(n-1) cos (1/h) \
    $


    #align(center)[
      #table(
        columns: (auto, auto),
        inset: 10pt,
        align: center,
        stroke: (x, y) => if x == 0 {
          (right: 0.7pt + black)
        },
        table.header([*$n < 1$*], [*$n = 1$*]),
        $
          n - 1 < 0 \
          therefore lim_(h -> 0^+ ) h^(n-1) cos (1/h) \
          = D.N.E \
        $,
        $
          lim_(h -> 0^+ ) h^(n-1) cos (1/h) \
          = lim_(h -> 0^+ ) h^(0) cos (1/h) \
          = lim_(h -> 0^+ ) cos (1/h) \
          = D.N.E
        $,
      )

      *$ n > 1 $*
      $
        -1 <= cos(1/h) <= 1 \
        "For all" h > 0: h^(n-1) > 0\
        -h^(n-1) <= h^(n-1)cos(1/h) <= h^(n-1) \
        lim_(h -> 0^+ ) -h^(n-1) <= lim_(h -> 0^+ ) h^(n-1) cos (1/h) <= lim_(h -> 0^+ ) h^(n-1) \
        0 <= lim_(h -> 0^+ ) h^(n-1) cos (1/h) <= 0 \
        therefore "by The Squeeze Theorem" \
        lim_(h -> 0^+ ) h^(n-1) cos (1/h) = 0
      $
    ]

    The left and right hand limits exist and are equal only when $n > 1$.

    Therefore:
    $
      "When" n > 1: wide f prime (0) = 0
    $


    Now we have the tools to solve the original limit.

    $
      f prime prime (0) & = lim_(h -> 0 ) (f prime (0 + h) - f prime (0))/h wide "must exist" \
                        & = lim_(h -> 0 ) (f prime (h) - 0)/h \
    $
    This splits to left and right hand limits:
    $
      lim_(h -> 0^- ) (f^prime (h))/h \
      =lim_(h -> 0^- ) (n h^(n - 1))/h \
      =lim_(h -> 0^- ) n h^(n - 2) \
    $
    #align(center)[
      #table(
        columns: (auto, auto, auto),
        inset: 10pt,
        align: center,
        stroke: (x, y) => if x == 0 or x == 1 {
          (right: 0.7pt + black)
        },
        table.header([*$n < 2$*], [*$n = 2$*], [*$n > 2$*]),

        $
          n - 2 < 0 \
          lim_(h -> 0^- ) n h^(n - 2) = D.N.E \
        $,

        $
          lim_(h -> 0^- ) n h^(n - 2) \
          = lim_(h -> 0^- ) 2 h^0 \
          = 2
        $,

        $
          n - 2 > 0 \
          lim_(h -> 0^- ) n h^(n - 2) \
          = 0\
          "For our purposes,"\ h^(n-2) "is undefined"\ "for" x < 1 "when" n in.not ZZ \
          therefore "This only holds for" \
          n in ZZ
        $,
      )
    ]

    $
      lim_(h -> 0^+ ) (f^prime (h))/h \
      = lim_(h -> 0^+ ) ((n h^(n - 1))cos(1/h) + (h^n)(-sin(1/h))(-1h^(-2)))/h \
      = lim_(h -> 0^+ ) (n h^(n - 2))cos(1/h) + (h^(n-1))(-sin(1/h))(-1h^(-2)) \
      = lim_(h -> 0^+ ) n h^(n - 2)cos(1/h) + h^(n-3)sin(1/h)
    $


    #align(center)[*For $n < 3$:*]
    $
      n - 3 < 0 \
      lim_(h -> 0^+ ) h^(n-3)sin(1/h) = D.N.E \
      therefore
      lim_(h -> 0^+ ) n h^(n - 2)cos(1/h) + h^(n-3)sin(1/h) = D.N.E
    $

    #align(center)[* For $n = 3$:*]

    $
      lim_(h -> 0^+ ) n h^(n - 2)cos(1/h) + h^(n-3)sin(1/h) \
      = lim_(h -> 0^+ ) 3 h^(1)cos(1/h) + h^(0)sin(1/h) \
      = lim_(h -> 0^+ ) 3 h cos(1/h) + sin(1/h) \
      lim_(h -> 0^+ ) sin(1/h) = D.N.E \
      therefore lim_(h -> 0^+ ) n h^(n - 2)cos(1/h) + h^(n-3)sin(1/h) = D.N.E
    $

    #align(center)[*For $n > 3$:*]
    $
      -1 <= cos(1/h) <= 1 \
      "For all" h > 0: h^(n-2) > 0\
      -h^(n-2) <= h^(n-2)cos(1/h) <= h^(n-2) \
      lim_(h -> 0^+ ) -h^(n-2) <= lim_(h -> 0^+ ) h^(n-2) cos (1/h) <= lim_(h -> 0^+ ) h^(n-2) \
      n - 2 > 0 \
      0 <= lim_(h -> 0^+ ) h^(n-2) cos (1/h) <= 0 \
      therefore "by The Squeeze Theorem" \
    $
    *$ lim_(h -> 0^+ ) h^(n-2) cos (1/h) = 0 $*



    $
      -1 <= sin(1/h) <= 1 \
      "For all" h > 0: h^(n-3) > 0\
      -h^(n-3) <= h^(n-3)sin(1/h) <= h^(n-3) \
      lim_(h -> 0^+ ) -h^(n-3) <= lim_(h -> 0^+ ) h^(n-3) sin(1/h) <= lim_(h -> 0^+ ) h^(n-3) \
      n - 3 > 0 \
      0 <= lim_(h -> 0^+ ) h^(n-3) sin(1/h) <= 0 \
      therefore "by The Squeeze Theorem" \
    $
    *$ lim_(h -> 0^+ ) h^(n-3) sin(1/h) = 0 $*

    $
      lim_(h -> 0^+ ) n h^(n - 2)cos(1/h) + h^(n-3)sin(1/h) \
      = (lim_(h -> 0^+ ) n)(lim_(h -> 0^+ ) h^(n - 2)cos(1/h)) + lim_(h -> 0^+ ) (h^(n-3)sin(1/h)) \
      = n(0) + 0\
      therefore lim_(h -> 0^+ ) n h^(n - 2)cos(1/h) + h^(n-3)sin(1/h) = 0
    $

    The only values of $n$ for which the left and right hand limit both exist and are equal are when $n > 3, n in ZZ$.

    #align(center)[
      #rect[$therefore f prime$ is differentiable at $x = 0$ for all $n > 3, n in ZZ$ ]
    ]


  + *For what values of $n$ is $f prime$ is continuous at $x = 0$?*

    For $f prime$ to be continuous at $x = 0$:

    $ lim_(x -> 0) f prime (x) = f prime (0) $

    Using our previously derived definition of $f prime$:
    $
      f prime (0) = 0
    $

    $lim_(x -> 0) f prime (x)$ splits to right and left hand limits:

    $
      lim_(x -> 0^- ) f^prime (x) \
      =lim_(h -> 0^- ) n h^(n - 1) \
    $
    #align(center)[
      #table(
        columns: (auto, auto, auto),
        inset: 10pt,
        align: center,
        stroke: (x, y) => if x == 0 or x == 1 {
          (right: 0.7pt + black)
        },
        table.header([*$n < 1$*], [*$n = 1$*], [*$n > 1$*]),

        $
          n - 1 < 0 \
          lim_(h -> 0^- ) n h^(n - 1) = D.N.E \
        $,

        $
          lim_(h -> 0^- ) n h^(n - 1) \
          = lim_(h -> 0^- ) 1 h^0 \
          = 1
        $,

        $
          n - 1 > 0 \
          lim_(h -> 0^- ) n h^(n - 1) \
          = 0\
          "For our purposes,"\ h^(n-1) "is undefined"\ "for" x < 1 "when" n in.not ZZ \
          therefore "This only holds for" \
          n in ZZ
        $,
      )
    ]

    $
      lim_(h -> 0^+ ) f^prime (h)\
      = lim_(h -> 0^+ ) (n h^(n - 1))cos(1/h) + (h^n)(-sin(1/h))(-1h^(-2)) \
      = lim_(h -> 0^+ ) n h^(n - 1)cos(1/h) + h^(n-2)sin(1/h)
    $


    #align(center)[*For $n < 2$:*]
    $
      n - 2 < 0 \
      lim_(h -> 0^+ ) h^(n-2)sin(1/h) = D.N.E \
      therefore
      lim_(h -> 0^+ ) n h^(n - 1)cos(1/h) + h^(n-2)sin(1/h) = D.N.E
    $

    #align(center)[* For $n = 2$:*]

    $
      lim_(h -> 0^+ ) n h^(n - 1)cos(1/h) + h^(n-2)sin(1/h) \
      = lim_(h -> 0^+ ) 3 h^(1)cos(1/h) + h^(0)sin(1/h) \
      = lim_(h -> 0^+ ) 3 h cos(1/h) + sin(1/h) \
      lim_(h -> 0^+ ) sin(1/h) = D.N.E \
      therefore lim_(h -> 0^+ ) n h^(n - 2)cos(1/h) + h^(n-3)sin(1/h) = D.N.E
    $

    #align(center)[*For $n > 2$:*]
    $
      -1 <= cos(1/h) <= 1 \
      "For all" h > 0: h^(n-1) > 0\
      -h^(n-1) <= h^(n-1)cos(1/h) <= h^(n-1) \
      lim_(h -> 0^+ ) -h^(n-1) <= lim_(h -> 0^+ ) h^(n-1) cos (1/h) <= lim_(h -> 0^+ ) h^(n-1) \
      n - 2 > 0 \
      0 <= lim_(h -> 0^+ ) h^(n-1) cos (1/h) <= 0 \
      therefore "by The Squeeze Theorem" \
    $
    *$ lim_(h -> 0^+ ) h^(n-1) cos (1/h) = 0 $*



    $
      -1 <= sin(1/h) <= 1 \
      "For all" h > 0: h^(n-2) > 0\
      -h^(n-2) <= h^(n-2)sin(1/h) <= h^(n-2) \
      lim_(h -> 0^+ ) -h^(n-2) <= lim_(h -> 0^+ ) h^(n-2) sin(1/h) <= lim_(h -> 0^+ ) h^(n-2) \
      n - 3 > 0 \
      0 <= lim_(h -> 0^+ ) h^(n-2) sin(1/h) <= 0 \
      therefore "by The Squeeze Theorem" \
    $
    *$ lim_(h -> 0^+ ) h^(n-2) sin(1/h) = 0 $*

    $
      lim_(h -> 0^+ ) n h^(n - 1)cos(1/h) + h^(n-2)sin(1/h) \
      = (lim_(h -> 0^+ ) n)(lim_(h -> 0^+ ) h^(n - 1)cos(1/h)) + lim_(h -> 0^+ ) (h^(n-2)sin(1/h)) \
      = n(0) + 0\
      therefore lim_(h -> 0^+ ) n h^(n - 1)cos(1/h) + h^(n-2)sin(1/h) = 0
    $

    The only values of $n$ for which the left and right hand limit both exist and are equal are when $n > 2, n in ZZ$.

    #align(center)[
      #rect[$therefore f prime$ is continuous at $x = 0$ for all $n > 2, n in ZZ$ ]
    ]


+ *Escaping a predator. A large fish (predator) of (vertical) size $S$ is approaching a small fish (prey) at a constant speed $v$. Let $x(t)$ be the distance between the predator and the prey at time $t$.*

  #image("fishes.png")

  + *Find an expression for the rate of change of the visual angle θ perceived by the prey in terms of the size and speed of the approaching predator, and the predator's distance away from its prey. The visual angle is the angle subtended by an object at the eye of the observer.*
    
    $
      theta &= 2 tan^(-1)((S / 2) / x(t) )  \
      &= 2 tan^(-1)((S / 2)x(t)^(-1))
    $
    $
      (d x) / (d t) = v
    $
    $
      (d theta) / (d t) &= 2 (( 1 / (1 + ((S / 2)x(t)^(-1))^2))(S / 2)(-1)x(t)^(-2)((d x) / (d t)) ) \
      &=  (-S x(t)^(-2) v ) / (1 + (S^2 / 4)x(t)^(-2)) \
      &=  (-S x(t)^(-2) v ) / (( (4 x(t)^2  + S^2) / (4 x(t)^2 ))) \
      &=  (-S x(t)^(-2) v (4 x(t)^2 ) ) / (4 x(t)^2  + S^2) \
      &=  (-4 S v  ) / (4 x(t)^2  + S^2) \
    $

    $
      #rect[$ therefore  (d theta) / (d t) &=  (-4 S v  ) / (4 x(t)^2  + S^2)  $]
    $

  + *As the predator approaches its prey, we expect the visual angle perceived by the prey to increase, as objects appear bigger when they are closer. Verify this is consistent with your result from part (a). Is the visual angle getting bigger faster or slower as the predator approaches its prey?*

    $
      (d theta) / (d t) &=  (-4 S v  ) / (4 x(t)^2  + S^2) \ 
      &=  (-4 S v  ) (4 x(t)^2  + S^2)^(-1) \ 

      (d^2 theta) / (d^2 t) &= (-4 S v  ) (-1) (4 x(t)^2  + S^2)^(-2)(8 x(t))(v) \
      &= (32 S v^2 x(t) ) (4 x(t)^2  + S^2)^(-2) \
      &= (32 S v^2 x(t) ) / (4 x(t)^2  + S^2)^2 
    $

    For all $x > 0$, $(d^2 theta) / (d^2 t) > 0$, in other words $theta(t)$ is concave up on $x > 0$.
    
    #rect[Therefore, the visual angle is getting bigger faster as the predator approaches the prey.]

    Our result is consistent with the expected behavior. 

  + *Visual angles are important factors in studies of predator avoidance. A model proposed by L. Dill, a behavioural ecologist at Simon Fraser University, about the behaviour of the Zebra Danio (a small tropical fish) suggested that “Zebra Danios react to an approaching predator when the rate of change of the angle subtended by the predator at the prey's eye exceeds some threshold level” (L. Dill (1974) “The escape response of the Zebra Danio (Brachydanio rerio). I. The stimulus for escape.”, Animal Behaviour, 22, 711-722). Suppose an escape reaction is triggered when the rate of change of the visual angle reaches the threshold value $r_"crit"$. Using the model developed in part (a), find the distance $x_"react"$ between prey and predator at which an escape response is triggered.*

  An escape response is triggered when the derivative of the visual angle reaches $r_"crit"$, at this point in time the predator is a distance $x_"react"$ from the prey. 

  $
    r_"crit" &= (d theta) / (d t)\ 
    r_"crit" &= (-4 S v  ) / (4 x_"react"^2  + S^2)\ 
    r_("crit")(4 x_"react"^2  + S^2) &= -4 S v \ 
    4 x_"react"^2 r_("crit")  + S^2 r_("crit") &= -4 S v \ 
    x_"react"  &= plus.minus sqrt( (-4 S v - S^2 r_("crit")) / (4 r_("crit"))) \ 
  $

  Since we only care if the prey is in front of the predator: 

  #align(center)[
    #rect($ x_"react" &= sqrt( (-4 S v - S^2 r_("crit")) / (4 r_("crit"))) $)
  ]

  + *Using the model developed in part (a) and (c), explain why for a predator of a given size S your model requires a “hunting speed” $v > (S r_"crit") / 4$ in order to trigger an escape response by the prey.*

    $ 
    x_"react" &= sqrt((-4 S v - S^2 r_("crit")) / (4 r_("crit"))) 
    $
    For $x_"react" $ to exist and not be 0 (the distance the predator eats the prey):
    $ (-4 S v - S^2 r_("crit")) / (4 r_("crit")) > 0 \
    r_("crit") > 0 \
    -4 S v > S^2 r_("crit") \ 
    v < (S^2 r_("crit")) / (-4S) \
    v < (S r_("crit")) / (-4) \
    $
    Since velocity is assumed to be negative in my model, we can multiply the right side by $-1$ to show the relationship for a positive "hunting speed".
    $
        "For" x_"react" "to exist:" wide "Hunting Speed" > (S r_("crit")) / (4) \
    $

    #align(center)[
    #rect[Therefore, using the model derived in (c), for the animal to react: $ "Hunting Speed" > (S r_("crit")) / (4) $]]


  + *Again, using the model developed in part (a) and (c), for a given “hunting speed” $v$, what size S would not result in an escape response by the prey?*
    $ 
    x_"react" &= sqrt((-4 S v - S^2 r_("crit")) / (4 r_("crit"))) 
    $
    For $x_"react" $ to exist and not be 0 (the distance the predator eats the prey):
    $ 
    (-4 S v - S^2 r_("crit")) / (4 r_("crit")) > 0 \
    r_("crit") > 0 \
    S(-4v - S r_("crit")) > 0 \ 
    S > 0 \
    -4v - S r_("crit") > 0 \ 
     - S  > (4v) / r_("crit") \ 
     S  < -(4v) / r_("crit") \ 
    $



    Again, since velocity is assumed to be negative in my model, we can multiply the right side by $-1$ to show the relationship for a positive "hunting speed".#todo[Based on what it says in the last question, I think this is not supposed to be flipped, investigate.]
    $
        "For" x_"react" "to exist:" wide S > (4v) / r_("crit") \  \
    $

    To determine the speed that will not trigger an escape response, we can just flip the less than symbol. 

    #align(center)[
    #rect[Therefore, using the model derived in (c), to *not* trigger an escape response in the prey : $ S < (4v) / r_("crit") $]]


  
  + *Using your results found in parts (d) and (e), explain why large predators #todo[Like why does this say large predators instead of small predators] and slowing moving predators would have higher success rate at eating the small Zebra Danio.*

    If you are slow moving enough you can sneak up on the small Zebra Danio and not trigger its escape response since when 

    $ "Hunting Speed" < (S r_("crit")) / (4) $

    $x_"react"$ does not exist, as developed in (c).

    Similarly if you are small enough you can sneak up on the small Zebra Danio and not trigger its escape response since when:

    $ S < (4v) / r_("crit") $

    $x_"react"$ does not exist, as developed in (c).

