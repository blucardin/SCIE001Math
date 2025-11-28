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
    "HW1.3"
    h(1fr)
    x
  }
})


#set enum(
  full: true,
  numbering: numbly("{1:(a)}"),
)

#let lim = math.limits(math.lim)

// #set heading(numbering: "1.")

#align(center + horizon)[

  _#text(30pt)[
    HW1.3
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

#outline(target: heading.where(supplement: [Regular]))

#outline(target: heading.where(supplement: [Appendix]), title: [Appendix])

// ]

#pagebreak()

// #set page(height: auto) // for intinite page


#show: regular

= Instructions
In this assignment you will be working on a mathematical model from climatology, the scientific field that study climate. There are two main parts in this assignment:

- In part A, you will learn about the guiding principles of mathematical modelling and you will apply

them to derive an ODE for the energy balance of the Earth-atmosphere system.
- In part B, you will study the behavior of solutions of the ODE for a particular set of parameter values.

There is a lot of information here. Read carefully and hand in a full solution to the questions in each part.
Note that some of the computations may get messy.

In the next Math tutorial, you will explore the same climate model described here and discover some interesting properties

#line(length: 100%)

== On Modelling
When approaching a modelling problem, mathematicians often start from fundamental principles (sometimes called first principles). We can think of these principles as the building blocks of science. For example, Newton's laws of motion and the laws of thermodynamics are fundamental principles from which we can build models from. Let's look more closely at the First Law of Thermodynamics.

The First Law of thermodynamics states that in a closed system, energy can neither be created nor destroyed, only altered in form. Thus, by “tracking” the energy of a system and how it is transformed, the First Law allows us to gain insight into the dynamics of the system.

When we apply this fundamental thermodynamics principle and write down equations expressing the energy balance occurring in a system, the resulting mathematical model is called *Energy Balance Model* (EBM).
In climatology, EBMs are used to build highly simplified models of the climate system. Despite their simplicity, EBMs can provide a reasonable conceptual approach to understanding climate changes.

#pagebreak()

= Part A
Here we will derive an EBM for the Earth-atmosphere system.

Our underlying assumption is that the Earth and its atmosphere are a closed system and thus the First Law of thermodynamics applies. This is reasonable considering that the Earth-atmosphere system does not exchange matter with the surrounding environment or space.

In our model, we assume the Earth-atmosphere system absorbs energy from the Sun as heat and emits thermal energy back into space as radiation, resulting in energy flowing in and out of the system. The energy balance in this process can be expressed as a simple ODE with only one dependent variable: the
Earth's average surface temperature. Let's see how.

We have the following variable definitions.

#figure()[
  #table(
    columns: 3,
    stroke: none,
    align: (left, left, left),
    table.header[*Symbol*][*Definition*][*Units*],
    table.hline(),
    [$q$], [Energy transfer due to heat], [$J$],
    [$C$], [Effective heat capacity of the Earth], [$J K^(-1)$],
    [$T > 0$], [Average surface temperature of the Earth], [$K$],
    [$E$], [Thermal energy], [$J$],
    [$P = (d E) / (d t)$], [Power], [$W$],
    [$t > 0$], [Time], [$s$],
  )
]

The EBM is based on the assumption that the Earth-atmosphere system gains and loses thermal energy
uniformly, and that the rate of change of the Earth's average surface temperature is proportional to the
difference between the incoming and outgoing rates of energy transfer due to thermal radiation. The resulting
equation is:
$
  C (d T)/(d t) = P_"in" -P_"out"
$

where $P_"in"$ and $P_"out"$ denote the power corresponding to, respectively, energy flowing in from the Sun and energy flowing out as the Earth's thermal radiation.

