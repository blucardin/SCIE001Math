// math template
#import "@preview/numbly:0.1.0": numbly

#import "@preview/dashy-todo:0.1.2": todo

#import "@preview/cetz:0.4.2"

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
    "HW1.2"
    h(1fr)
    x
  }
})

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

  Noah Virjee

  45515863

]

#pagebreak()

+ *Show that if $x>0$ and $x != 1$ then,
    $ ln(x) < x - 1 $
    Justify your claims.*

  Let $f(x) = x - 1 - ln(x)$

  $f(x)$ is defined, continuous, and differentiable for all $x > 0$

  To prove $ln(x) < x - 1$, we can show $f(x) > 0$ for all $x > 0, x != 1$.

  First we find all values at which $f prime (x)$ is $0$:
  $
    f prime (x) & = 1 - 1/x \
    f prime (x) & = 0 \
        1 - 1/x & = 0 \
              1 & = 1/x \
              x & = 1 \
  $

  // We can find the value of $f prime prime (x)$ at $x = 1$.
  // $
  //         f prime (x) & = 1 - x^(-1) \
  //   f prime prime (x) & = x^(-2) \
  //   f prime prime (1) & = 1^(-2) = 1 \
  // $

  // From these calculations we can see: \
  // - $f(x)$ has a critical point at $x = 0$,
  // - $f(x)$ is concave up at $x = 0$,
  //

  Next, lets find the second derivative:
  $
          f prime (x) & = 1 - x^(-1) \
    f prime prime (x) & = x^(-2) \
  $

  // We can go a bit further to fully show that $f$ has a *global* minimum at $(1, 0)$.

  Since we are only concerned with $x > 0$ ($f(x)$ is only defined for $x > 0$):
  $
                    x & > 0 \
               x^(-2) & > 0 \
    f prime prime (x) & > 0
  $

  Therefore, $f(x)$ is concave up at all $x > 0$, so $f prime (x)$ is always increasing for all $x > 0$.
  Since $f prime (1) = 0$ and $f prime (x)$ is continuous for all $x > 0$, it follows that:

  #align(center)[
    #table(
      columns: (auto, auto),
      inset: 10pt,
      align: center,
      stroke: (x, y) => if x == 0 {
        (right: 0.7pt + black)
      },
      table.header([*For $0 < x < 1$:*], [*For $1 < x$:*]),

      $
        f prime (x) < f prime (1) \
        f prime (x) < 0 \
        "Hence" f(x) "is always decreasing". \
        therefore f(x) > f(1)
      $,

      $
        f prime (x) > f prime (1) \
        f prime (x) > 0 \
        "Hence" f(x) "is always increasing". \
        therefore f(1) < f(x)
      $,
    )
  ]

  We can find the value of $f(x)$ at $x = 1$.
  $
    f(1) & = 1 - 1 - ln(1) = 0
  $

  Combining both sides, for all $x > 0, x != 1$:
  $
    f(x) & > f(1) \
    f(x) & > 0
  $

  Therefore, $f(x)$ has a global minimum at the point $(1, 0)$.
  So we can finally show:

  $
    "For all" x > 0,& x != 1 ":" \
                           f(x) & > 0 \
                  x - 1 - ln(x) & > 0 \
                          x - 1 & > ln(x) \
  $

  $
    #rect[$therefore$ For all $x > 0, x != 1 ":" wide ln(x) < x - 1$]
  $

  Q.E.D



+ *Consider the “Gompertz” model of population dynamics,
    $ (d P)/(d t) = c P ln(K/P), wide P(0) = P_0 $
    where c and K are positive constants. Verify that the functions $P(t) = K e^((-b e^((-c t))))$, where b is a
    constant, are solutions of the Gompertz equation. Then find an expression for $b$ in terms of $P_0$.*

  For a function $P$ to be a solution of the Gompertz equation, it must satisfy the ordinary differential equation:

  $
    (d P)/(d t) = c P ln(K/P)
  $

  To prove that the functions $P(t) = K e^((-b e^((-c t))))$ are solutions, we can rearrange to show equality:

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
      $,

      $
        & = c P ln(K/P) \
        & = c K e^((-b e^((-c t)))) ln(e^(-(-b e^((-c t)))))) \
        & = c K e^((-b e^((-c t)))) b e^((-c t)) \
        & = K c b e^((-c t)) e^((-b e^((-c t)))) \
      $,
    )

    $
      K c b e^((-c t))e^((-b e^((-c t)))) = K c b e^((-c t)) e^((-b e^((-c t))))
    $

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
  $
  $
    #rect[$ therefore b & = - ln(P_0 / K) $]
  $



