        .text
        .globl main

# Write a program that computes exp(x) by using a Taylor series:

# exp(x) = 1 + x + x2/2 + x3/3! + x4/4! + ...
# The user enters x. exp(x) is ex, where e is the base of the natural logarithms, 2.718281828... You don't need to worry about the math behind this. Just compute a sum of terms. Each term in the sum looks like:

# xn/n!
# Designate a register to hold the current term. Initialize it to 1.0 (the zeroeth term). Term one is calculated by multiplying:

# term*x/1
# T erm one is the value x. Term two is calculated by multiplying:

# term*x/2
# Term two is the value x2/2. Term three is calculated by multiplying:

# term*x/3
# Term three is the value x3/3!. Term four is calculated by multiplying:

# term*x/4
# ... and so on. In general, after you have added term (n-1)to the sum, calculate term n by multiplying:

# term *x/n
# Keep doing this in a loop until the term becomes very small. Here are some example runs (with SPIM using single precision). As usual, only the first seven digits printed have any significance.

#  https://www.youtube.com/watch?v=APVhIIN4zJ8 

main:
    li      $v0, 4          # code 4 = print string
    la      $a0, askx       # "what 4 x: "
    syscall

    li      $v0, 6          # code 6 = read float 
    syscall                 

    mov.s   $f1, $f0        # hold the answer in $f1 
    
    

        .data
askx:   .asciiz "what value would you like for x: "
## end of main

