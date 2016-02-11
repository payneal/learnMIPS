          .globl   main
          .text

# *Exercise 2 -- Jump Table with Loop

# Add several more subroutines that print out various words to the Full, Impractical, Program of the chapter. Put each new entry point into the jump table. Write a loop in the main program so that the entry points in the jump table are invoked in order, one per loop iteration.

main: 
         
        la      $t1, 0 
        la      $t2, 5

       loop: 
          beq      $t1, $t2, stop  

          lw       $t0,jtable       # get first entry point
          jalr     $t0                # pass control
          
          lw       $t0,jtable+4       # get second entry point
          jalr     $t0                # pass control
         
          lw       $t0,jtable+8        # get first entry point
          jalr     $t0                # pass control
          
          lw       $t0,jtable+12       # get second entry point
          jalr     $t0                # pass control
          
          lw       $t0,jtable+16        # get first entry point
          jalr     $t0                # pass control
         
          lw       $t0,jtable+20      # get first entry point
          jalr     $t0                # pass control
          nop               
 
          addu     $t1, $t1, 1        # count++ 

          j        loop          

    stop: 
          li      $v0,10              # return to OS
          syscall

          .data
jtable:
  .word sub1                  # Jump Table
  .word sub2
  .word sub3
  .word sub4
  .word sub5
  .word sub6 

          .text
          .globl sub1          
sub1:     li       $v0,4
          la       $a0,messH
          syscall
          jr       $ra
          .data
messH:    .asciiz  "Hello "

          .text
          .globl sub2
sub2:     li       $v0,4
          la       $a0,messW
          syscall
          jr       $ra
          .data
messW:    .asciiz  "World "

###############################
          .text
          .globl sub3 
sub3:     li       $v0,4
          la       $a0,messD
          syscall
          jr       $ra
          .data
messD:    .asciiz  "My "

###############################
          .text
          .globl sub4 
sub4:     li       $v0,4
          la       $a0,messC
          syscall
          jr       $ra
          .data
messC:    .asciiz  "Name "

###############################
          .text
          .globl sub5
sub5:     li       $v0,4
          la       $a0,messB
          syscall
          jr       $ra
          .data
messB:    .asciiz  "is "

###############################
          .text
          .globl sub6
sub6:     li       $v0,4
          la       $a0,messA
          syscall
          jr       $ra
          .data
messA:    .asciiz  "Ali\n"


