            .text
            .globl main 

# Exercise 1 -- Jump Table
# Add a third subroutine that prints "Wonderful" to the Full, Impractical, Program 
# of the chapter (ass36_6.html). Add an entry to the jump table and a call to the 
# new subroutine to the main routine of the program.

main: 

          lw       $t0,sub1add        # get first entry point
          jalr     $t0                # pass control
          
          lw       $t0,sub2add        # get second entry point
          jalr     $t0                # pass control
         
            
          lw       $t0, sub3add       # get secong entry point
          jalr     $t0                # pass control
 
          li      $v0,10              # return to OS
          syscall

          .data
sub1add:  .word sub1                  # Jump Table
sub2add:  .word sub2
sub3add:  .word sub3
## end of main

#########################
#       sub1            #
#########################
          .text          
          .globl sub1

sub1:     li       $v0,4
          la       $a0,messH
          syscall
          jr       $ra
          .data
messH:    .asciiz  "Hello "
# end of sub1


#########################
#       sub2            #
#########################
          .text
          .globl sub2

sub2:     li       $v0,4
          la       $a0,messW
          syscall
          jr       $ra
          .data
messW:    .asciiz  "World\n"
# end of sub2

#########################
#       sub3            #
#########################
        .text 
        .globl sub3

sub3: 
    
        li      $v0, 4
        la      $a0, messT
        syscall 
        jr      $ra 
        
        .data 
messT:  .asciiz    "Wonderful "
# end of sub3  
        

