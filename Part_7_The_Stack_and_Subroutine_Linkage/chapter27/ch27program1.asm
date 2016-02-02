    .text
    .globl main
    
    # Write a program that prompts the user for a string. The program reads in the string and then prompts for another string 
    # and reads it in. Then the program writes a message that says if the two strings are character-by-character identical.

    #Use at least three routines (counting main) for this.

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
        
        ## see if strings are identical
        la          $a1, string1
        la          $a2, string1
        jal         compare
        nop 
 
        ## end the program
        li          $v0, 10             # code 10 == exit
        syscall

    .data
first:   .asciiz      "First String\n"
second:  .asciiz      "Second String\n"
newL:    .asciiz      "\n"
string1: .space        200 
string2: .space        200
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
##### compare ##########
########################

# compares to strings to see if they are identical

    .text
    .globl compare

compare:
        # set up loop
        li          $t0, 0       # count = 0
        li          $t1, 10      # end of unix string

    loop:
        lb          $t2, ($a2)
        lb          $t3, ($a1)        
        
        bne         $t2, $t3, bad
        beq         $t2, $t1, good
        
        addu        $a1, $a1, 1
        addu        $a2, $a2, 1
        addu        $t0, $t0, 1
            
        j           loop    

    good:
        li          $v0, 4
        la          $a0, same
        syscall 
        jr          $ra
                         
    bad: 
        li          $v0, 4
        la          $a0, diff
        syscall 
        jr          $ra

.data
same:   .asciiz         "the two strings enterd are identical\n"
diff:   .asciiz         "the two strings are NOT identical\n"


