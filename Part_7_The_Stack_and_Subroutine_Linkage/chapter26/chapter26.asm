        .text
        .globl main

main: 

    # Exercise 1 — Arithmetic Expression
    
    # write a subroutine that takes three arguments, A, X, and Y. It then computes A*X*Y and returns it. 

    # Use the subroutine to evaluate the following for various values of u and v:

    # 5u2 - 12uv + 6v2

    # The main method, in a loop, prompts the user for values of u and v and prints out the result. End the loop when the user enters zero for both u and v.

    li          $a1, 1                          # this is a 
    li          $a2, 2                          # this is x 
    li          $a3, 3                          # this is y  

    jal         multiplyThreeValues
    nop
    move        $s0, $v1

    li          $v0, 1                          # print the int
    move        $a0, $v1
    syscall 

    li          $v0, 10                         # exit  
    syscall

##################################################
# multiplyThreeValues
#   on entry: 
#       $ra -- return address
#
#   on exit: 
#       $v0 -- A*X*Y
##################################################
        .text
        .globl multiplyThreeValues

multiplyThreeValues:
    
    mul         $v1, $a1, $a2                   # mult A*X
    mul         $v1, $v1, $a3                   # mult (a*x)y 

    jr          $ra                             # return 
    nop                                         #
    
    .data


## end program
