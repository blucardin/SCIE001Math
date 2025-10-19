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
    Math Assignment Template 
  ] \ \
  *Subtitle*
  _

  // #show heading: it => pad(left: 1em * (it.level - 1), it)

  SCIE 001 Math

  #let today = datetime.today()

  #today.display("[month repr:long]") 
  #today.day(), #today.year()// or another custom format

]

#pagebreak()

+  
  + *Construct a function $f$ such that $lim_(x->1^+)  f(x) = 3 + lim_(x→1^−) f(x) $ Your answer should include a definition of $f$ using  mathematical notation. You should also sketch a graph of $f$.*
    $ f(x) = cases(0 "if" x < 1, 3 "if" x > 1 )  $