# pre waring I didnt use stack, like one should when using subroutines I just free balled it becacuse I AM SO CLOSE TO BEING DONE!
        .text
        .globl main 
        
# Divide the last program of the chapter into three parts: a main routine, a subroutine that creates the linked list, and a subroutine that prints the linked list. Have linked list creation routine ask the user for each value that is stored in a node. The first value that the user enters is the number of nodes that will be in the list.

main:
        # create the linked list 
        la      $a1, first        # Pass the header to subcreate 
        jal     subCreate           
        nop
        
        move    $s1,$v1           # $s1 = &(first node)

        # print the linked list       
        la      $a1, first        # Pass the header to subcreate 
        jal     subPrint           
        nop
        
        li      $v0,10            # return to OS
        syscall       

       .data
first: .word   0
# end of main

#################################
#          subCreate            #
#    creates the linked list    #
#################################
        .text
        .globl subCreate 

subCreate:

        # create the first node 
        li      $v0,9             # allocate memory
        li      $a0,8             # 8 bytes
        syscall                   # $v0 <-- address
        move    $s1, $v0          # $s1 = &(first node)
       
        # copy the pointer to first 
        sw      $s1,0($a1)       
       
        #below is how you initialiizie the first node
 
        # ask user for string
        li      $v0, 4            # code 4 = print string
        la      $a0, enter        # enter a string
        syscall 

        la      $a0, stored       # this is where I will hold string 
        li      $v0, 8            # coide 5 = read string
        syscall 

        # hold return adress
        move    $t6, $ra
        # checkdone sets $t7 == 1 if entered string was "done"
        # see if string entered was "done" 
        jal     checkdone           
        nop 
        
        # put return adress back
        move    $ra, $t6
                     
        # create remaining nodes if done not entered
    loop:
        bne    $0,$t7,done 
       
        # at displacment 0 
        sw      $a0,0($s1) 
          
 
        # creat a node
        li      $v0,9           # allocate memory
        li      $a0,8           # 8 bytes
        syscall                 

        # link  this node to previous node
        sw      $v0, 4($s1)
    
        # make the new node the current node
        move    $s1, $v0       
         
        li      $v0, 4            # code 4 = print string
        la      $a0, enter        # enter a string
        syscall 

        la      $a0, stored
        li      $v0, 8            # coide 5 = read string
        syscall 
       
        move    $t6, $ra          # hold the retuen adress

        jal     checkdone         # check if string == done
        nop 
        
        move    $ra, $t6          # put the return adress back
        j       loop              # do again 
        nop        

       done: 
        # put null at tail of linked list
        sw      $0, 4($a1)       
        move    $v1, $s1          # throw it back

        jr      $ra               # jump back
        nop  
    
        .data
finished:   .asciiz        "done\n"
enter:      .asciiz        "Enter a string to save: "
stored:     .space         17

# end of subCreate

#################################
#        checkdone              #
#    if string == done set      #
#       $t7 to 1                #
#################################
        .text
        .globl checkdone 

checkdone: 
        move    $t8, $a0       # put the entered string in $t8
        
        lb      $t9,0($t8)     #load the first char
        la      $t5, 0x64      # 'd'
        bne     $t9, $t5, skipper       
        
        lb      $t9,1($t8)     #load the first char 
        la      $t5, 0x6F      # 'o'
        bne     $t9, $t5, skipper 

        lb      $t9,2($t8)     #load the first char 
        la      $t5, 0x6E      # 'n'
        bne     $t9, $t5, skipper 

        lb      $t9,3($t8)     #load the first char 
        la      $t5, 0x65      # 'e'
        bne     $t9, $t5, skipper 

        lb      $t9,4($t8)     #load the first char 
        la      $t5, 10        # unix end of string 
        bne     $t9, $t5, skipper 

        la      $t7, 1
    skipper:      
        jr     $ra                # jump back
        nop 

#################################
#          subPrint             #
#    prints the linked list     #
#################################
        .text
        .globl subPrint 

subPrint: 
        lw      $s0,0($a1)        # copy the pointer to first

      lp: 
        beqz    $s0, endlp        # while the pointer is not null
        lw      $a0, 0($s0)       # get the data of this node
        li      $v0, 4            # print it
        syscall 


        lw      $s0, 4($s0)       # get the pointer to the next node
        b       lp
    endlp: 
        
        jr     $ra                # jump back
        nop 

# end of subPrint


