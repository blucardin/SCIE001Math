#import "@preview/ctheorems:1.1.3": *
#import "@preview/physica:0.9.5": *
#import "@preview/mannot:0.2.2": markrect
#import "@preview/equate:0.3.2": equate
#show heading: set block(above: 1.5em, below: 0.8em)
#set par(leading: 1.0em)

// https://github.com/typst/typst/discussions/1917#discussioncomment-6703472
// https://github.com/typst/typst/issues/779#issuecomment-2702268234
// --------------------------------------------

/// Metadata marker for enum items labels,
/// used to allow reference with the `enum-label` function
#let enu-label-mark = metadata("enumeration_label")

/// Add a label to an enumeration item.
///
/// Used as:
/// ```typ
/// + #enum-label("first")first
/// + second
///   + third #enum-label[third]
///
/// I can ref @first and @third[It.]
/// // I can ref Item~1 and It.~3
/// ```
///
/// The label can be used anywhere in the enumeration item.
/// Calling enum-label works with str or text content.
#let enum-label(label) = {
  if type(label) == content {
    // informative error message
    assert(label.has("text"), message: "enum-label requires text content")
    label = label.text
  }
  [#enu-label-mark#std.label(label)]
}

/// Counter name for tracking of enumeration items
#let enum-counter-name = "enum-counter"
/// State for tracking the numbering format of enumeration items
#let enum-numbering-state = state("enum-numbering", none)

/// Wrapper for enum numbering to allow for a references to enum items.
/// The desired numbering format is passed as an argument (str or function)
/// To reference an item use `enum-label` function.
///
/// ```typ
///
/// #set enum(numbering: wrapped-enum-numbering("1.1"), full: true)
/// + #enum-label("one")first
/// #set enum(numbering: wrapped-enum-numbering("I.1"), start: 2)
/// + second
///   + third #enum-label[another]
///
// One is @one[] and another is @another[] // One is 1 and another is II.2
/// ```
#let wrapped-enum-numbering(numbering) = {
  let enum-numbering = (..it,) => {
    enum-numbering-state.update(x => numbering)
    counter(enum-counter-name).update(it.pos())
    std.numbering(numbering, ..it)
  }
  enum-numbering
}


/// Copy from tools4typst
/// return true if value is an empty array, dictionary, string or content
#let is-empty(value) = {
  let empty-values = (
    array: (),
    dictionary: (:),
    str: "",
    content: [],
  )
  let t = repr(type(value))
  if t in empty-values {
    return value == empty-values.at(t)
  } else {
    return value == none
  }
}


#show ref: it => {
  let el = it.element
  if el != none and el.func() == metadata and el == enu-label-mark {
    let supp = it.supplement
    if supp == auto {
      supp = none // modified to use no supplement
    }

    // get the counter value in the correct format according to location
    let loc = el.location()
    let ref-counter = context numbering(state("enum-numbering").at(loc), ..counter(enum-counter-name).at(loc))
    if is-empty(supp) {
      link(el.location(), ref-counter)
    }
    else {
      link(el.location(), box([#supp~#ref-counter]))
    }
  } else if it.element != none and it.element.func() == math.equation {
    // optional: wrap inside link, so whole label is linked
    link(it.target)[(#it)]
  } else {
    it
  }
}
// --------------------------------------------


#show: equate.with(breakable: true)
#set math.equation(
  numbering: "(1)",
  supplement: none
)
#set enum(
  numbering: wrapped-enum-numbering("(a)"), 
  indent: 1em
)

#show: thmrules.with(qed-symbol: $square$)
#let theorem = thmbox(
    "theorem",
    "Theorem",
    base_level: 0,
    titlefmt: smallcaps,
    fill: color.lighten(color.blue, 80%),
).with(numbering: none)
#let proof = thmproof("proof", "Proof")

#let lemma = thmbox(
    "lemma",
    "Lemma",
    base_level: 0,
    titlefmt: smallcaps,
    fill: color.lighten(color.gray, 80%),
)

#let definition = thmbox(
    "definition",
    "Definition",
    base_level: 0,
    titlefmt: smallcaps,
    fill: color.lighten(color.gray, 80%),
).with(numbering: none)

#let problem = thmbox(
    "problem",
    "Problem",
    base_level: 0,
    titlefmt: smallcaps,
    fill: color.lighten(color.green, 80%),
).with(numbering: none)

// Prevent inline equations from breaking across lines
// #show math.equation: it => box[#it]

// Various handy shortcuts
#let lim = $limits(lim)$
#let bigsp = $quad quad quad$
#let implies = $bigsp=>bigsp$
#let pads = $space.narrow$
#let r = h(1fr)
#let th = super[th]


= Typst Example Template

#definition[
  A bijective function $f: A->B$ has an _inverse_ function $f^(-1): B->A$ when \ $f^(-1) compose f = id_A$ and $f compose f^(-1) = id_B$. #r (As defined in class.)
]<inverse_def>

#lemma[
  If $T: V->W$ is a linear map and $dim V = dim W$ where $V$ and $W$ are finite-dimensional, then the following statements are equivalent:
  + #enum-label("t-iso") $T$ is an isomorphism
  + #enum-label("t-inj") $T$ is injective
  + #enum-label("t-sur") $T$ is surjective
  + #enum-label("dv-rt") $dim V = rank T$
]<iso_equiv>

I can reference list items. For example: @t-iso implies @t-inj.

#lemma[
  Let $T: V->W$ be a linear map and $B subset.eq V$ be a basis. Then $T$ is an isomorphism if and only if $T(B)$ is a basis of $W$.
]<iso_image_basis>

#lemma[
  If $V$ and $W$ are finite-dimensional then $V$ and $W$ are isomorphic if and only if $dim V = dim W$.
]<equal_dim>


== Problem 1

#theorem[
  Let $V$ and $W$ be $F$-vector spaces and suppose that $W$ is finite-dimensional. If $S$ and $T$ are linear maps from $V$ to $W$, then $ker S = ker T$ if and only if there exists an isomorphism $I: W -> W$ such that $S = I compose T$.
]

#proof[
  Here I can write my proof. Equations such as $
    H(w) = a_1 H(T(v_1)) + dots + a_m H(T(v_m)) &= 0 \
    implies a_1 S(v_1) + dots + a_m S(v_m) &= 0 #<vkers>
  $ are automatically numbered on every line, and I can talk about a particular line with a dynamic reference such as (@vkers). I can also create an equation without a number such as $
    T(v) = a_1 T(v_1) + dots + a_m T(v_m) pads. #<equate:revoke>
  $

  If I want to reference another item, for example, I can link to @equal_dim.
]


== Problem 3

#problem(number: "3.1")[
  Define the following linear map: $
    T: &&M_(2 times 2)(RR) &-> M_(2 times 2)(RR) #<equate:revoke> \
       &&mat(a,b;c,d) &mapsto mat(a+b,b;c,c+d) #<equate:revoke>
  $

  Determine if $T$ is an isomorphism.
]

After restating the problem, I can write my solution here... I can put a box around my final answer if I want to highlight it: $
  f(x) = quad markrect(2 + sqrt(2), padding: #0.5em) quad pads.
$

#problem(number: "3.2")[
  Define the following linear map: $
    T: &&M_(2 times 2)(RR) &-> cal(P)_2(RR) #<equate:revoke> \
       &&mat(a,b;c,d) &mapsto a + 2b x + (c+d)x^2 #<equate:revoke>
  $

  Determine if $T$ is an isomorphism.
]

etc.

