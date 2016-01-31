        .text
        .globl main

main: 

#Exercise 2 — User Prompt

    # Write a subroutine that prompts the user for an integer. The subroutine reads the string the user enters as a string (using trap handler service 8). Then, if the string forms a proper integer, it is converted to two's complement form and returned in register $v0.

#If the input was converted, set register $v1 to one. If the input was not converted, set register $v1 to zero, and set $v0 to zero. If the user enters "done", set register $v1 to two, and set $v0 to zero.

#Use the subroutine in a program that computes the sum of a list of integers that the user enters. The user signals the end of input by typing "done".

    
    #ask user for an int
    jal         askForInt
    nop
    
    #see if valid or not
    beq        $v1, $0, bad
    
    move       $s0, $v0         # save total in $s0
 
    li          $v0, 4          # "your total" 
    la          $a0, total
    syscall
    
    li          $v0, 1          # "#"
    move        $a0, $s0
    syscall    

    # exit program
  exit:
    li          $v0, 10
    syscall
    
  bad: 
    li          $v0, 4 
    la          $a0, error
    syscall 

    j           exit
    
## end of main
    .data
error:  .asciiz     "error: you entered a non int"
total:  .asciiz     "int(string)=  "

###########################
###### askForInt ##########
###########################
        .text
        .globl askForInt

askForInt:

    li          $v0, 4          # print string
    la          $a0, askInt     
    syscall

    la          $a0, space
    li          $v0, 8 
    syscall

    la           $t0, 10      # linux end of string
    la           $t1, 0         # total == 0

    # go through entered string make sure its string    
  loop: 
    lb           $t2, 0($a0)    # put letter in $t1
    beq          $t2, $t0, gotChars    
    
    bne          $t1, $0, notFirstChar
    li           $t9, 0x2d
    bne          $t2, $t9, notFirstChar
    li           $t8, 1         # lets me know its neg 
    j            next  
notFirstChar:     

    blt          $t2, 0x30, badEntry
    bgt          $t2, 0x39, badEntry  
        
    addiu       $t2, $t2, -48   # to make number

    mul         $t1, $t1, $t0   # mult by 10
    addu        $t1, $t1, $t2  
  next:
    addiu       $a0, $a0, 1     # next char 
    j            loop           # do again
            
  gotChars:
    li          $v1, 1          # input convert v1 = 1
    bne         $t8, $v1, notneg
    subu        $t1, $0, $t1
    
  notneg:
    move        $v0, $t1
    jr          $ra

  badEntry: 
    li          $v0, 0          # input no convert v1 = 0
    li          $v1, 0
    jr          $ra

        .data
askInt: .asciiz         "enter an int: "
space:  .space          200
entered:.asciiz         "you entered: " 
sayOr:     .asciiz         " or " 

## end of askForInt    


