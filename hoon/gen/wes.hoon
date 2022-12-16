:: nunc dies tertius: ~wes
/*  input  %txt  /lib/aoc2022/wes/txt
:-  %say  |=  *
=<  [%noun part-1=part-1 part-2=part-2]
|%
++  part-1
  (roll (turn common priority) add)
++  part-2
  (roll (turn badges priority) add)
++  badges
  ^-  (list @tD)
  =/  bags=(list tape)  (turn input trip)
  =/  intersect  |=  [u=tape v=tape]  (~(int in (silt u)) (silt v))
  =|  badges=(list @tD)
  |-
  ?~  bags  badges
  =/  badge  =<  ,.-
    (~(int in (intersect ,.&1:bags ,.&2:bags)) (silt ,.&3:bags))
  $(badges badge^badges, bags ,.|3:bags)
++  priority
  |=  ch=@tD
  ?:  &((gte ch 'a') (lte ch 'z'))
    (add 1 (sub ch 'a'))
  ?:  &((gte ch 'A') (lte ch 'Z'))
    (add 27 (sub ch 'A'))
  !!
++  parse-line
  |=  line=tape
  =/  [left=tape right=tape]
    (trim (div (lent line) 2) line)
  |-
  ?:  |-
      ?:  =(right ~)
        %.n
      ?:  =(-:left -:right)
        %.y
      $(right +:right)
    -:left
  $(left +:left)
++  common
  ^-  (list @tD)
  (turn input (corl parse-line trip))
--
