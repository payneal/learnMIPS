        .text
        .glbol main

main: 

    ## Exercise 1 — Arithmetic Expression
    ## write a subroutine that takes three arguments, A, X, and Y. It then computes A*X*Y and returns it. 
    ## Use the subroutine to evaluate the following for various values of u and v:

    ## 5u2 - 12uv + 6v2

    ## The main method, in a loop, prompts the user for values of u and v and prints out the result. End the loop when the user enters zero for both u and v.

   
    ## ask for u & v value
    jal         get_U_and_V                     
    nop            
   
    ## save u    
    move        $s0, $v1 
    ## save v
    move        $s1,  $v2    

    ## multiple3(5,u,2)
    li          $a1, 5                          # this is a 
    li          $a2, $s0                        # this is x 
    li          $a3, 2                          # this is y 

    jal         multiplyThreeValues
    nop 

    ## temp = 5u2
    move        $t0,$v1

    ## multiple3(12,u,v)
    li          $a1, 12                        # this is a 
    li          $a2, $s0                         # this is x 
    li          $a3, $s1                         # this is y 

    al         multiplyThreeValues
    nop 

    ##  temp = 5u2 - 12uv 
    subu        $t0,$t0,$v1

    ## multiple(6,v,2)
    li          $a1, 6                        # this is a 
    li          $a2, v                         # this is x 
    li          $a3, 2                         # this is y     

    al         multiplyThreeValues
    nop 

    ##  temp = 5u2 - 12uv 6v2
    addu        $t0,$t0,$v1

    ## exit program
     li          $v0, 10                         # exit  
    syscall

 
######################################
####### #multiplyThreeValues:
#####################################
#   on entry: 
#       $ra -- return address 
#   on exit: #       $v0 -- A*X*Y
#################################
######################################
         .text
         .glbol multiplyThreeValues:
                  
multiplyThreeValues:         
    
    jal         get_U_and_V 
    nop
    move        $s0, $v1

    li          $v0, 1                          # print the int
    move        $a0, $v1
    syscall 
    
    jr          $ra                             # return   
    nop                                         #
   

####################################
####### #get_U_and_V  #############
#   on entry: 
#       $ra -- return address # 
#   on exit: 
#       $v0 -- A*X*Y ################
################################## 


    jal         get_U_and_V 
    nop
    move        $s0, $v1

    li          $v0, 1                          # print the int
    move        $a0, $v1
    syscall 
    
    jr          $ra                             # return   
    nop                                         #
 


















        .text
        .globl get_U_and_V 
    
get_U_and_V:
     
    mul         $v1, $a1, $a2                   # mult A*X
    mul         $v1, $v1, $a3                   # mult (a*x)y 

    jr          $ra                             # return 
    nop                                         #
    
    .data


## end program
