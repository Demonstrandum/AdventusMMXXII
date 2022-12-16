:: nunc dies 4: ~sev
/*  input  %txt  /lib/aoc2022/sev/txt
:-  %say  |=  *
=<  [%noun part-1=part-1 part-2=part-2]
|%
++  part-1
  (count-when |=(task=tsk (gte ->:task +>:task)))
++  part-2
  (count-when |=(task=tsk (gte ->:task +<:task)))
+$  tsk  [[@ @] [@ @]]
++  count-when
  |=  test=$-(tsk ?)
  =/  tasks  pairs  =/  n  0
  |-
  ?~  tasks  n
  ?:  (test -:tasks)
    $(tasks +:tasks, n +(n))
  $(tasks +:tasks)
++  pairs
  :: arrange s.t. first range has lowerst lower bound
  :: and is the wider range when lower bounds are equal.
  =/  order  |=  pair=tsk
  ?:  |((gth -<:pair +<:pair) &(=(-<:pair +<:pair) (lth ->:pair +>:pair)))
    [+:pair -:pair]
  pair
  (turn input (corl order parse-line))
++  parse-line
  |=  line=cord  ^-  [[@ @] [@ @]]
  %+  rash  line
  ;~  plug
    ;~(plug dem ;~(pfix hep dem))
    ;~(pfix com dem)
    ;~(pfix hep dem)
  ==
--
