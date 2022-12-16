:: nunc dies 6: ~sut
/*  input  %txt  /lib/aoc2022/sut/txt
:-  %say  |=  *
=<  [%noun part-1=part-1 part-2=part-2]
|%
++  part-1
  (marker-offset 4 (trip -:input))
++  part-2
  (marker-offset 14 (trip -:input))
++  marker-offset
  |=  [width=@ line=tape]
  =/  offs  0
  %+  add  width
  |-
  ?:  (unique (scag width line))
    offs
  $(line +:line, offs +(offs))
++  unique
  |=  l=(list @)
  .=  (lent l)  ~(wyt in (silt l))
--