+ #example[
    #underline[*Your task:*] Derive the EBM given above and verify that the units on both sides of the equation agree. Use the following thermodynamics identities (here $Delta T$ and $Delta E$ are changes in temperature and energy over an interval in time $Delta t$):

    $
      q = C Delta T \
      q = q_"in" - q_"out" \
      q_"in" = Delta E_"in" wide "and" wide q_"out" = Delta E_"out" \
    $

    Note: the subscripts “in” and “out” refer to, respectively, energy flowing into and exiting the Earth-atmosphere system.
  ]

  We can start by combining some of the identities
  $
            q & = q_"in" - q_"out" \
            q & = Delta E_"in" - Delta E_"out" \
    C Delta T & = Delta E_"in" - Delta E_"out" \
  $

  We now divide both sides by the change in time $Delta t$ over which the temperature and energy is changing:
  $
    C (Delta T)/(Delta t) & = (Delta E_"in")/(Delta t) - (Delta E_"out")/(Delta t) \
  $

  Since $Delta T$ and $Delta E$ represent changes in $E$ and $T$ with respect to a finite change in time, $Delta t$ after some $t$, we can change their expressions to represent this.

  $
    C (T (t + Delta t) - T(t))/(Delta t) &= (E_"in" (t + Delta t) - E_"in" (t) )/(Delta t) - (E_"out" (t + Delta t) - E_"out" (t) )/(Delta t) \
  $

  Next take the limit of both sides as the change in time approaches $0$.

  Note, we are making the simplification/assumption that $C$, the heat capacity of the earth, does not change with time.
  $
    lim_(Delta t -> 0) C (T (t + Delta t) - T(t))/(Delta t) &= lim_(Delta t -> 0) ((E_"in" (t + Delta t) - E_"in" (t) )/(Delta t) - (E_"out" (t + Delta t) - E_"out" (t) )/(Delta t)) \
    C lim_(Delta t -> 0) (T (t + Delta t) - T(t))/(Delta t) &= lim_(Delta t -> 0) (E_"in" (t + Delta t) - E_"in" (t) )/(Delta t) - lim_(Delta t -> 0) (E_"out" (t + Delta t) - E_"out" (t) )/(Delta t) \
  $
  Where $T(t)$ and $E(t)$ represents the temperature and energy at time $t$ respectively.

  Now we can rewrite this with Leibnitz notation:

  $
    C (d T) / (d t) & = ( d E_"in" (t) ) / (d t) - ( d E_"in" (t) ) / (d t) \
  $

  Change in energy over time is power, so we can simplify.

  $
    (d E) / (d t) = P \
    C (d T) / (d t) = P_"in" - P_"out" \
  $

  Now we can check units:
  $
    C [J K^(-1)] (d T [K]) / (d t [s]) = P_"in" [W] - P_"out" [W] \
  $

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

  #colbreak()

+ #example[Assume that the amount of solar energy reaching the Earth's surface per unit time per square meter is a constant Q, and that the Earth's surface is a sphere of radius $r$. The _albedo_ of the Earth $alpha in [0, 1]$ is defined to be the proportion of incoming solar energy that is reflected away from the Earth's surface.

    #underline[*Your task:*] Justify why the power corresponding to energy flowing in from the Sun is given by

    $
      P_"in" = pi r^2 Q(1 - alpha)
    $

    and verify this equation has consistent units.
  ]
  *Lemma 1: $1 - alpha$ represents the proportion of solar energy absorbed. *

  $alpha$ represents the proportion of incoming solar energy reflected away relative to the total solar energy that hits earth:
  $
    alpha = "reflected solar energy" / "total solar energy"
  $
  We can assume that all solar energy that is not reflected is absorbed. So it follows:
  $
    "reflected solar energy" + "absorbed solar energy" = "total solar energy"
  $
  So we can rearrange for the proportion of absorbed solar energy to total solar energy.
  $
    "absorbed solar energy" = "total solar energy" - "reflected solar energy" \
    "absorbed solar energy" / "total solar energy" = "total solar energy" / "total solar energy" - "reflected solar energy" / "total solar energy"
  $
  Therefore:
  $
    "absorbed solar energy" / "total solar energy" = 1 - alpha
  $

  *Lemma 2: $pi r^2$ represents surface area of the earth from the perspective of the sun.*

  Assume the earth is a perfect sphere, the number of rays originating at the sun that would hit it is no different than if it was a perfect circle facing the sun at the same distance.

  Therefore, we can approximate the area that the sun transfers energy to as the area of a circle with the same radius as our idealized earth.

  So, the effective solar heating area is:
  $
    pi r^2
  $

  *Putting it all together*

  Logically, the solar energy that the earth absorbs over time should be equal to the amount of solar energy reaching the Earth's surface per unit time per square meter times the effective surface area that receives the energy, times the proportion of this energy that is absorbed.

  Modeling this mathematically using Lemma 1 and Lemma 2:

  $
              P_"in" & = Q (pi r^2)(1 - alpha) \
    therefore P_"in" & = pi r^2 Q (1 - alpha) \
  $

  Checking units:
  $
    P_"in" [W] = pi (r[m])^2 (Q [J s^(-1) m^(-2) ]) (1 - alpha)
  $

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
        & = W \
        // & = J / s \
        // & = W
      $,

      $
        & = m^2 J s^(-1) m^(-2) \
        & = J s^(-1) \
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

  #colbreak()

