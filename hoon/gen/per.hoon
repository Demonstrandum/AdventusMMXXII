:: nunc dies 5: ~per
/*  input  %txt  /lib/aoc2022/per/txt
:-  %say  |=  *
=<  [%noun part-1=part-1 part-2=part-2]
|%
++  part-1
  (turn (move-stacks crate-mover-9000) head)
++  part-2
  (turn (move-stacks crate-mover-9001) head)
+$  tower   (list @tD)
+$  towers  (list tower)
+$  fromto  [amount=@ from=@ to=@]
++  crate-mover-9000
  |=  [move=fromto source=tower destin=tower]
  ^-  [src=tower dst=tower]
  =+  n=1  |-
  ?:  (gth n amount:move)
    :-  source  destin
  %=  $
    n       +(n)
    source  +:source
    destin  [-:source destin]
  ==
++  crate-mover-9001
  |=  [move=fromto source=tower destin=tower]
  ^-  [src=tower dst=tower]
  =/  [top=tower bot=tower]  (trim amount:move source)
  :-  bot  (weld top destin)
++  move-stacks
  |=  procedure=$-([fromto tower tower] [src=tower dst=tower])
  ^-  towers
  =/  [stacks=towers moves=(list fromto)]  parsed
  |-
  ?~  moves  stacks
  =/  move=fromto  -:moves
  =/  source  %+  snag  (dec from:move)  stacks
  =/  destin  %+  snag  (dec to:move)    stacks
  =/  result  %-  procedure  [move source destin]
  %=  $
    moves  +:moves
    stacks  =+  %^  snap  stacks  (dec from:move)  src:result
                %^  snap       -  (dec to:move)    dst:result
  ==
++  parsed
  ^-  [towers (list fromto)]
  =/  stacks=towers  parse-stacks
  =/  lines=(list cord)  (slag (add 2 (roll (turn stacks lent) max)) input)
  =/  moves=(list fromto)  (turn lines (corl parse-move trip))
  [stacks moves]
++  parse-move
  |=  line=tape  ^-  fromto
  %+  scan  line
  ;~  (glue ace)
    ;~(pfix (jest 'move ') dem)
    ;~(pfix (jest 'from ') dem)
    ;~(pfix (jest 'to ') dem)
  ==
++  parse-stacks
  =/  row-rule  ;~  pose
    (cold 0 ;~(plug ace ace ace))
    (ifix [sel ser] (shim 'A' 'Z'))
  ==
  =/  lines=(list tape)  (turn input trip)
  =|  stacks=towers
  |-  :: parse each line into row
  =/  row  ^-  (list @)  (rust -:lines (more ace row-rule))
  ?~  row  stacks
  =/  row  +:row
  ?:  (gth (lent row) (lent stacks))
    $(stacks (weld stacks `towers`(reap (sub (lent row) (lent stacks)) ~)))
  %=  $
    lines  +:lines
    stacks
    =+  i=0  |-  :: insert each item in row onto stacks
    ?~  row  stacks
    ?:  =(-:row 0)
      $(row +:row, i +(i))
    =/  stack=(list @tD)  (snoc (snag i stacks) -:row)
    $(row +:row, i +(i), stacks (snap stacks i stack))
  ==
--
