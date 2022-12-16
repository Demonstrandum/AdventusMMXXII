:: nunc dies 7: ~let
/*  input  %txt  /lib/aoc2022/let/txt
:-  %say  |=  *
=<  [%noun part-1=part-1 part-2=part-2]
|%
++  part-1
  0
++  part-2
  0
+$  file-tree
  $~  [%fil '' 0]
  $%
    [%fil name=cord size=@]
    [%dir name=cord parent=?(~ file-tree) ls=(list file-tree)]
  ==
++  null-file
  (file-tree [%fil name='' size=0])
++  find-file
  |=  [name=cord files=(list file-tree)]
  =/  i=@  0
  |-
  ?~  files  ~
  ?:  =(name name:-:files)  [~ i]
  $(files +:files, i +(i))
++  file-system
  ^-  file-tree
  =/  cmd-rule  |=  cmd=cord  ;~(pfix ;~(plug buc ace) (jest cmd))
  =/  dir-rule  ;~(pose fas (jest '..') sym)
  =/  fil-rule  (plus ;~(pose alp dot))
  =/  lines  (turn input trip)
  =/  branch=file-tree  [%dir name='/' parent=~ ls=~]
  |-  ^-  file-tree
  ?~  lines  branch
  =/  line=tape  -:lines
  =/  dir=(unit cord)  (rust line ;~(pfix ;~(plug (cmd-rule 'cd') ace) dir-rule))
  ?.  ?=([%dir *] branch)  !!
  ?.  =(~ dir)
    :: change directory
    ::
    =/  subbranch=file-tree
      =-  $(branch -, lines +:lines)
      ?:  =(+:dir '..')  parent:branch
      ?:  =(+:dir '/')   branch
      [%dir name=+:dir parent=branch ls=~]
    =/  subdir-index  (find-file dir ls:branch)
    =/  new-branch
      ?~  subdir-index  branch
      [%dir name=name:branch parent=parent:branch ls=(snap ls:branch +:subdir-index subbranch)]
    $(lines (slag +((lent ls:new-branch)) lines), branch new-branch)
  ?.  =(~ (rust line (cmd-rule 'ls')))
    :: read directory listing
    ::
    =/  output  +:lines
    =|  listing=(list file-tree)
    =/  listing
      |-
      =/  dir-entry  (rust -:lines ;~(pfix (jest 'dir ') sym))
      =/  fil-entry  (rust -:lines ;~((glue ace) dem fil-rule))
      ?.  =(~ dir-entry)
        =+  (file-tree [%dir name=+:dir-entry parent=branch ls=~])
        $(listing -^listing, output +:output)
      ?.  =(~ fil-entry)
        =+  (file-tree [%fil name=+>:fil-entry size=+<:fil-entry])
        $(listing -^listing, output +:output)
      listing
      [%dir name=name:branch parent=parent:branch ls=ls:branch]
  !!
--