+ #example[An expression for $P_"out"$ can be derived by first considering the Earth to be a blackbody which perfectly radiates energy at a rate proportional to the fourth power of its temperature (for more information, look up the Stefan-Boltzmann Law in your Physics notes). Under the blackbody assumption, the maximum rate at which energy can be radiated by the Earth is given by $P_"out" = A sigma T^4$, where A is the surface area of the Earth and sigma is the Stefan-Boltzmann constant with units $W m^(-2) K^(-4)$. However, since the Earth does not radiate perfectly an additional term $epsilon in [0,1]$ is introduced (called the emitted fraction) which represents the proportion of this theoretical maximum energy output that is actually radiated away from the Earth and into space.

    #underline[*Your task:*] Justify why the power corresponding to energy flowing out as radiation is given by
    $
      P_"out" = 4 pi r^2 sigma epsilon T^4
    $
    and verify this equation has consistent units.
  ]

  If the earth was a perfect black body, then its power output would be:
  $
    P_"out blackbody" = A sigma T^4
  $
  Since the earth does not radiate perfectly, only a portion of this energy $epsilon in [0,1]$ is being radiated. So our power output would be:
  $
    P_"out" = A sigma epsilon T^4
  $

  If we make the assumption/simplification that the earth is a perfect sphere, its surface area would be:
  $
    A = 4 pi r^2
  $

  Combing these expressions:
  $
    P_"out" = 4 pi r^2 sigma epsilon^4
  $

  Checking units:
  $
    P_"out" [W] = 4 pi (r [m])^2 sigma (epsilon [W m^(-2) K^(-4)]) (T [K])^4
  $

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
        & = W \
        // & = J / s \
        // & = W
      $,

      $
        & = m^2 W m^(-2) K^(-4) K^4 \
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

  #colbreak()

