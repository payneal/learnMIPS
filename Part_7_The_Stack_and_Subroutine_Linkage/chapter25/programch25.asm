        .text
        .globl main

main: 

    #1.)
        # Write a program to evaluate 3ab - 2bc - 5a + 20ac - 16

        # Prompt the user for the values a, b, and c. Try to use a small number of registers. Use the stack 
        # to hold intermediate values. Write the final value to the monitor.

        #li          $v0, 4              # code 4 == print string
        #la          $a0, askforA        
        #syscall
        
        #li          $v0, 5              # code 5 == read int
        #syscall
        
        #move        $s0, $v0            # save a to $s0

        #li          $v0, 4              # code 4 == print string
        #la          $a0, askforB
        #syscall
        
        #li          $v0, 5              # code 5 == read int
        #syscall 
        #move        $s1, $v0            # save b to $s1 

        #li          $v0, 4              # code 4 == print string
        #la          $a0, askforC
        #syscall

        #li          $v0, 5              # code 5 == read int
        #syscall 
        #move        $s2, $v0            # save c to $s2
 
        #mul         $t1, $s0, 3         # mult 3*a  
        #mul         $t1, $t1, $s1       # mult 3a*b 
        
        #subu        $sp, $sp, 4         #push 3ab on stack 
        #sw          $t1, ($sp) 
        
        #mul         $t1, $s1, $s2       # mult a*b
        #mul         $t1, $t1, -2        # mult 2*bc

        #subu        $sp, $sp, 4         # push 2bc on stack 
        #sw          $t1,($sp)         

        #mul         $t1, $s0, -5        # mult -5*a
        
        #subu        $sp, $sp, 4         # push -5a on stack
        #sw          $t1, ($sp)          

        #mul         $t1, $s0, $s2       # mult a*c
        #mul         $t1, $t1, 20        # mult 20ac

        #subu        $sp, $sp, 4         # push 20ac on stack
        #sw          $t1, ($sp)          

        #li          $t1, -16            # hold -16
        
        #lw          $t0, ($sp)          # pop 20ac 
        #addu        $sp, $sp, 4         
        #addu        $t1, $t0, $t1       # 20ac -16

        #lw          $t0, ($sp)          # POP -5a
        #addu        $sp, $sp, 4         
        #addu        $t1, $t1, $t0       # -5a + 20ac -16 
            
        
        #lw          $t0, ($sp)          # pop 2bc
        #addu        $sp, $sp, 4     
        #addu        $t1, $t1, $t0       # 2bc -5a + 20ac -16
    
        #lw          $t0, ($sp)          # pop 3ab
        #addu        $sp, $sp, 4
        #addu        $t1, $t1, $t0       # 3ab - 2bc -5a + 20ac -16 
        
        ## exit
        

        #li          $v0, 4              # code 4 == print string
        #la          $a0, answeris
        #syscall 
       
        #move        $a0, $t1 
        #li          $v0, 1              # print int 
        #syscall

    #end:
        #li          $v0, 10             # code 10 == exit
        #syscall 

          #.data
#askforA:     .asciiz   "what value would you like to use for A: "
#askforB:     .asciiz   "what value would you like to use for B: "
#askforC:     .asciiz   "what value would you like to use for C: "
#answeris:    .asciiz   "answer is: "  
 

    #2.) 

        

       ## End of program
