#!/bin/sh

exe() { echo " + $*"; "$@"; }

day=1
while read -r line; do
	file="${line#\~}"
  hoon=hoon/gen/"$file".hoon
  text=hoon/lib/aoc2022/"$file".txt
  [ ! -f "$hoon" ] && {
    exe touch "$hoon";
    echo ":: nunc dies $day: $line" > "$hoon";
  }
  [ ! -f "$text" ] && exe touch "$text"
  day=$(( day + 1 ))
done <<EOF
  ~nec
  ~bud
  ~wes
  ~sev
  ~per
  ~sut
  ~let
  ~ful
  ~pen
  ~syt
  ~dur
  ~wep
  ~ser
  ~wyl
  ~sun
  ~ryp
  ~syx
  ~dyr
  ~nup
  ~heb
  ~peg
  ~lup
  ~dep
  ~dys
  ~put
EOF
