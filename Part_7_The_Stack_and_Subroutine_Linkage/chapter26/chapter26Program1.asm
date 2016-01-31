        .text
        .globl main

main: 

    ## Exercise 1 — Arithmetic Expression
    ## write a subroutine that takes three arguments, A, X, and Y. It then computes A*X*Y and returns it. 
    ## Use the subroutine to evaluate the following for various values of u and v:

    ## 5u2 - 12uv + 6v2

    ## The main method, in a loop, prompts the user for values of u and v and prints out the result. End the loop when the user enters zero for both u and v.

   
    ## ask for u & v value
    jal         getUandV                     
    nop            
    
    ## u = $s0 &  y = $s1
      
 
    ## multiple3(5,u,2)
    li          $a1, 5                 # this is a 
    move        $a2, $s0               # this is x 
    li          $a3, 2                 # this is y 

    jal         multiplyThreeValues
    nop 

    ## temp = 5u2
    move        $t0,$v1

    ## multiple3(12,u,v)
    li          $a1, 12                # this is a 
    move        $a2, $s0               # this is x 
    move        $a3, $s1               # this is y 

    jal         multiplyThreeValues
    nop 

    ##  temp = 5u2 - 12uv 
    subu        $t0,$t0,$v1

    ## multiple(6,v,2)
    li          $a1, 6                 # this is a 
    move        $a2, $s1               # this is x 
    li          $a3, 2                 # this is y     

    jal         multiplyThreeValues
    nop 

    ##  temp = 5u2 - 12uv 6v2
    addu        $t0,$t0,$v1
    
    move        $a1, $t0         
    jal        printAnswer
    nop

    ## exit program
     li          $v0, 10               # exit  
    syscall


###################################
########### print answer ##########
###################################
#   on entry:                     #
#       $ra -- return address     #
#                                 #
#   on exit:i                     #
#       diplay 5u2-12uv+6v2       #
###################################
        .text
        .globl printAnswer

printAnswer: 

    li          $v0, 4             # print string
    la          $a0, prompt        # 'answer" 
    syscall

    li          $v0, 1              # print int
    move        $a0, $a1
    syscall    

    jr          $ra                 # return 
    nop                                         #
        .data
prompt: .asciiz            "Answer:  "

#_---------------------------------------
    

###################################
####### #multiplyThreeValues: #####
###################################
#   on entry:                     #
#       $ra -- return address     #
#   on exit: #       $v0 -- A*X*Y #
#                                 #
###################################
         .text
         .globl multiplyThreeValues
                  
multiplyThreeValues:         
         
    mul         $v1, $a1, $a2             # mult A*X
    mul         $v1, $v1, $a3          # mult (a*x)y 

    jr          $ra                      # return 
    nop                                         #
    
#_---------------------------------------
   

#################################
####### #get_U_and_V  ###########
#################################
#   on entry:                   #
#       $ra -- return address # #
#   on exit:                    #
#       $s0 = u & $s1 = y       #
#################################

        .text
        .globl getUandV

getUandV:

    li          $v0, 4        # code 4 + print string
    la          $a0, promptU  # u? 
    syscall 

    li          $v0, 5        # code 5 = read int 
    syscall 

    move        $s0, $v0      # svae u 
    

    li          $v0, 4        # code 4 + print string
    la          $a0, promptY                   # y? 
    syscall 

    li          $v0, 5         # code 5 = read int 
    syscall 
    move        $s1, $v0       # svae y 
    
    jr          $ra            # return   
    nop                                         #
 
            .data
promptU:     .asciiz            "enter value for u: "
promptY:    .asciiz           "enter value for yi: "