+ #example[For this model, albedo is assumed to be negatively correlated with temperature because colder temperatures tend to result in increased snow and ice coverage, yielding lighter coloured surfaces that reflect more light.

    Let's say that experimental evidence indicates that the albedo of the Earth is approximately constant at 0.7 below 247K and 0.3 above 282K. Let's use the following piecewise function for albedo, where $f$ is an unknown function,

    $
      alpha(T) = cases(
        0.700 "for" T<= 247 K,
        f(T) "for" 247K < T < 282K,
        0.300 "for" T >= 282K
      )
    $

    #underline[*Your task:*]  Find a suitable linear function $f(T) = a T + b$ such that $alpha(T)$ is continuous for all T. Keep at-least five sig-figs in each number you report (these will be needed for later calculations).
  ]
  Above $282 K$ and below $247 K$, $alpha(T)$ is constant, and is therefore continuous.
  Between $282 K$ and $247 K$, $alpha(T) = f(T) = a T + b$ which is linear, and therefore continuous.

  The only points where $alpha(T)$ could be discountinuous are at $T = 282 K$ and $T = 247 K$, so we can solve for $a$ and $b$ such that the function is continuous at those points, and therefore will be continuous at all points.

  For a function $f$ to be continuous at $x = a$:
  $
    lim_(x -> a )f(x) = f(a)
  $

  For $alpha(T)$ to be continuous at $T = 282 K$ and $T = 247 K$ :

  $
    lim_(T -> 247 )alpha(T) = alpha(247) wide lim_(T -> 282 )alpha(T) = alpha(282)
  $

  Both of these limits split,

  $
    lim_(T -> 247^- )alpha(T) = alpha(247) wide lim_(T -> 247^+ )alpha(T) = alpha(247) wide lim_(T -> 282^- )alpha(T) = alpha(282) wide lim_(T -> 282^+ )alpha(T) = alpha(282)
  $

  There are two cases that do not provide us with any information:

  #align(center)[

    #table(
      columns: (auto, auto),
      inset: 10pt,
      align: center,
      stroke: (x, y) => if x == 0 and y >= 1 {
        (right: 0.7pt + black)
      },
      table.header([*  $ lim_(T -> 247^- )alpha(T) = alpha(247) $*], [*$lim_(T -> 282^+ )alpha(T) = alpha(282)$*]),

      table(
        columns: (auto, auto),
        inset: 10pt,
        align: center,
        stroke: (x, y) => if x == 0 and y >= 1 {
          (right: 0.7pt + black)
        },
        table.header([*Left Side*], [*Right Side*]),

        $
          = 0.700
        $,

        $
          = 0.700
        $,
      ),

      // $
      //   W = W
      // $

      table(
        columns: (auto, auto),
        inset: 10pt,
        align: center,
        stroke: (x, y) => if x == 0 and y >= 1 {
          (right: 0.7pt + black)
        },
        table.header([*Left Side*], [*Right Side*]),

        $
          = 0.300
        $,

        $
          = 0.300
        $,
      ),

      [*Left Side = Right Side *],

      [*Left Side = Right Side *],
    )

  ]

  Then we get to the two interesting cases:

  #align(center)[

    #table(
      columns: (auto, auto),
      inset: 10pt,
      align: center,
      stroke: (x, y) => if x == 0 and y >= 1 {
        (right: 0.7pt + black)
      },
      table.header([*  $ lim_(T -> 247^+ )alpha(T) = alpha(247) $*], [*$lim_(T -> 282^- )alpha(T) = alpha(282)$*]),

      table(
        columns: (auto, auto),
        inset: 10pt,
        align: center,
        stroke: (x, y) => if x == 0 and y >= 1 {
          (right: 0.7pt + black)
        },
        table.header([*Left Side*], [*Right Side*]),

        $
          = f(247)
        $,

        $
          = 0.700
        $,
      ),

      // $
      //   W = W
      // $

      table(
        columns: (auto, auto),
        inset: 10pt,
        align: center,
        stroke: (x, y) => if x == 0 and y >= 1 {
          (right: 0.7pt + black)
        },
        table.header([*Left Side*], [*Right Side*]),

        $
          = f(282)
        $,

        $
          = 0.300
        $,
      ),
    )

  ]

  For these limits to hold, *Left Side* must equal *Right Side*, therefore:

  $
       f(247) & = 0.700 wide f(282)    & = 0.300, \
    247 a + b & = 0.700 wide 282 a + b &  = 0.300 \
  $
  Subtracting left from right gives:

  $
    35a & = -0.4 \
      a & = -0.01142857143 \
        \
      b & = 0.700 - 247 a \
      b & = 0.700 - 247 (-0.01142857143) \
      b & = 3.5228571432
  $

  Therefore:
  $
    #rect($f(T) = -0.01142857143T + 3.5228571432$)
  $

  #colbreak()

= Part B
Combining all the pieces from Part A yields the following EBM:

$
  C (d T) / (d t) = pi r^2 Q(1 -alpha (T)) - 4 pi r^2 sigma epsilon T^4
$

where the albedo $alpha(T)$ is given by the piecewise function described in Part A(d).

For the remaining parts of this assignment, use the expression for f you found in Part A(d), and use the following parameter values:

$
      C & = 1.0 times 10^23 J K^(-1) \
      r & = 6.3781 times 10^6 m \
      Q & = 1365 W m^(-2) \
  sigma & = 5.6704 times 10^(-8) W m^(-2) K^(-4) \
$

