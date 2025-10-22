// math template
#import "@preview/numbly:0.1.0": numbly

#import "@preview/dashy-todo:0.1.2": todo


#set enum(
   full:true, 
   numbering: numbly("{1:1}.", "{2:(a)}" )
)


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
  
  By the Mean Value Theorem there exists some $c in (1, + infinity) $ such that: 

  $ 
  f prime (c) = (f(c) - f(1))/(c - 1) \
  1/c = (ln(c) - ln(1))/(c - 1)
  $
  Since we are only looking at $c > 1$: 
  $ 
    0 < 1/c < 1 \ 
    (ln(c) - ln(1))/(c - 1) = 1/c < 1  \ 
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
  
  By the Mean Value Theorem there exists some $c in (0, 1) $ such that: 

  $ 
  f prime (c) = (f(c) - f(1))/(c - 1) \
  1/c = (ln(c) - ln(1))/(c - 1)
  $
  Since we are only looking at $0 < c < 1$: 
  $ 
    1/c &> 1 \ 
    (ln(c) - ln(1))/(c - 1) &= 1/c > 1 \
    (ln(c) - ln(1))/(c - 1) &> 1 
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

  If the functions $P(t) = K e^((-b e^((-c t))))$ are solutions of the Gompertz equations, then it should satisfy the ordinary differential equation. 

  $
  P(t) = K e^((-b e^((-c t))))\
  P prime (t) = K e^((-b e^((-c t))))(-b e^((-c t)))(-c t) \ 
  P prime (t) = K c t b e^((-c t))e^((-b e^((-c t)))) \ 
  
  $




+ *Let 
  $ f(x) = cases(x^n cos(1/x) wide &"if" x > 0, x^n  &"if" x <= 0) $
  for $n > 0$. *
  + *For what values of $n$ is $f prime$ differentiable at x = 0?*
  + *For what values of $n$ is $f prime$ is continuous at x = 0?*
  
+ *Escaping a predator. A large fish (predator) of (vertical) size $S$ is approaching a small fish (prey) at a constant speed $v$. Let $x(t)$ be the distance between the predator and the prey at time $t$.*

  #image("fishes.png")

  + *Find an expression for the rate of change of the visual angle θ perceived by the prey in terms of the size and speed of the approaching predator, and the predator's distance away from its prey. The visual angle is the angle subtended by an object at the eye of the observer.*
  + *As the predator approaches its prey, we expect the visual angle perceived by the prey to increase, as objects appear bigger when they are closer. Verify this is consistent with your result from part (a). Is the visual angle getting bigger faster or slower as the predator approaches its prey?*
  + *Visual angles are important factors in studies of predator avoidance. A model proposed by L. Dill, a behavioural ecologist at Simon Fraser University, about the behaviour of the Zebra Danio (a small tropical fish) suggested that “Zebra Danios react to an approaching predator when the rate of change of the angle subtended by the predator at the prey's eye exceeds some threshold level” (L. Dill (1974) “The escape response of the Zebra Danio (Brachydanio rerio). I. The stimulus for escape.”, Animal Behaviour, 22, 711-722). Suppose an escape reaction is triggered when the rate of change of the visual angle reaches the threshold value $r_"crit"$. Using the model developed in part (a), find the distance xreact between prey and predator at which an escape response is triggered.*
  + *Using the model developed in part (a) and (c), explain why for a predator of a given size S your model requires a “hunting speed” $v > (S r_"crit") / 4$ in order to trigger an escape response by the prey.*
  + *Again, using the model developed in part (a) and (c), for a given “hunting speed” $v$, what size S would not result in an escape response by the prey?*
  + *Using your results found in parts (d) and (e), explain why large predators and slowing moving predators would have higher success rate at eating the small Zebra Danio.* 

