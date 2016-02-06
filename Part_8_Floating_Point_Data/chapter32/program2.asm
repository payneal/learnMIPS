        .text
        .globl main

main: 
        li      $v0,4           # code 4 = print string
        la      $a0, how        #"how many terms"
        syscall

        li      $v0,5           # code 5 = read int
        syscall
        
        li,     $t0, 999        # must be higheer than
        blt     $v0, $t0, tooLow
        nop     

        move    $t1, $v0        # put amount in $t1
        # set up loop
        li      $t0, 1          # count == 1
        li.s    $f2, 1.0        # total = 1 
        li.s    $f3, 1.0        # for division
        li.s    $f5, 1.0 
        li.s    $f4, 2.0        # for addition
      loop: 
        bgt     $t0, $t1, next  # end this loop
        
        add.s   $f5,$f5 $f4     # add 2 to division each time
        
        # is count even or odd
        la      $t2, 2          # to get remainder
        remu    $t3, $t0, $t2   # remainder = count%2
        div.s   $f6, $f3, $f5   #  1/3, 1/5, 1/7, 1/9 ... etc

        bne     $t3,$zero,subs    # if reminder != 0 sub 
        nop       
        #even add
        add.s   $f2, $f2, $f6   # total = total + 1/$f6
        j       skip
        nop
        #odd sub
      subs:
        sub.s  $f2, $f2, $f6     # total = total -  1/$f6 
        
      skip: 
         addu   $t0, $t0, 1     #  count ++ 
         j loop  

    next: 

        li.s    $f1, 4.0        # pi  = 4(.....) 
        mul.s   $f2, $f2, $f1

        li      $v0,4           # code 4 = print string
        la      $a0, answer     #"answer: "
        syscall

        mov.s   $f12, $f2       # put answer in $f12
        li      $v0, 2          # code to print float
        syscall 
    
        # end program
        li      $v0, 10         # exit program
        syscall

    tooLow:
        li      $v0,4           # code 4 = print string
        la      $a0, min     #"answer: "
        syscall
        j       main
        nop

        .data
how:    .asciiz     "how many terms of the pi series do you wish to use (1,000 min):  "
answer: .asciiz     "answer: "
min:    .asciiz     "Min amount 1,000 try again\n" 
## end of main program
