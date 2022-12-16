:: nunc dies 7: ~let
/*  input  %txt  /lib/aoc2022/let/txt
:-  %say  |=  *
=<  [%noun part-1=part-1 part-2=part-2]
|%
:: find sum of directories smaller than 100.000 bytes
++  part-1
  =/  sizes=(list @)  all-directory-sizes
  =/  small-sizes=(list @)  (skip sizes (curr gth 100.000))
  (roll small-sizes add)
:: find smallest directory to be deleted to free up needed space
++  part-2
  =/  disk-size=@  70.000.000
  =/  needed=@     30.000.000
  =/  sizes=(list @)  (sort all-directory-sizes lth)
  =/  available=@  (sub disk-size (rear sizes))
  |-
  =/  size=@  -:sizes
  ?:  (gte (add available size) needed)
    size
  $(sizes +:sizes)
:: compute total size of a directory
::
++  directory-size
  |=  [root=file-tree]  ^-  @
  ?>  ?=([%dir *] root)
  =+  [ls=ls:root sum=0]
  |-
  ?~  ls  sum
  =/  entry=file-tree  -:ls
  ?-  entry
    [%fil *]  $(ls +:ls, sum (add size:entry sum))
    [%dir *]  $(ls +:ls, sum (add sum $(ls ls:entry, sum 0)))
  ==
:: compute list of all direcory sizes
::
++  all-directory-sizes
  ^-  (list @)
  =/  root=file-tree  file-system
  ?>  ?=([%dir *] root)
  =/  sizes=(list @)  (directory-size root)^~
  =/  ls  ls:root
  |-
  ?>  ?=([%dir *] root)
  ?~  ls  sizes
  =/  entry=file-tree  -:ls
  %=  $
    ls  +:ls
    sizes
      ?-  entry
        [%fil *]  sizes
        [%dir *]  =/  size  (directory-size entry)
          $(root entry, ls ls:entry, sizes size^sizes)
  ==  ==
::  $file-tree: tree stucture representing file system
::
+$  file-tree
  $~  [%fil '' 0]
  $%
    [%fil name=cord size=@]
    [%dir name=cord ls=(list file-tree)]
  ==
:: find file of given name in list of files
::
++  find-file
  |=  [name=cord files=(list file-tree)]
  ^-  (unit @)
  =/  i=@  0
  |-
  ?~  files  ~
  =/  file=file-tree  -:files
  ?:  =(name name:file)  [~ i]
  $(files +:files, i +(i))
:: populate entry given a path and files creating folders as needed
::
++  fill-path
  |=  [root=file-tree path=(list cord) files=(list file-tree)]
  ^-  file-tree
  ?>  ?=([%dir *] root)
  ?~  path
    :: we are already in the directory we want to populate;
    :: don't overwite pre-existing directories
    =|  listing=(list file-tree)
    =-  [%dir name=name:root ls=-]
    |-
    ?~  files  listing
    =/  file=file-tree  -:files
    =/  index  (find-file name:file ls:root)
    =/  keep  ?~(index file (snag +:index ls:root))
    $(files +:files, listing keep^listing)
  :: otherwise we modify the root node to contain
  :: the updated subdirectories recursively
  =/  children=(list file-tree)
    =/  index  (find-file -:path ls:root)
    :: check if the directory is already in the root
    ?~  index
      :: if not, create new directory and append directory listing
      =+  $(root [%dir name=-:path ls=~], path +:path)
      (snoc ls:root -)
    :: otherwise replace found directory with updated directory
    =+  $(root (snag +:index ls:root), path +:path)
    (snap ls:root +:index -)
  [%dir name=name:root ls=children]
::
:: parse rules
::
++  cmd-rule  |=  cmd=cord  ;~(pfix ;~(plug buc ace) (jest cmd))
++  fil-rule  (cook crip (plus ;~(pose alp dot)))
++  dir-rule  ;~(pose fas (jest '..') fil-rule)
:: parse lines and populate file tree
::
++  file-system
  ^-  file-tree
  =/  root=file-tree  [%dir name='/' ls=~]
  =/  lines=(list tape)  (turn input trip)
  =|  cwd=(list cord)  :: directory stack
  |-
  ?~  lines  root
  =/  line=tape  -:lines
  =/  dir  (rust line ;~(pfix ;~(plug (cmd-rule 'cd') ace) dir-rule))
  ?.  =(~ dir)
    :: change directory
    ::
    =/  dir=cord  +:dir
    =-  $(lines +:lines, cwd -)
    ?:  =(dir '..')  +:cwd
    ?:  =(dir '/')   ~
    dir^cwd
  ?.  =(~ (rust line (cmd-rule 'ls')))
    :: read directory listing
    ::
    ?:  =(~ +:lines)  root
    =/  listing  (parse-listing +:lines)
    %=  $
      lines  (slag +((lent listing)) `(list tape)`lines)
      root   (fill-path root (flop cwd) listing)
    ==
  !!
:: parse outout of `ls` until we run out
::
++  parse-listing
  |=  output=(list tape)
  ^-  (list file-tree)
  =|  listing=(list file-tree)
  |-
  ?~  output  listing
  =/  dir-entry  (rust -:output ;~(pfix (jest 'dir ') fil-rule))
  =/  fil-entry  (rust -:output ;~((glue ace) dem fil-rule))
  ?.  =(~ dir-entry)
    =+  (file-tree [%dir name=+:dir-entry ls=~])
    $(listing -^listing, output +:output)
  ?.  =(~ fil-entry)
    =+  (file-tree [%fil name=+>:fil-entry size=+<:fil-entry])
    $(listing -^listing, output +:output)
  listing
--