+ *Let
    $ f(x) = cases(x^n cos(1/x) wide &"if" x > 0, x^n &"if" x <= 0) $
    for $n > 0$. *
  + *For what values of $n$ is $f prime$ differentiable at $x = 0$?*

    For $f prime$ to be differentiable at $x = 0$:
    $ lim_(h -> 0 ) (f prime (0 + h) - f prime (0))/h $
    must exist.

    Consequently, to find the values of $n$ for which $f prime$ is differentiable, we must first find the derivative of $f$.

    The derivative of $f$ can be seen as a piecewise function for values of $a$ below 0, at 0, or above 0. Below and above zero we can just take the derivative of the respective piecewise cases of $f$, but at zero we need to use the definition of the derivative.

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
                  & lim_(h -> 0^- ) (f(h) - 0^n)/h \
                  & =lim_(h -> 0^- ) (h^n - 0^n)/h \
      "For" & n = 0: \
                  & =lim_(h -> 0^- ) (1 - 1)/h = lim_(h -> 0^- ) (0)/h = D.N.E\
      "For" "all" & n != 0: \
                  & =lim_(h -> 0^- ) (h^n)/h \
                  & =lim_(h -> 0^- ) (h^(n-1)) \
    $

    #align(center)[
      #table(
        columns: (auto, auto, auto),
        inset: 10pt,
        align: center,
        stroke: (x, y) => if x < 2 {
          (right: 0.7pt + black)
        },
        table.header([*$n < 1$*], [*$n = 1$*], [*$n > 1$*]),
        $ n - 1 < 0 \ lim_(h -> 0^- ) (h^(n-1))=D.N.E $,
        $ n - 1 = 0 \ lim_(h -> 0^- ) (h^(n-1))=1 $,
        $n - 1 > 0 \ lim_(h -> 0^- ) (h^(n-1))=0 \ "For our purposes,"\ h^(n-1) "is undefined"\ "for" h < 0 "when" n in.not ZZ \
        therefore "This only holds for" \
        n in ZZ$,
      )]


    $
      lim_(h -> 0^+ ) (f(h) - 0^n)/h \
      = lim_(h -> 0^+ ) (h^n cos (1/h) - 0^n)/h \
      "For" n = 0: \
      = lim_(h -> 0^+ ) (cos (1/h) - 1)/h = D.N.E\
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
      "When" n > 1, n in ZZ: wide f prime (0) = 0
    $


    Now we have the tools to solve the original limit.

    $
      & lim_(h -> 0 ) (f prime (0 + h) - f prime (0))/h wide "must exist" \
      & = lim_(h -> 0 ) (f prime (h) - 0)/h wide "for" n > 1, n in ZZ \
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
          "For our purposes,"\ h^(n-2) "is undefined"\ "for" h < 0 "when" n in.not ZZ \
          therefore "Again this only holds for" \
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

    The only values of $n$ for which the left and right hand limit both exist and are equal are $n > 3, n in ZZ$.

    #align(center)[
      #rect[$therefore f prime$ is differentiable at $x = 0$ for all $n > 3, n in ZZ$ ]
    ]


  + *For what values of $n$ is $f prime$ is continuous at $x = 0$?*

    For $f prime$ to be continuous at $x = 0$:

    $ lim_(x -> 0) f prime (x) = f prime (0) $

    Using our previously derived definition of $f prime$:
    $
      f prime (0) = 0 "when" n > 1, n in ZZ
    $
    Note that if $n < 1$ or $n in.not ZZ$, $f prime (0)$ does not exist.

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
          "For our purposes,"\ h^(n-1) "is undefined"\ "for" h < 0 "when" n in.not ZZ \
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

    Therefore:
    $
      & "When" n > 2, n in ZZ: wide lim_(x -> 0) f prime (x) = 0 \
      & "When" n > 1, n in ZZ: wide f prime (0) = 0
    $

    So $lim_(x -> 0) f prime (x) = f prime (0)$ holds only when $n > 2, n in ZZ$.

    #align(center)[
      #rect[$therefore f prime$ is continuous at $x = 0$ for all $n > 2, n in ZZ$ ]
    ]


