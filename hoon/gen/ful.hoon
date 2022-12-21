:: nunc dies 8: ~ful
/*  input  %txt  /lib/aoc2022/ful/txt
:-  %say  |=  *
=<  [%noun part-1=part-1 part-2=part-2]
|%
++  part-1
  =/  vis=(list (list ?))
    (map-forest forest is-visible)
  |-
  ?~  vis  0
  %+  add
    %+  roll
      (turn `(list ?)`-:vis |=(v=? ?:(v 1 0)))
    add
  $(vis +:vis)
++  part-2
  =/  scenery=(list (list @u))
    (map-forest forest scenic-score)
  (roll (turn scenery |=(row=(list @u) (roll row max))) max)
::  +map-forest: map of forest with computed information
++  map-forest
  |*  [trees=woods f=$-([woods @u @u] *)]
  =>  .(trees (homo trees))
  ^-  (list (list _?>(?=(^ trees) (f i.trees @u @u))))
  =|  i=@u  =|  j=@u
  =/  [tall=@u wide=@u]  (dim trees)
  |-
  ?:  =(i tall)  ~
  :-  |-
      ?:  =(j wide)  ~
      :-  (f trees i j)
      $(j +(j))
  $(i +(i), j 0)
::  +dim: compute dimensions for forest
++  dim
  |=  trees=woods
  :-  (lent trees)  (lent (snag 0 trees))
::  $woods: grid of trees
+$  woods  (list (list @u))
::  +scenic-score: product of viewing distances in cardinal directions
++  scenic-score
  |=  [trees=woods i=@u j=@u]  ^-  @u
  =/  [tall=@u wide=@u]  (dim trees)
  =/  height  (snag j (snag i trees))
  =/  view
    |=  dir=(list @u)
    ?~  dir  0
    ?:  (gte -:dir height)  1
    +($(dir +:dir))
  =/  row  (snag i trees)
  =/  col  (turn trees |=(r=(list @u) (snag j r)))
  =/  east   (slag +(j) row)      =/  west   (flop (scag j row))
  =/  north  (flop (scag i col))  =/  south  (slag +(i) col)
  ;:  mul
    (view north)
    (view east)
    (view south)
    (view west)
  ==
::  +is-visible: if a tree at given indices is visible
++  is-visible
  |=  [trees=woods i=@u j=@u]  ^-  ?
  =/  [tall=@u wide=@u]  (dim trees)
  =/  height  (snag j (snag i trees))
  =/  look  |=(dir=(list @u) (levy dir (curr lth height)))
  :: edges are always visible
  ?:  |(=(i 0) =(j 0) =(i (dec tall)) =(j (dec wide)))
    %.y
  =/  row  (snag i trees)
  =/  east   (slag +(j) row)  ?:  (look east)   %.y
  =/  west   (scag j row)     ?:  (look west)   %.y
  =/  col  (turn trees |=(r=(list @u) (snag j r)))
  =/  north  (scag i col)     ?:  (look north)  %.y
  =/  south  (slag +(i) col)  ?:  (look south)  %.y
  %.n
::  +forest: parsed grid of tree heights in forest
++  forest
  ^-  woods
  =/  rows=(list cord)  input
  |-
  ?~  rows  ~
  :-  (rash -:rows (plus dit))
  $(rows +:rows)
--
