            .text
            .globl main

main:
    #Combine the previous two programs:

    #Write a program that evaluate the following for various values of u and v:

    # 5u2 - 12uv + 6v2
    # The values for u and v are prompted for in a loop. The user enters the values and the value of the expression 
    # is printed out. If illegal characters are entered for either u or v, print out an error message and continue.

    # End the loop when the user enters "done" for the value of u.
    
    theloop: 
        ##ask user for u & v
         jal         getUandV
         nop
        
        # see if valid or not if valid put u & y will be on stack 
        li         $t0, 1           # error 
        li         $t2, 2           # done aka end of program 
        
        beq        $v1, $t0, error
        beq        $v1, $t2, done 
  
        # here good values were entered  and function placed them on stack
            # $t0 will = U 
            # $t1 will = Y 
            
        lw          $t0, ($sp)          # pop U 
        addu        $sp, $sp, 4   

        lw          $t1, ($sp)          # pop Y 
        addu        $sp, $sp, 4   
        
        # set arguments for functions
        move        $a1, $t1            # argument 1 == U 
        move        $a2, $t0            # argument 2 == Y 
    
        jal         doMath              # 5u2 - 12uv + 6v2
        nop 
        
        move        $s0, $v0            # moved answer to $s0
        
        #print answer        
        li          $v0, 4              # print a string 
        la          $a0, answer
        syscall 
    
        li          $v0, 1              # print a int
        move          $a0, $s0
        syscall 
       
        li          $v0, 4             # print new line 
        la          $a0, newL
        syscall
 
        j           theloop             # do again untill user enters 'done'

      error:
        li          $v0, 4              # code 4 == print string
        la          $a0, errorM         # print error message
        syscall 
        j           theloop
    
      done:
        li          $v0, 4              # code 4 == print string
        la          $a0, informOfExit   # let user know program terminated
        syscall 
        
        li          $v0, 10             # code 10 == exit
        syscall

               .data
errorM:         .asciiz         "Error: you entred a invalid input for U or Y\n" 
informOfExit:  .asciiz         "You terminated the program\n"
answer:        .asciiz         "5u2 - 12uv + 6v2 = "  

# END OF PROGRAM 3

#################################
####### #get_U_and_V  ###########
#################################
        .text
        .globl getUandV

getUandV:
    ## ask and get U 
    li          $v0, 4          # code 4 + print string
    la          $a0, promptU    # u? 
    syscall 

    la          $a0, Uspace     # store at Uspace
    li          $v0, 8 
    syscall  

    ## hold pointer in stack since calling another function
    subu        $sp, $sp, 4         #push return address on stack 
    sw          $ra, ($sp)     

    ## call function checkIfNumber
    move        $a1,$a0         # put Uspace varible as arguemnet for function call    
    li          $a2, 1          # this indicates checking for done 
    jal         checkIfNumber  
    nop 
    
    ## put back the old return value
    lw          $ra, ($sp)         
    addu        $sp, $sp, 4   

    ## see if valid or not
    beq        $v1, 1, UandYError 
    # see if user entered done  
    beq        $v1, 2, finished

 
    ## hold valid value of U 
    move        $t2, $v0
    
    #################### can erase ###########################
    # check the value of U 
    li         $v0, 4
    la         $a0, checkU
    syscall 

    li         $v0, 1
    move       $a0, $t2
    syscall
    
    li         $v0, 4
    la         $a0, newL
    syscall
    ##########################################################

    subu       $sp, $sp, 4         #push U onto stack 
    sw         $t2, ($sp) 

    ## ask and get Y 
    li          $v0, 4        # code 4 + print string
    la          $a0, promptY  # Y? 
    syscall 

    la          $a0, Yspace   # store at Yspace
    li          $v0, 8 
    syscall

    ## hold pointer in stack since calling another function
    subu        $sp, $sp, 4         #push return address on stack 
    sw          $ra, ($sp)     
    
    ## call function checkIfNumber
    move        $a1,$a0         # put Uspace varible as arguemnet for function call    
    li          $a2, 0          # this indicates NOT checking for done 
    jal         checkIfNumber  
    nop 
  
    ## put back the old return value
    lw          $ra, ($sp)         
    addu        $sp, $sp, 4   

    ## see if valid or not
    beq        $v1, 1,UandYError 
    
    ## hold valid value of Y 
    move        $t3, $v0

    #################### can erase ###########################
    # check the value of U 
    li         $v0, 4
    la         $a0, checkV
    syscall 

    li         $v0, 1
    move       $a0, $t3
    syscall
     
    li         $v0, 4
    la         $a0, newL
    syscall
    ##########################################################

    ## if made it here  both nubmers valid and we will push to stack
    subu        $sp, $sp, 4         #push Y onto stack 
    sw          $t3, ($sp) 
    
    jr         $ra                 # return 
    nop 
    
  UandYError: 
    li      $v0, 1              # signifiy to calling function error
    jr      $ra
    nop 

  finished: 
    # user entered done for U 
    li      $v0, 2              # signifiy to calling function program done
    jr      $ra
    nop 
 
             .data
