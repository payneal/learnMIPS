                .text
                .globl main

main: 
        li      $t3, 0           # hold total
        li      $t0, 0xFF         # bit mask 
        li      $t1, 16          # used to get 2 hex numbers
#------------------------------------------------------------

        lw      $t2, color        # put color in $t2
        srl     $t2,$t2, $t1      # shift right 4 bytes
        and     $t2,$t2, $t0 
             
        mtc1    $t2, $f12         # convert to decimal
        cvt.s.w $f12, $f12

        li.s    $f1, 255.0        # move 255.0 so we can div
        div.s   $f12, $f12,$f1    # #/255.0 

        li      $v0, 2            # code floar print int
        syscall
    
        li      $v0, 4            # print string
        la      $a0, next         # " -> "
        syscall

        sub     $t1, $t1, 8          # subtract 4 to get next hex in number
        lw      $t2, color
        srl     $t2, $t2, $t1
        and     $t2, $t2, $t0

        mtc1    $t2, $f12         # convert to decimal
        cvt.s.w $f12, $f12

        li.s    $f1, 255.0        # move 255.0 so we can div
        div.s   $f12, $f12,$f1    # #/255.0 
    
        li      $v0, 2
        move    $a0, $t2
        syscall       

        li      $v0, 4            # print string
        la      $a0, next         # " -> "
        syscall

        sub     $t1, $t1, 8       # subtract 4 to get next hex in number
        lw      $t2, color
        srl     $t2, $t2, $t1
        and     $t2, $t2, $t0

        mtc1    $t2, $f12         # convert to decimal
        cvt.s.w $f12, $f12

        li.s    $f1, 255.0        # move 255.0 so we can div
        div.s   $f12, $f12,$f1    # #/255.0 

        li      $v0, 2
        move    $a0, $t2
        syscall       

        li      $v0, 10
        syscall 

          .data
color:    .word     0x00FF0000   # pure red, (1.0, 0.0, 0.0)
next:     .asciiz   ",  " 
## end of main
