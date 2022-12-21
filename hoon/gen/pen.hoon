:: nunc dies 9: ~pen
/*  input  %txt  /lib/aoc2022/pen/txt
:-  %say  |=  *
=<  [%noun part-1=part-1 part-2=part-2]
|%
++  part-1
  %~  wyt  in
  (move-knots 2 moves)
++  part-2
  %~  wyt  in
  (move-knots 10 moves)
::  +move-knots: simulate n knots forming a rope
++  move-knots
  |=  [n=@u moves=(list move)]
  ^-  (set coor)
  =/  knots=(list coor)  (reap n *coor)
  =|  trail=(set coor)
  |-
  ?~  moves  trail
  =/  m=move  -:moves
  =/  steps  steps:m
  =/  next
    |-
    ?:  =(steps 0)
      [knots=knots trail=trail]
    =/  head  (step dir:m -:knots)
    =/  tails  +:knots
    =/  tails=(list coor)
      |-
      ?~  tails  ~
      =/  tail  (follow head -:tails)
      :-  tail
      $(head tail, tails +:tails)
    %=  $
      steps  (dec steps)
      knots  head^tails
      trail  (~(put in trail) (rear tails))
    ==
  $(moves +:moves, knots knots:next, trail trail:next)
::  +step: make a move from a position
++  step
  |=  [d=card p=coor]
  ^-  coor
  ?-  d
    %n  :-  x:p  (sum:si y:p --1)
    %e  :-  (sum:si x:p --1)  y:p
    %s  :-  x:p  (dif:si y:p --1)
    %w  :-  (dif:si x:p --1)  y:p
  ==
::  +sign: @s sign --1 (> 0), --0 (= 0) or -1 (< 0)
++  sign  |=  s=@s  ?:(=(s --0) --0 ?:(=(0 (end 0 s)) --1 -1))
::  +follow: move tail behind head
++  follow
  |=  [head=coor tail=coor]
  ^-  coor
  =/  offs=coor
    :-  (dif:si x:head x:tail)
        (dif:si y:head y:tail)
  ?:  &((lte (abs:si x:offs) 1) (lte (abs:si y:offs) 1))
    tail
  :-  (sum:si x:tail (sign x:offs))
      (sum:si y:tail (sign y:offs))
::  $coor: cartesian coordinate
+$  coor  [x=@s y=@s]
::  $card: a cadinal direction
+$  card  ?(%n %e %s %w)
::  $move: a move of n steps
+$  move  [dir=card steps=@u]
::  +to-move: direction cord to card
++  to-move
  |=  d=cord
  ?:  =(d 'U')  %n
  ?:  =(d 'R')  %e
  ?:  =(d 'D')  %s
  ?:  =(d 'L')  %w
  !!
::  +moves: list of moves of rope knot heads
++  moves
  ^-  (list move)
  =/  lines=(list cord)  input
  |-
  ?~  lines  ~
  :-  (rash -:lines ;~((glue ace) (cook to-move hig) dem))
  $(lines +:lines)
--
