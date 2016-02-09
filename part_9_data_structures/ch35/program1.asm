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
        sw      $s1,0($a1)        # copy the pointer to first

        # initialize the first node
        li      $t0,1             # store 1
        sw      $t0,0($s1)        # at displacement 0

        # create the remaining nodes in a counting loop
        li      $s2,2             # counter = 2
        li      $s3,8             # upper limit
        
        loop:   bgtu    $s2,$s3,done      # while (counter <= limit )
        
        # create a node 
        li      $v0,9             # allocate memory
        li      $a0,8             # 8 bytes
        syscall                   # $v0 <-- address
        
        # link this node to the previous
                                  # $s1 = &(previous node)
        sw      $v0,4($s1)        # copy address of the new node
                                  # into the previous node
        
        # make the new node the current node
        move    $s1,$v0
        
        # initialize the node
        sw      $s2,0($s1)        # at displacement 0
        addi    $s2,$s2,1         # counter++
        b       loop
       
     done: 
        sw      $0, 4($s1)       # put null in the link field
        move    $v1, $s1          # throw it back

        jr      $ra               # jump back
        nop  
# end of subCreate

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
        li      $v0, 1            # print it
        syscall 
        la      $a0, sep          # print seperator
        li      $v0, 4
        syscall 

        lw      $s0, 4($s0)       # get the pointer to the next node
        b       lp
    endlp: 
        
        jr     $ra                # jump back
        nop 

        .data
sep:     .asciiz   " "
# end of subPrint


