        .text
        .globl main

#Write a program that computes the sum of the first part o
#f the harmonic series:

#1/1 + 1/2 + 1/3 + 1/4 + ...
#This sum gets bigger and bigger without limit as more terms are added in. Ask the user for a number of terms to sum, compute the sum and print it out.


main: 
    li      $v0, 4                  # code 4 == print string
    la      $a0, ask                # "number of terms"
    syscall

    li      $v0, 5                  # code 5 == read int
    syscall 

    # set up loop
    li.s    $f2,1.0                 # $f1 = constant 1.0
    li.s    $f3,2.0                 # for division
    mov.s   $f1,$f0                 # total = 0 
    move    $s0, $v0                # loop stop at $s0 
    li      $t0, 0                  # count here
        
    # begin loop
  loop: 
    beq     $t0, $s0, here

    #--------------------- 
    add.s    $f1, $f1, $f2          # add amount to total
    div.s    $f2, $f2, $f3
    
    #---------------------
    addu    $t0, $t0, 1
    j       loop  

  here: 
    li      $v0, 4                  # code 4 == print string
    la      $a0, total              # "number of terms"
    syscall

    mov.s   $f12, $f1
    li      $v0, 2 
    syscall 
   
    # terminate program
    li      $v0, 10                 # code 10 == exit
    syscall                     

        .data
ask:    .asciiz         "Number of terms to sum: "
total : .asciiz         "Total= "
## End of Main
