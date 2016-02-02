        .text
        .globl main

# ex 3

   # Write a program that asks if the user wants a triangle or a square. It then prompts for the size of the object (the number of lines it takes to draw the object). The program then writes a triangle or a square of stars ("*") to the monitor.

#*******
#*******
#*******
#*******
#*******
#*******
#*******

#or

#*
#**
#***
#****
#*****
#******

main: 
        li              $s0, 10             #unix end of string
        li              $s1, 0x54           # holds T 
        li              $s2, 0x53           # holds S 

        li              $v0, 4              # code 4 == print string
        la              $a0, ask            # "t or s"
        syscall 

        la            $a0, answer           #hold answer here
        li              $v0, 8
        syscall

        # hold answer adress at $a1 so can use $a0
        move            $a1, $a0             
     
        lb              $t2, ($a1)          # put first char in $t2
        beq             $s1, $t2, checkIfT
        beq             $s2, $t2, checkIfS
        
    tryAgain: 
        li              $v0, 4              # code 4 == print string
        la              $a0, TorS           
        syscall
    
        #string was not T or S so try again
        j               main
   
    checkIfT: 
        addu            $a1, $a1, 1
        lb              $t2, ($a1)          # put 2nd char in $t2 
        beq             $s0, $t2, decide          
        j               tryAgain

    checkIfS: 
        li              $s5, 123            # to let me know what to call
        j               checkIfT
        
    decide: 
        bne             $s5, $0, tri
        jal             square
        nop 
        j               exit
    
    tri: 
        jal             triangle
        nop
        j               exit

    exit: 
        li              $v0, 4 
        la              $a0,over
        syscall

        ## end the program
        li              $v0, 10             # code 10 == exit
        syscall


        .data
ask:    .asciiz         "what do you want triangle or square? (T/S): "
TorS:   .asciiz         "Enter T or S\n" 
answer: .space          200
over:   .asciiz         "\nprogram terminated\n"
## end of main



###############
### square ####
###############

# print a square
    .text
    .globl square

square:  
        li              $v0, 4
        la              $a0, check1
        syscall        

      # set up loop
        la              $t0, 0          # count == 0 
        la              $t1, 7          # stop == 0

      # start loop
      loopS: 
        beq             $t0, $t1, getBack1
        li              $v0, 4
        la              $a0, S
        syscall
        addu            $t0, $t0, 1
        j                loopS        

     getBack1:
       jr              $ra
       nop

         .data
check1:  .asciiz         "YOU WANTED A Square\n"
S:        .asciiz         "*******\n"
# end of 

###############
## triangle ###
###############

# print a square
    .text
    .globl triangle

triangle:
        li              $v0, 4
        la              $a0, check2
        syscall        
        
        # set up loop
        la              $t0, 0          # count == 0 
        la              $t1, 7          # stop == 0

        # start loop
      loopT: 
         beq            $t0, $t1, getBack2
        li              $v0, 4
        la              $a0, T
        syscall
        addu            $t0, $t0, 1
        addu            $a0, $a0, $t0
        la              $t5, 0x2a
        sb              $t5, ($a0)
        j                loopT        

     getBack2:
        jr              $ra
        nop

         .data
check2:  .asciiz         "YOU WANTED A TRIANGLE\n"
T:        .asciiz         "*        \n" 
# end of triangle

