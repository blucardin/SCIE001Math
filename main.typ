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

  Let $f(x) = ln(x) - (x - 1)$. 



  *  Lemma 1: $f$ has at least one zero. 
  *  
  $
    f(1) = ln(1) - (1 - 1) = 0
  $

  Therefore $f(x)$ has one zero at $x = 1$. 
  

  *  Lemma 2: $f$ has only one zero. * 

  Proof by contrapositive. 
  
  Assume $f$ has more than one zero. Then there exists at least two values such that $f(a) = 0$ and $f(b) = 0$. 

  

  $ 
    ln(x) - (x - 1) < 0  \ 
    therefore ln(x) < x - 1
  $
  for all $x > 0, x != 1$. 
  

+ *Consider the “Gompertz” model of population dynamics,
  $ (d P)/(d t) = c P ln(K/P), wide P(0) = P_0 $
  where c and K are positive constants. Verify that the functions $P(t) = K e^((−b e^((−c t))))$, where b is a
  constant, are solutions of the Gompertz equation. Then find an expression for $b$ in terms of $P_0$.*
+ *Let 
  $ f(x) = cases(x^n cos(1/x) wide &"if" x > 0, x^n  &"if" x >= 0) $
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

