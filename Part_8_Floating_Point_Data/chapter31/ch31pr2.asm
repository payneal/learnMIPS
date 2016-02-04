        .text
        .globl main

main: 
    li      $v0, 4                  # code 4 == print string
    la      $a0, ask                # "number of terms"
    syscall

    li      $v0, 5                  # code 5 == read int
    syscall 

    # set up loop
    

    # begin loop


    li      $v0, 10                 # code 10 == exit
    syscall                     

        .data
ask:    .asciiz         "Number of terms to sum: "

## End of Main
