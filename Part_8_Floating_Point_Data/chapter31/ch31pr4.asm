        .text
        .globl main

# Write a program that computes the value of a polynomial using Horner's method. The coefficients of the polynomial are stored 
# in an array of single precision floating point values:

# The size and the values in the array may change. Write the program to initialize a sum to zero and then loop n times.
# Each execution of the loop, with loop counter j, does the following:

# sum = sum*x + a[j]

# To test and debug this program, start with easy values for the coefficients.

main: 
    
    li      $v0, 4         # print string
    la      $a0, x         # "what value would like for x: "
    syscall

    li      $v0, 6         # code 6 == read float
    syscall

    mov.s   $f3,$f0         # put answer in f1

    # grab the loop size 
    lw      $t1, n          # put the loop in $t0
    li      $t0, 0          # count = 0 
    mov.s   $f1, $f0        # total == 0
    
    # loop begins
  loop: 
    beq     $t0, $t1, showA
    
    mul.s   $f2, $f1, $f3   # sum * x
    
    la      $t2, a          # load the adress  
    mul     $t3, $t0, 4     # index adress = count*4
    addu    $t2, $t2, $t3   # get to the right index spot
    l.s     $f5, ($t2)      # put indexed float in $f5
    
    add.s   $f1, $f2, $f5   # sum*x  + a[j]  
    
    addu    $t0, $t0, 1     # count++
    j       loop
          
showA:
    li      $v0, 4         # print string
    la      $a0, x         # "answer: "
    syscall

    mov.s   $f12, $f1
    li      $v0, 2
    syscall
 
    # end the program
    li      $v0, 10 
    syscall

        .data
n:      .byte       5
a:      .float      4.3, -12.4, 6.8, -0.45, 3.6
x:      .asciiz     "what value would you like for x: "
test:   .asciiz     "a[j] = "
answer: .asciiz     "answer = "
## end of program