+ *Escaping a predator. A large fish (predator) of (vertical) size $S$ is approaching a small fish (prey) at a constant speed $v$. Let $x(t)$ be the distance between the predator and the prey at time $t$.*

  #image("fishes.png")

  + *Find an expression for the rate of change of the visual angle θ perceived by the prey in terms of the size and speed of the approaching predator, and the predator's distance away from its prey. The visual angle is the angle subtended by an object at the eye of the observer.*

    We can construct the triangle:
    #align(center, cetz.canvas({
      import cetz.draw: *
      let x = 11
      line((0, 0), (x, 0), stroke: (dash: "dashed"), name: "x")
      line((0, 0), (0, 2), name: "S/2")
      line((0, 2), (x, 0))
      // Anchor at 30 degree

      // circle((x, 0), radius: 4, name: "theta")
      arc((x - 4, 0), start: 180deg, stop: 166deg, radius: 3, stroke: (thickness: 0.5pt), name: "theta")

      content(
        ("x.start", 50%, "x.end"),
        padding: .1,
        anchor: "north",
        box(fill: white, $ x(t) $),
      )

      content(
        ("S/2.start", 50%, "S/2.end"),
        padding: .1,
        anchor: "east",
        box(fill: white, $ S/2 $),
      )

      content((name: "theta", anchor: 50%), align(center, $theta/2$), padding: .1, anchor: "east")
    }))


    Therefore:

    $
      tan(theta/ 2) & = (S / 2) / x(t) \
              theta & = 2 tan^(-1)((S / 2) / x(t) ) \
              theta & = 2 tan^(-1)((S / 2)x(t)^(-1))
    $
    Since the predator is *approaching* the prey, the distance is decreasing at speed $v$. Therefore, the change in distance over time would be negative $v$.
    $
      (d x) / (d t) = -v
    $
    $
      (d theta) / (d t) & = 2 (( 1 / (1 + ((S / 2)x(t)^(-1))^2))(S / 2)(-1)x(t)^(-2)((d x) / (d t)) ) \
                        & = (-S x(t)^(-2) (-v) ) / (1 + (S^2 / 4)x(t)^(-2)) \
                        & = (S x(t)^(-2) v ) / (( (4 x(t)^2 + S^2) / (4 x(t)^2 ))) \
                        & = (S x(t)^(-2) v (4 x(t)^2 ) ) / (4 x(t)^2 + S^2) \
                        & = (4 S v ) / (4 x(t)^2 + S^2) \
    $

    $
      #rect[$ therefore (d theta) / (d t) & = (4 S v ) / (4 x(t)^2 + S^2) $]
    $

  + *As the predator approaches its prey, we expect the visual angle perceived by the prey to increase, as objects appear bigger when they are closer. Verify this is consistent with your result from part (a). Is the visual angle getting bigger faster or slower as the predator approaches its prey?*

    $
      (d theta) / (d t) & = (4 S v ) / (4 x(t)^2 + S^2) \
                        & = (4 S v ) (4 x(t)^2 + S^2)^(-1) \
    $
    Since $S > 0, v > 0, x^2 > 0$ the change in visual angle over time is always positive. In other words, the visual angle is always increasing with time. And since $x$ is decreasing with time ($(d x)/(d t) < 0$), the visual angle is getting larger as the predator approaches.

    #rect[Therefore, our results are consistent: as the predator approaches the prey the visual angle gets bigger.]

    $
      (d^2 theta) / (d^2 t) & = (4 S v ) (-1) (4 x(t)^2 + S^2)^(-2)(8 x(t))(-v) \
                            & = (32 S v^2 x(t) ) (4 x(t)^2 + S^2)^(-2) \
                            & = (32 S v^2 x(t) ) / (4 x(t)^2 + S^2)^2
    $

    For all $x > 0$, $(d^2 theta) / (d^2 t) > 0$. In other words $theta(t)$ is concave up on $x > 0$.

    #rect[Therefore, the visual angle is getting bigger faster as the predator approaches the prey.]

  + *Visual angles are important factors in studies of predator avoidance. A model proposed by L. Dill, a behavioural ecologist at Simon Fraser University, about the behaviour of the Zebra Danio (a small tropical fish) suggested that “Zebra Danios react to an approaching predator when the rate of change of the angle subtended by the predator at the prey's eye exceeds some threshold level” (L. Dill (1974) “The escape response of the Zebra Danio (Brachydanio rerio). I. The stimulus for escape.”, Animal Behaviour, 22, 711-722). Suppose an escape reaction is triggered when the rate of change of the visual angle reaches the threshold value $r_"crit"$. Using the model developed in part (a), find the distance $x_"react"$ between prey and predator at which an escape response is triggered.*

    An escape response is triggered when the derivative of the visual angle reaches $r_"crit"$, at which point the predator is a distance $x_"react"$ from the prey.

    $
                                       r_"crit" & = (d theta) / (d t) \
                                       r_"crit" & = (4 S v ) / (4 x_"react"^2 + S^2) \
                r_("crit")(4 x_"react"^2 + S^2) & = 4 S v \
      4 x_"react"^2 r_("crit") + S^2 r_("crit") & = 4 S v \
                                      x_"react" & = plus.minus sqrt((4 S v - S^2 r_("crit")) / (4 r_("crit"))) \
    $

    Since our model is only concerned with the predator approaching the prey from the front, we can drop the $plus.minus$ for the positive $x_"react"$.

    #align(center)[
      #rect($ therefore x_"react" & = sqrt((4 S v - S^2 r_("crit")) / (4 r_("crit"))) $)
    ]

  + *Using the model developed in part (a) and (c), explain why for a predator of a given size S your model requires a “hunting speed” $v > (S r_"crit") / 4$ in order to trigger an escape response by the prey.*

    $
      x_"react" & = sqrt((4 S v - S^2 r_("crit")) / (4 r_("crit")))
    $
    For $x_"react"$ to exist and not be 0 (the distance at which the predator eats the prey):
    
    $
      (4 S v - S^2 r_("crit")) / (4 r_("crit")) &> 0 \
      4 S v &> S^2 r_("crit") wide r_("crit") > 0 \
      // S &> 0 \ 
      v &> (S^2 r_("crit")) / (4S) wide S > 0 \
      v &> (S r_("crit")) / (4) \
    $
    // Since velocity is assumed to be negative in my model, we need some adjustments to show the relationship for a positive "hunting speed".

    // $
    //   "Hunting speed" > 0\
    //   v = -"Hunting speed" \
    //   -"Hunting speed" < (S r_("crit")) / (-4) \
    //   "Hunting speed" > (S r_("crit")) / (4) \
    //   "For" x_"react" "to exist:" wide "Hunting Speed" > (S r_("crit")) / (4) \
    // $

    #align(center)[
      #rect[Therefore, using the model derived in (c), for an escape response to be triggered: $ v > (S r_("crit")) / (4) $]]


  + *Again, using the model developed in part (a) and (c), for a given “hunting speed” $v$, what size S would not result in an escape response by the prey?*
    $
      x_"react" & = sqrt((4 S v - S^2 r_("crit")) / (4 r_("crit")))
    $
    For $x_"react"$ to exist and not be 0 (the distance at which the predator eats the prey):
    $
      (4 S v - S^2 r_("crit")) / (4 r_("crit")) &> 0 wide r_("crit") > 0\
      S(4v - S r_("crit")) &> 0 wide S > 0\
      4v - S r_("crit") &> 0 \
      4v &> S r_("crit") \
      (4v)/r_("crit") &> S \
      S &< (4v) / r_("crit") \
    $


    // Again, since velocity is assumed to be negative in my model, we need some adjustments to show the relationship for a positive "hunting speed".
    // $
    //   "Hunting speed" > 0\
    //   v = -"Hunting speed" \
    //   S < (4 times "Hunting speed") / r_("crit") \
    // $
    // $
    //   "For" x_"react" "to exist:" wide S < (4 times "Hunting speed") / r_("crit") \
    // $

    To determine the speed that will *not* trigger an escape response, we can just negate the less than (again ignoring the point at which $x_"react" = 0: S = (4 v) / r_("crit") $).
    $
      S &lt.not (4 v) / r_("crit") \
      S &> (4 v) / r_("crit") wide "ignoring" S = (4 v) / r_("crit") 
    $

    #align(center)[
      #rect[Therefore, using the model derived in (c), for an escape response to *not* be triggered: $ S > (4 v) / r_("crit") $]]



  + *Using your results found in parts (d) and (e), explain why large predators and slowing moving predators would have higher success rate at eating the small Zebra Danio.*

    If you are slow moving enough you can sneak up on the small Zebra Danio without the change in visual angle over time reaching the critical level $r_"crit"$ and triggering its escape response. 
    
  
    This is because for $x_"react"$ to exist and not be 0: 

    $ v > (S r_("crit")) / (4) $

    as developed in (d).

    Therefore for $x_"react"$ not to exist and not be 0 (when $v = (S r_("crit")) / (4) $): 

    $ 
    v &gt.not (S r_("crit")) / (4) \
    v &< (S r_("crit")) / (4) wide "ignoring" v = (S r_("crit")) / (4)
    $


    Similarly if you are large enough you can sneak up on the small Zebra Danio without the change in visual angle over time reaching the critical level $r_"crit"$ and triggering its escape response. This is because when:

    $ S > (4 v) / r_("crit") $

    $x_"react"$ does not exist, as developed in (e).

    #rect[Therefore, slow predators and large predators can approach the Zebra Danio without triggering its escape response, and in turn, they would have a higher success rate at eating it.]

