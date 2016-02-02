        .text
        .globl  main 

## ex2

    ## Modify the program in Exercise 1 that the program inputs two strings and writes out a third string. The third 
    ## string has a blank in positions where the two characters are identical and has a "*" in positions where the characters are not identical. 


main:   
    
     ## let user know we are asking for 1st string
        li          $v0, 4
        la          $a0, first
        syscall
      
        ## pass string1 adress to readString
        la          $a1, string1
        jal         readString
        nop 
        
        ## let user know we are asking for 2nd string
        li          $v0, 4
        la          $a0, second
        syscall
      
        ## pass string2 adress to readString
        la          $a1, string2
        jal         readString
        nop 
        
        ## create new string 
        la          $a0, string3
        la          $a1, string1
        la          $a2, string2
        jal         compareAndSwitch 
        nop 
        
        ## print the new string
        li          $v0, 4
        la          $a0, entered
        syscall 
        la          $a0, string3
        syscall 
 
        ## end the program
        li          $v0, 10             # code 10 == exit
        syscall

        .data
    first:   .asciiz      "First String\n"
    second:  .asciiz      "Second String\n"
    entered: .asciiz      "3rd string = "
    string1: .space        200 
    string2: .space        200
    string3: .space        200 
    ## end of main

    ############################
    ##### read string ##########
    ############################

    # ask, reads, and saves string in adress passed

    .text
    .globl readString

    readString:
        li          $v0, 4
        la          $a0, ask
        syscall

        move        $a0, $a1
        li          $v0, 8        
        syscall        

        jr          $ra         
        nop
    
    .data
    ask:     .asciiz        "enter a string: "
    ## end of read string


    ########################
    ## compareAndSwitch ####
    ########################

    # compares to strings to see if they are identical if so put "*" else " "
    .text
    .globl compareAndSwitch

compareAndSwitch:

        # set up loop
        li          $t0, 0              # count = 0
        li          $t1, 10             # end of unix string
        li          $t5, 300

    loop:
        lb          $t2, ($a2)          # load char of string1 to $t2
        lb          $t3, ($a1)          # load char of string2 to $t3
                
        bne         $t2, $t1, skip1
        li          $t5, 1
    skip1:

        bne         $t3, $t1, skip2
        li          $t6, 1        
    skip2:
        beq         $t5, $t6, goBack
        
        beq         $t2, $t3,same       # if char1[x] == char2[x] sb "*"
        # not the same char so sb "_" 
        la          $t7, 0x5F
        sb          $t7, ($a0)          # stor in 3rd string
        
    continue:
        addu        $a1, $a1, 1
        addu        $a2, $a2, 1
        addu        $a0, $a0, 1 
        addu        $t0, $t0, 1    
        j           loop    

    same:
        la          $t7, 0x2a      # put "*" in $t7
        sb          $t7, ($a0)     # store in 3rd string
        j           continue

    goBack:   
        jr          $ra

    ## end of compareAndSwitch
