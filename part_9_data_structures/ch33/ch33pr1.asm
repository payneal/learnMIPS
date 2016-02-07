        .text
        .globl main

# Exercise 1 — Date

#Consider the following structure:

#struct
#{
#  int day;
#  int month;
#  int year;
#
#}
#Write a program that allocates memory for such a structure and fills it in with values such as 9/7/2003.

#Write out the values in the structure.

main:

    # allocates memory 
    li          $a0, 12         # 12 bytes of mem needed
    li          $v0,9           # code 9 == allocate mem
    syscall
    
    move        $s0, $v0        # makes safe copy 

    # fills it in with 9/7/2003
    li          $t0, 9          # hold value 9 
    li          $t1, 7          # hold value 7 
    li          $t2, 2003       # hold value 2003 

    sw          $t0, 0($s0)     # store 9 
    sw          $t1, 4($s0)     # store 7 
    sw          $t2, 8($s0)     # store 2003 

    # write out values
    
    li          $v0, 4          # code 4 == print string
    la          $a0, theDate    
    syscall

    li          $v0, 1          # code 1 == print int
    lw          $a0, 0($s0)   
    syscall
    
    li          $v0, 4          # code 4 == print string
    la          $a0, slash    
    syscall

    li          $v0, 1          # code 1 == print int
    lw          $a0, 4($s0)    
    syscall
    
    li          $v0, 4          # code 4 == print string
    la          $a0, slash    
    syscall

    li          $v0, 1          # code 1 == print int
    lw          $a0,8($s0)     
    syscall
    
    # end program
    li          $v0, 10         # code 10 == exit
    syscall


    .data
theDate:        .asciiz         "the date is: " 
slash:          .asciiz         "/"
# end of main 
