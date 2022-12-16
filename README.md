# ADVENTVS

Hoc repositio:
- Hoon adventum.

an opportunity to learn a bit of hoon.

### Running

Create a fakezod (`./urbit -F zod -c /path/to/fakezod`).
Copy source files over:
```sh
PIER=/path/to/fakezod ./zod.sh
```
Boot ship and commit files:
```console
$ ./urbit /path/to/fakezod
~zod:dojo> |commit %base
~zod:dojo> +nec
[part-1=68.787 part-2=198.041]
```
&c.

### Counting in `@p`

```hoon
?>  =(~nec 1)
?>  =(~bud 2)
?>  =(~wes 3)
?>  =(~sev 4)
?>  =(~per 5)
?>  =(~sut 6)
?>  =(~let 7)
?>  =(~ful 8)
?>  =(~pen 9)
?>  =(~syt 10)
?>  =(~dur 11)
?>  =(~wep 12)
?>  =(~ser 13)
?>  =(~wyl 14)
?>  =(~sun 15)
?>  =(~ryp 16)
?>  =(~syx 17)
?>  =(~dyr 18)
?>  =(~nup 19)
?>  =(~heb 20)
?>  =(~peg 21)
?>  =(~lup 22)
?>  =(~dep 23)
?>  =(~dys 24)
?>  =(~put 25)
%+  turn  (gulf 1 25)
|=  n=@  :-  `@p`n  `@ud`n
```