+ #example[Note that the value for the emitted fraction, epsilon, is not given. We will estimate it from a graph.

    Below is the graph of the function $T(t)$ that solves the EBM with a particular initial value $T_0 = 267K$,
    where the arrow indicates the approximated value of the slope of the solution function at $T = 278K$.

    Note that time is expressed in years.

    #underline[*Your task:*]  Using the information provided in the figure and the parameters given above for the
    EBM, estimate the value of epsilon to one decimal place. Show which exact equation you're solving. Give the numerical value you found, there is no need to show intermediate steps.

    #figure(
      image("images/0.png"),
      caption: [
        Solution to the EBM with $T_0 = 267K$. The slope of the solution curve at $T = 278K$ is $3.2 K y^(-1)$.
      ],
    )]

  We are solving:
  $
    C (d T) / (d t) = pi r^2 Q(1 -alpha (T)) - 4 pi r^2 sigma epsilon T^4 \
    C (d T) / (d t) = pi r^2 ( Q(1 -alpha (T)) - 4 sigma epsilon T^4)
  $
  for $epsilon$.

  Note, we have to convert years to seconds.

  $
    (3.2 K y^(-1)) ((1 y)/(60 "s/min" times 60 "min/hour" times 24 "hours/day" times 365 "days/y") )) = 0.000000101471334 K s^(-1)
  $


  Now we solve for $epsilon$:
  #[
    #set text(0.75em);
    $
      (1.0 times 10^23) ( 0.000000101471334) = pi (6.3781 times 10^6)^2 ( (1365)(1 - ( -0.01142857143(278) + 3.5228571432))) - 4 (5.6704 times 10^(-8)) epsilon (278)^4) \
      4 (5.6704 times 10^(-8)) epsilon (278)^4 = (1365)(1 - ( -0.01142857143(278) + 3.5228571432 ))) - (((1.0 times 10^23) ( 0.000000101471334)) / (pi (6.3781 times 10^6)^2)) \
      epsilon = ((1365)(1 - ((-0.01142857143(278) + 3.5228571432))) - (((1.0 times 10^23) ( 0.000000101471334)) / (pi (6.3781 times 10^6)^2)) ) / ( 4 (5.6704 times 10^(-8)) (278)^4) \
    $
  ]

  $
    #rect[$ epsilon = 0.6006374223 $]
  $

+ #example[The code provided in the Appendix at the end of this assignment does two things: using the set of parameters given above, 1) it plots the functions $P_"in" = pi r^2 Q(1 -alpha)$ and $P_"out" = 4 pi r^2 sigma epsilon T^4$, using the piecewise function for albedo defined in Part A(d), and a given value of epsilon, and 2) it prints the points of intersection of the graphs of $P_"in"$ and $P_"out"$.

    #underline[*Your task:*] Explain what the temperature values output by the code represent with respect to the EBM as an ODE, and why we are interested in them.]

  The values output by the code represent the temperatures of the points of intersection of the graphs of $P_"in"$ and $P_"out"$. In other words, the temperatures where $P_"in"$ = $P_"out"$. This is important because in our equation for the change in temperature over time these values are subtracted, meaning that when they are equal, the temperature will not change.

  $
    C (d T)/(d t) = P_"in" -P_"out" \
  $
  #v(10pt)
  $
    "If" P_"in" = P_"out": \
          P_"in" - P_"out" & = 0 \
             C (d T)/(d t) & = 0 \
     therefore (d T)/(d t) & = 0
  $

  When $(d T)/(d t)(T) = 0$, there exists an equilibrium solution at T, as the system's temperature is not changing relative to time at that temperature.

  Therefore, these points of intersection represent temperatures that are equilibrium solutions to the EMB where (in our model) the temperature of the earth would stay static.

  #figure(
    image("images/powerInVsPowerOut.svg"),
    caption: [#todo("add captions")],
  ) <powerInVsOut>

