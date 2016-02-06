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

# void main() {                         
#   float power;                        
#   printf("Enter the power of e\n");   
#   scanf("%f,&power");                 
#   int acc=4;                          
#   float ans=1;                        
#   float temp+1;                       
#   int i;                              
#   for(i=1; i<=acc; i++){              
#       temp = (temp*power)/i;          
#       ans=ans+temp;                   
#   }                                   
#   printf("%f",ans);                   
# }                                     

main:
    li      $v0, 4          # code 4 = print string
    la      $a0, askx       # "what 4 x: "
    syscall

    li      $v0, 6          # code 6 = read float 
    syscall                 

    mov.s   $f1, $f0        # hold the answer in $f1
    
    li      $v0, 4          # code 4 = print string
    la      $a0, howClose       # "what 4 x: "
    syscall

    li      $v0, 5          # code 5 = read int 
    syscall                 
    
    move    $s1, $v0        # hold how close in $t1
    li.s    $f2, 1.0        # float answer = 1 
    li.s    $f3, 1.0        # float temp   = 1

    # loop stuff
    li      $t0,1           # loop count == 1

    # the loop
  loop:
    bgt     $t0,$s1, done    # jump we have e^x as close as requested
    
    mul.s   $f3, $f3,$f1    # temp = temp*x
    
    mtc1    $t0, $f12       # convert loop count to float
    cvt.s.w $f12, $f12    

    div.s   $f3, $f3, $f12  # temp = (temp*x)/loopcount(float) 
    add.s   $f2, $f2, $f3   # ans = ans +temp
    addu    $t0, $t0, 1     # count ++
    j       loop 
    
  done:
    li      $v0, 4          # code 4 = print string
    la      $a0, answer     # "what 4 x: "
    syscall

    mov.s   $f12, $f2       # put answer in $f12
    li      $v0, 2          # code to print float
    syscall 
    
    # end program
    li      $v0, 10         # exit program
    syscall
    
            .data
askx:       .asciiz "what value would you like for x(float): "
howClose:   .asciiz "how percise(int): "
answer:     .asciiz "e^x = "

## end of main

