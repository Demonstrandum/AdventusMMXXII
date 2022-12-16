:: nunc dies secundus: ~bud
/*  input  %txt  /lib/aoc2022/bud/txt
:-  %say  |=  *
=<  [%noun part-1=part-1 part-2=part-2]
|%
++  part-1
  (roll (scores (turn input entry)) add)
++  part-2
  (roll (scores (turn input (corl old-format entry))) add)
++  old-format
  |=  row=[@ @]
  =/  act  +:row
  =/  offs
  ?-  act
    %'X'  2  :: lose
    %'Y'  3  :: draw
    %'Z'  1  :: win
    *     !!
  ==  :: outcome determined by picking offsets (above) from opponent.
  :-  -:row  (add 'X' (mod (add (sub -:row 'A') offs) 3))
++  scores
  |=  entires=(list [@ @])
  =/  outcome  |=  game=[@ @]
    =/  play=[@ @]  (sub -:game 'A')^(sub +:game 'X')
    ?:  =(-:play +:play)
      3
    ?-  play
      [%0 %1]  6  :: rock     loses to paper
      [%0 %2]  0  :: rock     wins  to scissors
      [%1 %0]  0  :: paper    wins  to rock
      [%1 %2]  6  :: paper    loses to scissors
      [%2 %0]  6  :: scissors loses to rock
      [%2 %1]  0  :: scissors wins  to paper
      *        !!
    ==
  =/  score  |=  game=[@ @]  (add (outcome game) +((sub +:game 'X')))
  (turn entires score)
++  entry
  |=  line=@t  ^-  [@ @]
  (rash line ;~((glue ace) (shim 'A' 'C') (shim 'X' 'Z')))
--