+ #example[Let $T_"eq"$ denote any equilibrium solution to the EBM.

    #underline[*Your task:*] Using the value of $epsilon$ you found in Part B(a), find all values for $T_"eq"$ and determine whether they are stable, unstable, or neither, and briefly explain why. Round your answers to whole numbers.

    You can use the code provided in the Appendix to find the necessary information to answer this question.]

  Since we have defined our EBM as:
  $
    C (d T)/(d t) = P_"in" -P_"out"
  $
  We can find the change in temperature over time at each time step using:
  $
    (d T)/(d t) = (P_"in" -P_"out")/C
  $
  Using the code in @app1, we can generate $P_"in"$ and $P_"out"$ at different temperatures, then using the above formula, calculate the change in temperature over time.

  Plotting our change in temperature over time relative to the temperature, we get:


  #figure(
    image("images/changeInTempVsTemp.svg"),
    caption: [#todo("add captions")],
  )
  See @pythonderivativegraph, for the code to generate this graph.


  The points at which $(d T)/(d t)$ equals zero are equilibrium solutions where the temperature does not change, and how it touches the zero line shows the equilibrium solution's stability.

  Therefore there is a stable equilibrium at $T_"eq" = 233.73 K$ and $T_"eq" = 289.29 K$ because as we approach that temperature from the left (temperatures below equilibrium), the derivative is positive, causing the temperature to increase over time towards the equilibrium, and as we approach from the right (temperatures above equilibrium), the derivative is negative, causing the temperature to decrease over time towards equilibrium.

  In addition, there is an unstable equilibrium at $T_"eq" = 261.26 K$ because as we approach from the left, the derivative is negative, decreasing temperature over time away from equilibrium, and from the right, positive, increasing temperature over time, again away from equilibrium.

  This is confirmed by @slopeField, as we can see from the slope fields that the temperature slopes' point towards $233.73 K$ and $289.29 K$ and away from $261.26 K$ even though they all provide no change in temperature over time at that temperature.

  Note: This could also be inferred from @powerInVsOut by looking at when $P_"in"$ is greater than, less than, or equal to $P_"out"$, but this is method is more fun.





+ #example[#underline[*Your task:*] Draw the slope field for the EBM using the value of $epsilon$ that you found in Part B(a) and determine $lim_(t -> infinity) T$ for all initial values of $T_0 in (200K,300K)$. Keep in mind that the code provided in the Appendix can help you gain information useful for sketching the desired slope field.]

  #figure(
    image("images/slopeField.svg"),
    caption: [#todo("add captions")],
  ) <slopeField>

  See @pythonslopefield, for the code to generate this graph.

  #todo("Add hand drawn slope field")

  #todo("Finish this question")

+ #example[#underline[*Your task:*] Which equilibrium solution gives the closest temperature value to the current average surface temperature of the Earth?]

  #let s(x) = calc.round(x, digits: 2);
  #let anomaly_temp = 1.29
  #let old_average_temp = 13.9
  #let surface_temp = ((anomaly_temp + old_average_temp) + 273.15);
  #let closest_equilibrium_temp = 289.29
  According to the #link("https://www.climate.gov/news-features/understanding-climate/climate-change-global-temperature")[National Oceanic and Atmospheric Administration], the average global surface temperature of earth is now $#anomaly_temp degree C$ above the 20th century average of $#old_average_temp degree C$. In kelvin that sums to $#s(surface_temp) degree K$. This is $#s(closest_equilibrium_temp - surface_temp) degree C$ away from our last equilibrium temperature of $#s(closest_equilibrium_temp) degree K$

#pagebreak()

#show: appendix

= Guide to Finding Intersection Points of $P_"in"$ and $P_"out"$ in Python<app1>
Create a new Jupyter notebook using anaconda. Copy and paste the following lines of code into a new cell.

```python

# define the constants
C = 1e23
r = 6.3781e6
Q = 1365
sigma = 5.6704e-8
# generate a function for the albedo values
temp = [200,247,282,340]
albedo = [0.7,0.7,0.3,0.3]
alpha = lambda T: np.interp(T,temp,albedo)
# temperature axis
T_eq = np.linspace(0,500,1000)

def plot(epsilon):
    eps = epsilon # choose emissivity
    # Define power in and power out functions
    P_in = np.pi * r**2 * Q * (1 - alpha(T_eq))
    P_out = 4 * np.pi * r**2 * sigma * eps * T_eq**4
    # Plot function
    plt.plot(T_eq, P_in, 'b-.', label=r'$P_{in}$') # plot LHS
    plt.plot(T_eq, P_out, 'r', label=r'$P_{out}$') # plot RHS
    plt.title("Power in vs. Power out for the Energy Balance Model")
    plt.xlabel('Temperature, T(t) (Kelvin)') # x axis label
    plt.ylabel('Power P(T) (W)') # y axis label
    plt.grid() # add grid to plot
    plt.xlim([230,310]) #x axis range
    plt.ylim([5e16,1.4e17]) #y axis range
    plt.legend(loc='upper left') # add legend
    plt.gca().get_yaxis().set_major_formatter(ticker.FormatStrFormatter('%.2e'))
    # Find intersection points
    idx = list(filter(lambda x: ((T_eq[x] < 310) and (T_eq[x] > 230)),
    np.argwhere(np.diff(np.sign(P_in - P_out))).flatten()))

    if len(idx) == 0:
        print("No intersection points found!")
    else:
        print("Intersection points:")

    for i in idx:
        print(" T:", round(T_eq[i],2), "P: ", '{:0.2e}'.format(P_in[i]))

    plt.plot(T_eq[idx], P_in[idx], 'ko')
    plt.show()
```