promptU:     .asciiz           "enter value for u: "
promptY:     .asciiz           "enter value for y: "
checkU:      .asciiz           "U = "
checkV:      .asciiz           "V = " 
newL:        .asciiz           "\n"
Uspace:      .space           200  
Yspace:      .space           200


#################################
####### checkIfNumber  ##########
#################################
        .text
        .globl  checkIfNumber

checkIfNumber:

    la           $t0, 10                 # linux end of string
    la           $t1, 0                  # total == 0 
    la           $t8, 0                  # for negitive/positive 

  # go through entered string make sure its a number    
  loop: 
    lb           $t2, 0($a1)             # put letter in $t1
    beq          $t2, $t0, gotChars    
    
    # only check neg & done if on first char 
    bne          $t1, $0, notFirstChar   # if not first char no need to check if negitive
    
    #check for done only if arg 2 == 1
    li           $t9, 1         #to use value one
    bne          $t9, $a2, notCheckingDone       
    li           $t9, 0x64      # d 
    beq          $t2, $t9, over # if char[0] =='d'
  notCheckingDone:   
    #check for negitive
    li           $t9, 0x2d
    bne          $t2, $t9, notFirstChar
    li           $t8, 1                  # lets me know its neg 
    j            next  

notFirstChar:     
    blt          $t2, 0x30, badEntry
    bgt          $t2, 0x39, badEntry  
        
    addiu       $t2, $t2, -48            # to make number

    mul         $t1, $t1, $t0            # mult by 10
    addu        $t1, $t1, $t2  
  next:
    addiu       $a1, $a1, 1              # next char 
    j            loop                    # do again
        
    gotChars:
    li          $v1, 1          # input convert v1 = 1
    bne         $t8, $v1, notneg
    subu        $t1, $0, $t1
       
  notneg:
    move        $v0, $t1       # put the total in $v0
    move        $v1, $0        # put 0 in $v1 to avoid error message
    jr          $ra

  badEntry:
    li          $v1, 1          # input no convert v1 = 0
    jr          $ra    

  over:
    #make sure full word is done
    addiu       $a1, $a1, 1     # next char 
    lb          $t2, 0($a1)
    li          $t7, 0x6F       # 'o'
    bne         $t2, $t7, badEntry

    addiu       $a1, $a1, 1     # next char 
    lb          $t2, 0($a1)
    li          $t7, 0x6E       # 'n'
    bne         $t2, $t7, badEntry

    addiu       $a1, $a1, 1     # next char 
    lb          $t2, 0($a1)
    li          $t7, 0x65       # 'e'
    bne         $t2, $t7, badEntry

    addiu       $a1, $a1, 1     # next char 
    lb          $t2, 0($a1)
    li          $t7, 10         # unix wnd of sting
    bne         $t2, $t7, badEntry

    # makes it here then user entered done
    li          $v1, 2
    jr          $ra

##########################
####### doMath  ##########
##########################
         .text
        .globl  doMath

doMath: 
    move         $t0, $a1         # $t0 = U 
    move         $t1, $a2         # $t1 = Y 
    
    #push the return adress
    subu        $sp, $sp, 4         #push Y onto stack 
    sw          $ra, ($sp) 
      
    # 5u^2 
    # give three args
    li         $a1, 5 
    move         $a2, $t0
    move         $a3, $t0
    
    jal        multiplyThreeValues
    nop    
    move       $t3, $v1             # HOLD ANSWER OF 5u^2

    # 12uv
    # give three args
    li         $a1, 12 
    move         $a2, $t0
    move         $a3, $t1
     
    jal        multiplyThreeValues
    nop 
    move       $t4, $v1             # HOLD ANSWER OF 12uv

    #6v^2
    # give three args
    li         $a1, 6 
    move         $a2, $t1 
    move         $a3, $t1
    
    jal        multiplyThreeValues
    nop 
    move       $t5, $v1             # HOLD ANSWER OF 6v^2

    # addition subtraction
    subu       $t6, $t3, $t4        
    addu       $t7, $t6, $t5

    
    #pop return adress
    lw          $ra, ($sp)          # pop U 
    addu        $sp, $sp, 4   

    # return total
    move        $v0, $t7

    jr         $ra
    nop        
# end program


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
         
    mul         $v1, $a1, $a2          # mult A*X
    mul         $v1, $v1, $a3          # mult (a*x)y 

    jr          $ra                    # return 
    nop                                #    

