        .text
        .globl main

# ex. 1
# Write a program that computes value of the following arithmetic expression for values of x and y entered by the user:
#                              
# 5.4xy - 12.3y + 18.23x - 8.23

main: 
    li              $v0, 4              # code 4 == print string
    la              $a0, ask1           # "value for x: "       
    syscall   
 
    li              $v0, 6              # code 6 == read float
    syscall
   
    mov.s           $f1, $f0            # put answer in f1

    li              $v0, 4              # code 4 == print string
    la              $a0, ask2           # "value for y: "       
    syscall   
 
    li              $v0, 6              # code 6 == read float
    syscall
   
    mov.s           $f2, $f0            # put answer in f1

    l.s             $f3, one            # put 5.4 in f3 
    l.s             $f4, two            # put 12.3 in f4
    l.s             $f5, three          # put 18.23 in f5
    l.s             $f6, four           # put 8.23 in f6

    mul.s           $f0, $f3, $f1       # 5.4 * x 
    mul.s           $f0, $f2, $f0       # (5.4x)y 
    
    mul.s           $f4, $f4, $f2       # 12.3*y 

    sub.s           $f0, $f0, $f4       # 5.4xy - 12.3y 
    
    mul.s           $f4, $f5, $f1       # 18.23x

    add.s           $f0, $f0, $f4       # 5.4xy - 12.3y + 18.23x 

    sub.s           $f0, $f0, $f6       # 5.4xy - 12.3y + 18.23x - 8.23 

    li              $v0, 4              # code 4 == print string
    la              $a0, answer         # "value for y: "       
    syscall 

    li              $v0, 2              # code 4 == print string
    mov.s           $f12, $f0           # "t or s"    
    syscall  
    
    # end of main
    li          $v0, 10
    syscall

        .data
ask1:   .asciiz         "value for x: "
ask2:   .asciiz         "value for y: " 
answer: .asciiz         "answer: "
one:    .float          5.4
two:    .float          12.3
three:  .float          18.23
four:   .float          8.23
# end of main

