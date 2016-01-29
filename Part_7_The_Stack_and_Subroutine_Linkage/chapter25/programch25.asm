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

       
  #program that asks the user for a string. Read the string into a buffer, then reverse the string using the stack. However, unlike the example in the chapter, don't push a null character on the stack. Keep track of the number of characters on the stack by incrementing a count each time a character is pushed, and decrementing it each time a character is popped. Write out the reversed string.

        li          $v0, 4                    # code 4 = print string
        la          $a0, askforstring         # enter string
        syscall

        la          $a0, space                # set up for holding the entered string 
        li          $v0, 8                    # read string 
        syscall

        ## make sure we have string 
        #li          $v0, 4                    # code 4 = print string
        #la          $a0, space  
        #syscall
        
        li         $t0, 0                     # this is count == 0
        la         $t1, space                 # load the address of space to $t1
    
    loop: 
        lb          $t2, 0($t1)               #put letter in $t2 
        beq         $t2, $0, reverse          # jump to end if we are at end of string
       
        subu        $sp, $sp, 4               # onto stack  
        sw          $t2, ($sp)
 
        # print string to make sure
        #li          $v0, 11
        #move        $a0, $t2
        #syscall
        

        addiu       $t0, $t0, 1               # count ++
        addiu       $t1, $t1, 1               # move to next space in memory
        j           loop

    reverse:

    printIt: 

         li          $v0, 4                    # code 4 = print string   
         la          $a0, reversed             # reverse string statement
         syscall
        
         
        li          $t2, 0                     #count 

    loop2: 
        
        beq         $t2, $t0                    # if loop#1 count == loop2 
        addiu       $sp, $sp, 4                 # off stack
        # im here idk
        lw          $t3


        addiu       $t2, $t2, 1
        j            loop
       
     
        


   end:
        li          $v0, 10                   # code 10 == exit
        syscall                             

        .data


askforstring:       .asciiz                  "enter a string: " 
space:               .space                   200
reversed            .asciiz                 "the string reveresed: "

## End of program









