.text
.globl main


main: 
    
    # create the first linked list
    
    li  $v0, 9          # need to request memory
    li  $a0, 8          # 8 bytes of memory
    syscall 
    move $s0,$v0        # now $s0 holds first link
     
    move   $s1, $s0        # now $s1 holds start of first link 

    # first word stores word
    # 2nd word stores location of next node
   
    # get first string
    li $v0, 4           # code 4 = print
    la $a0, enter       # "enter a string
    syscall             

    li $a1, 17          # only hold 16 chars 
    li $v0, 8           # collect the entered string
    syscall

    move $t0, $a0       # hold string at $t0 
    
    li  $v0, 9           # need to request memory
    li  $a0, 17          # hold 16 bytes  for 16 char string
    syscall 
 
    sw $t0,0($v0)       # store the string in the created memory
 
    sw  $v0,0($s0)      # store address of string @ first 4 bytes of linked list

    # create second linked list
    li  $v0, 9          # need to request memory
    li  $a0, 8          # 200 bytes to be exact idk why I did that
    syscall

    sw  $v0,4($s0)      # store the next linked list adress in Linked list1

   move $s0,$v0         # makes $s0 now hold newly created linked list
    
    
    # ask for new string
    li $v0, 4           # code 4 = print
    la $a0, enter       # "enter a string
    syscall             

    li $v0, 8           # collect the entered string
    syscall

    move $t0, $a0       # hold string at $t0 

    li  $v0, 9          # need to request memory
    li  $a0, 17         # 17 bytes to hold 16 chars
    syscall

    sw $t0,0($v0)       # store the string in the created memory
    
    sw $v0,0($s0)       # store address of string @ first 4 of linked list

    # im ending it here so
    sw $0,4($s0)        # this linked list points to null
    

    # now try to print everything
    move     $t0, $s1
    lw     $t1, 0($t0)  # the adress of the 1st linked list string
    lw     $t2, 4($t0)  # the adress of the next linked list

  loop: 
    beq    $t2, $0, done    # if the next linked list adress == null then done
    
    li      $v0, 4      # code 4 == print string 
    la      $a0, you    # "you entered the following"
    syscall
    
    lw      $a0, 0 ($t0) 
    syscall 

    la      $a0, newL
    syscall 

    move    $t0, $t2
    lw     $t1, 0($t0)  # the adress of the 1st linked list string
    lw     $t2, 4($t0)  # the adress of the next linked list
    j       loop
    nop
       
done: 
    # exit program
    li      $v0,10            # return to OS
    syscall       

        .data
enter:  .asciiz     "enter a string: "
you:    .asciiz     "you entered the following: "
newL:   .asciiz     "\n"
test:   .word      0 

# end of main
