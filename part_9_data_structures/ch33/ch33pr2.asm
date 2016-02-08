        .text
        .globl main

# ex.2 

# Consider the following structure, the same as for Exercise 1:

#struct
#{
#  int day;
#  int month;
#  int year;
#}

#Write a program that asks the user for how many dates are needed and then allocates space (all at one time) for that many structs.

#Then, in a loop, ask the user for the values to put in each structure. Do this by initializing a structure pointer to the first address of the allocated space. Then add the size of a structure to it for each execution of the loop.

#Finally, write out the contents of all the structures.

main: 
        li      $v0, 4         # code 4 == print string
        la      $a0, amount     
        syscall

        li      $v0, 5          # code 5 == read int 
        syscall 
        move    $s0, $v0        # hold in s0 
        
        mul     $t0, $s0, 4     # need to hild this many 
        mul     $t0, $t0, 3         

        move    $a0, $t0        #bytes of mem needed 
        li      $v0, 9          # code 9 == allocate mem 
        syscall 
        move    $s1, $v0        # make safe copy 

        # set up loop
        li      $t0, 0          # count = 0 
        move    $t1, $s1        # point to start of array

    loop: 
        beq     $t0, $s0, next  # if count == dates needed break
        # ask for day 
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
        la      $a0, month
        syscall

        li      $v0,5 
        syscall   
        # save year
        sw      $v0,($t1)
        addu    $t1, 4          # move to stuct
             
        addu    $t0, 1          # count++
        b       loop    
        
    next: 
        # write out contents of all structs  
        li      $t0, 0          #  reset count = 0 
        move    $t1, $s1        # point to start of array

    loop2: 
        beq     $t0, $s0, exit  # if count == dates needed break
        
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
                
        addu    $t0, $t0 1      # count++
        b       loop2

    # end program
    exit:
        li      $v0, 10         # exit code == 10 
        syscall 

      .data
amount:         .asciiz         "how many dates are needed: "
day:            .asciiz         "day: "
month:          .asciiz         "month: "
year:           .asciiz         "year: "
theDate:        .asciiz         "the date is: " 
slash:          .asciiz         "/"
array:          .asciiz         "array "
equals:         .asciiz         " = "
newL:            .asciiz         "\n"
## end of main 



