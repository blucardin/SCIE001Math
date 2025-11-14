// math template
#import "@preview/numbly:0.1.0": numbly

#import "@preview/dashy-todo:0.1.2": todo

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
   full:true, 
   numbering: numbly("{1:1}.", "{2:(a)}" )
)


// #set heading(numbering: "1.")

#align(center + horizon)[

  _#text(30pt)[
    HW1.3
  ] \ \
  *Climate Modeling*
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