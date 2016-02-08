        .text 
        .globl main 

# Exercise 3 — Array of Structure Pointers

# Consider the following structure, the same as for the above exercises:

# struct
# {
#  int day;
#  int month;
#  int year;
# }

#In the static data section of your program declare space for an array of up to 25 addresses:

#Not all of the potential addresses will be used. The field size starts at zero because to start, none of the addresses are used.

#Write a program that asks the user for how many dates are needed. Set size to that amount. Now a counting loop executes for that many times. Each execution of the loop allocates space for one data, puts the address of that date in the array of addresses, asks the user for values for that data, and finally, fills the date with those values.

#At the end of the program write out the values in the dates. Do this by scanning through the array of addresses to access each date. (Probably the dates will be in order in a contiguous block of memory, but a real-world program can not count on this being true.)

main: 

        li      $v0, 4          # code 4 = print string
        la      $a0, how        # "how many?"
        syscall 
    
        li      $v0, 5          # code 5 == read int
        syscall

        li      $t0, 25         # hold 25 
        
        bgt     $v0, $t0,badNum # cant be bigger than 25
        nop     
        li      $t0, 1 
        blt     $v0, $t0,badNum # cant be lower than 1
        nop

        move    $s0, $v0        # hold number entered

        # set up loop
        li      $t0, 0          # count = 0 
        la      $t1, dates      # point to start of array

    loop: 
        beq     $t0, $s0, next  # count == number entere branch
        
        # ak for day 
        li      $v0, 4
        la      $a0, day
        syscall

        li      $v0,5 
        syscall         
        # save day
        sw      $v0,($t1)
        addu    $t1, 4          # move to month
        
        # ask for month 
        li      $v0, 4
        la      $a0, month
        syscall

        li      $v0,5 
        syscall 
        # save month 
        sw      $v0,($t1)
        addu    $t1, 4          # move to year
        # ask for year 
        li      $v0, 4
        la      $a0, year
        syscall

        li      $v0,5 
        syscall   
        # save year
        sw      $v0,($t1)
        addu    $t1, 4          # move to stuct
            
        addu    $t0, $t0,1      # count++ 
        j       loop
        nop

    # print out all of the stuff 
    next:     
       
        # stuff for loop
        li      $t0, 0          # count = 0 
        la      $t1, dates      # point to start of array

    loop2: 
        beq     $t0, $s0, exit  # count == number branch out 

        li      $v0, 4 
        la      $a0, array 
        syscall 
    
        li      $v0, 1 
        move    $a0, $t0 
        syscall     

        li      $v0, 4 
        la      $a0, equals
        syscall 

        li          $v0, 1          # code 1 == print int
        lw          $a0, 0($t1)   
        syscall
        addu        $t1, $t1, 4

        li      $v0, 4 
        la      $a0, slash
        syscall 

        li          $v0, 1          # code 1 == print int
        lw          $a0, 0($t1)   
        syscall
        addu        $t1, $t1, 4

        li      $v0, 4 
        la      $a0, slash
        syscall 

        li          $v0, 1          # code 1 == print int
        lw          $a0, 0($t1)   
        syscall
        addu        $t1, $t1, 4

        li      $v0, 4 
        la      $a0, newL
        syscall 
       
        addu    $t0, $t0, 1         # count++
        b       loop2

    # end of the program
    exit: 
        li      $v0, 10         # code 10 == exit
        syscall

    badNum: 
        li      $v0, 4          # code 4 = print string
        la      $a0, high       # "try again"
        syscall 
        j       main
        nop
    
          .data
size:           .word           0
dates:          .space          25*4          
how:            .asciiz         "how many dates are needed: "
high:           .asciiz         "try again must be between 1-25\n"
entred:         .asciiz         "you entred the following: \n"
day:            .asciiz         "day: "
month:          .asciiz         "month: "
year:           .asciiz         "year: "
array:          .asciiz         "array " 
equals:         .asciiz         " = "
slash:          .asciiz         "/"
newL:           .asciiz         "\n"
# end of program

