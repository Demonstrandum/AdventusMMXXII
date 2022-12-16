:: nunc dies prima: ~nec
/*  input  %txt  /lib/aoc2022/nec/txt
:-  %say  |=  *
=<  [%noun part-1=part-1 part-2=part-2]
|%
++  part-1
  (roll calories max)
++  part-2
  =+  (sort calories gth)
  :(add (snag 0 -) (snag 1 -) (snag 2 -))
++  calories
  ^-  (list @ud)
  (turn (parsed input) |=(sack=(list @ud) (roll sack add)))
++  parsed
  |=  lines=(list @t)  ^-  (list (list @ud))
  =|  sacks=(list (list @ud))
  =|  kcals=(list @ud)
  |-
  ?~  lines  sacks
  ?:  =(-:lines '')
    $(sacks kcals^sacks, kcals ~, lines +:lines)
  =/  kcal  (rash -:lines dem)
  $(kcals kcal^kcals, lines +:lines)
--