Now you can create a new cell and call the following method to generate a graph of $P_"in"$ vs. $P_"out"$. This will also print out the intersection points for a given epsilon (e.x. here $epsilon = 0.3$).

```python
plot(0.3) # plot P_in vs. P_out for given epsilon
```

#pagebreak()

= Code for Generating Slope Field  <pythonslopefield>
I wrote some code to generate the slope field of the EBM.
```python
num_times = 30
times = np.linspace(0, 60 * 60 * 24 * 365 - 1, num_times)
derivativeT = (P_in - P_out)/C

top_cut = 310
bottom_cut = 200

cut_temps = T_eq[(T_eq > bottom_cut) & (T_eq < top_cut)]
cut_derivatives = derivativeT[(T_eq > bottom_cut) & (T_eq < top_cut)]

num_temps = 50
idx = np.round(np.linspace(0, len(cut_temps) - 1, num_temps)).astype(int)
temps = cut_temps[idx]

derivatives_reduced = cut_derivatives[idx]

coords_x = np.array([])
coords_y = np.array([])
derivative_at_coordinate = np.array([])

for time in times:
    coords_x = np.concatenate((coords_x, np.full((len(temps), ), time)))
    coords_y = np.concatenate((coords_y, temps))
    derivative_at_coordinate = np.concatenate((derivative_at_coordinate, derivatives_reduced))

maxDerivative = max(derivative_at_coordinate)
vector_derivative_y = derivative_at_coordinate/maxDerivative
vector_derivative_x =  np.full((len(coords_x), ), 1)
magnitudes = np.sqrt(vector_derivative_y **2 + vector_derivative_x**2)

M = derivative_at_coordinate

norm_deriv_vector_y = vector_derivative_y / magnitudes
norm_deriv_vector_x = vector_derivative_x / magnitudes

fig, ax = plt.subplots()
x_times =  coords_x / (60 * 60 * 24)

q = ax.quiver(x_times, coords_y, norm_deriv_vector_x, norm_deriv_vector_y, M, headwidth=0, scale=24)

plt.xlim((min(x_times), 365))
plt.ylim((min(coords_y), max(coords_y)))
plt.title("Slope Field of Temperature over Time in Energy Balance Model")
plt.xlabel("Time Since Start of Year (Days)")
plt.ylabel("Temperature (K)")
plt.show()
fig.savefig("images/slopeField.svg")

```

= Code for Generating a Graph of $(d T)/(d t)$ to T <pythonderivativegraph>

```python

derivativeT = (P_in - P_out)/C

top_cut = 310
bottom_cut = 200

cut_temps = T_eq[(T_eq > bottom_cut) & (T_eq < top_cut)]
cut_derivatives = derivativeT[(T_eq > bottom_cut) & (T_eq < top_cut)]
fig, ax = plt.subplots()

ax.axhline(y=0, color="black", linestyle="--")
colors = ["green", "purple", "orange"]
for temp, color in zip(intersections, colors):
    ax.axvline(x=temp, linestyle="--", label="$\\frac{dT}{dt} (" + f"{temp:.2f}" + ") = 0 $ ", color=color) # color="red"

plt.title("Predicted Change in Temperature over Time given Temperature for EBM")
# plt.xlim((200, 350))
# plt.ylim((-1.5e-6, 0.25e-6))
plt.legend()
plt.xlabel('Temperature, (Kelvin)') # x axis label
plt.ylabel("Change in Temperature per Second, $\\frac{dT}{dt}$(T) (K/s)") # y axis label
plt.plot(cut_temps, cut_derivatives, 'b-') # plot LHS
ax.margins(x=0.00, y=0.000)
plt.show()
fig.savefig("images/changeInTempVsTemp.svg")

```
