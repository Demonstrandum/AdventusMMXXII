#!/bin/sh

# moves repo hoon files into a fakezod pier.
# run with PIER="/path/to/zod" to specify your pier.

[ -z "$PIER" ] && PIER="$HOME"/Ships/zod
PIER="$PIER"/base

exe() { echo " + $*"; "$@"; }

for file in hoon/gen/*.hoon; do
    exe cp "$file" "$PIER"/gen/"$(basename "$file")"
done

mkdir -p "$PIER"/lib/aoc2022
for file in hoon/lib/aoc2022/*.txt; do
    exe cp "$file" "$PIER"/lib/aoc2022/"$(basename "$file")"
done
