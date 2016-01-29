        .text
        .globl main

main: 

    ##1.)
        ## Write a program to evaluate 3ab - 2bc - 5a + 20ac - 16

        ## Prompt the user for the values a, b, and c. Try to use a small number of registers. Use the stack 
        ## to hold intermediate values. Write the final value to the monitor.

        li          $v0, 4              # code 4 == print string
        la          $a0, askforA        
        syscall
        
        li          $v0, 5              # code 5 == read int
        syscall
        
        move        $s0, $v0            # save a to $s0

        li          $v0, 4              # code 4 == print string
        la          $a0, askforB
        syscall
        
        li          $v0, 5              # code 5 == read int
        syscall 
        move        $s1, $v0            # save b to $s1 

        li          $v0, 4              # code 4 == print string
        la          $a0, askforC
        syscall

        li          $v0, 5              # code 5 == read int
        syscall 
        move        $s2, $v0            # save c to $s2
 
        mul         $t1, $s0, 3         # mult 3*a  
        mul         $t1, $t1, $s1       # mult 3a*b 
        
        subu        $sp, $sp, 4         #push 3ab on stack 
        sw          $t1, ($sp) 
        
        mul         $t1, $s1, $s2       # mult a*b
        mul         $t1, $t1, -2        # mult 2*bc

        subu        $sp, $sp, 4         # push 2bc on stack 
        sw          $t1,($sp)         

        mul         $t1, $s0, -5        # mult -5*a
        
        subu        $sp, $sp, 4         # push -5a on stack
        sw          $t1, ($sp)          

        mul         $t1, $s0, $s2       # mult a*c
        mul         $t1, $t1, 20        # mult 20ac

        subu        $sp, $sp, 4         # push 20ac on stack
        sw          $t1, ($sp)          

        li          $t1, -16            # hold -16
        
        lw          $t0, ($sp)          # pop 20ac 
        addu        $sp, $sp, 4         
        addu        $t1, $t0, $t1       # 20ac -16

        lw          $t0, ($sp)          # POP -5a
        addu        $sp, $sp, 4         
        addu        $t1, $t1, $t0       # -5a + 20ac -16 
            
        
        lw          $t0, ($sp)          # pop 2bc
        addu        $sp, $sp, 4     
        addu        $t1, $t1, $t0       # 2bc -5a + 20ac -16
    
        lw          $t0, ($sp)          # pop 3ab
        addu        $sp, $sp, 4
        addu        $t1, $t1, $t0       # 3ab - 2bc -5a + 20ac -16 
        
        ## exit
        
        li          $v0, 4              # code 4 == print string
        la          $a0, answeris
        syscall 
       
        move        $a0, $t1 
        li          $v0, 1              # print int 
        syscall

    end:
        li          $v0, 10             # code 10 == exit
        syscall 

          .data
askforA:     .asciiz   "what value would you like to use for A: "
askforB:     .asciiz   "what value would you like to use for B: "
askforC:     .asciiz   "what value would you like to use for C: "
answeris:    .asciiz   "answer is: "  
 

    ## 2.) 

  ## program that asks the user for a string. Read the string into a buffer, then reverse the string using the stack. However, unlike the example in the chapter, don't push a null character on the stack. Keep track of the number of characters on the stack by incrementing a count each time a character is pushed, and decrementing it each time a character is popped. Write out the reversed string.

        li          $v0, 4                    # code 4 = print string
        la          $a0, askforstring         # enter string
        syscall

        la          $a0, space                # set up for holding the entered string 
        li          $v0, 8                    # read string 
        syscall
        
        li         $t0, 0                     # this is count == 0
        la         $t1, space                 # load the address of space to $t1
    
    loop: 
        lb          $t2, 0($t1)               #put letter in $t2 
        beq         $t2, $0, reverse          # jump to end if we are at end of string
       
        subu        $sp, $sp, 4               # onto stack  
        sw          $t2, ($sp)
 
        ## print string to make sure
        li          $v0, 11
        move        $a0, $t2
        syscall
        
        addiu       $t0, $t0, 1               # count ++
        addiu       $t1, $t1, 1               # move to next space in memory
        j           loop

    reverse:
         li          $v0, 4                    # code 4 = print string   
         la          $a0, reversed             # reverse string statement
         syscall   
       
        li          $t2, 0                     #count 
    loop2: 
        beq         $t2, $t0, end               # if loop#1 count == loop2 
        lw          $t3, ($sp)                  # pop off a char
        addiu       $sp, $sp, 4                 # off stack
        
        sb          $t3, string($t2)            # store at string[count] 
        addiu       $t2, $t2, 1                 # add to count
        j            loop2
    
    end: 
        li          $v0, 4                      # code 4 == print string
        la          $a0, string                 # "reversed string"
        syscall  
    
        li          $v0, 10                   # code 10 == exit
        syscall                             

        .data
askforstring:       .asciiz                  "enter a string: " 
space:              .space                   200
reversed:           .asciiz                 "the string reveresed: "
string:             .space                  200

    
    ## 3.) 
        ## Exercise 3 — Vowel Removal (stack-based)
    
         ## Write a program that asks the user for a string. Read the string into a buffer. Now scan the string from right to left starting with the right-most character (this is the one just before the null termination.) Push each non-vowel character onto the stack. Skip over vowels.

        ##Now pop the stack character by character back into the buffer. Put characters into the buffer from right to left. End the string with a null byte. The buffer will now contain the string, in the correct order, without vowels.

        ## Write out the final string.
        li          $v0, 4                    # code 4 = print string   
        la          $a0, askforstring         # enter string  
        syscall
        
        la          $a0, space                # set up for holding the entered string
        li          $v0, 8                    # read string
        syscall

        ## li          $v0, 4
        ## la          $a0, wasEntered
        ## syscall

        ## li          $v0, 4 
        ## la          $a0, space
        ## syscall 
        
        ## find the size of string, so we can start righth most char
        la         $t1, space                 # put space adress in $t1
        li         $t0, 0                     # count == 0
                
    findLength: 
        lb         $t2, 0($t1)                # put letter in $t2
        beq        $t2, $0, gotSize        
        addiu      $t0, $t0, 1                # count++
        addiu      $t1, $t1, 1                # move to next char in space 
        j          findLength   

    gotSize:            
        addiu      $t0, $t0, -1                # dont count the '\n'
        move       $s0, $t0                    # hold last char index#

        ## scan the string from right to left, push non-vowel
            ## vowels = 
                ## a = 0x61 
                ##  e = 0x65 
                ## i = 0x69 
                ## o = 0x6F 
                ## u = 0x75 
                ## y * sometimes = 0x79 
        li         $t0, 0                      # count == 0 
        li         $t4, 0                      # how many non-vowel 
        la         $t1, space                  # put space address in $t1
        addu       $t1, $t1, $s0                # move to end of string
        addu       $t1, $t1, -1       
 
     loop: 
        beq        $t0, $s0, statement         
        lb         $t2, 0($t1)               #put letter in $t2  

        ##  check if its a vowel
        li         $t3, 0x61                   # hold letter a 
        beq        $t2, $t3, skip              #if vowl dont add to stack 

        li         $t3, 0x65                   # hold letter e 
        beq        $t2, $t3, skip              #if vowl dont add to stack 

        li         $t3, 0x69                   # hold letter i 
        beq        $t2, $t3, skip              #if vowl dont add to stack 

        li         $t3, 0x6F                   #hold letter o  
        beq        $t2, $t3, skip              #if vowl dont add to stack 

        li         $t3, 0x75                   #hold letter u  
        beq        $t2, $t3, skip              #if vowl dont add to stack 

        li         $t3, 0x79                   #hold letter y  
        beq        $t2, $t3, skip              #if vowl dont add to stack 

        ## if make it here put on stack beacuse its not vowel
        
        #l# i          $v0, 4                      # code 4 == print string
        ## la          $a0, storing 
        ## syscall

        ## li          $v0, 11                    # code 11 == print char 
        ## move        $a0, $t2                   # char to print
        ## syscall
        
        ## li          $v0, 4                     # code 4 == print string
        ## la          $a0, newL                  # char to print 
        ## syscall

        subu       $sp, $sp, 4                 # push 
        sw         $t2, ($sp)                  # holding the char
        addiu      $t4, $t4, 1                 # non-vowel++
     skip: 
        
        addiu     $t0, $t0,1                  # count++  
        addiu     $t1, $t1, -1                # move backwards through string
        j         loop

    statement:
        li          $v0, 4                    # code 4 == print string
        la          $a0, heresNoVowel         
        syscall

        li          $t0, 0                    # count == 0
 
    ## loop length of non-vowl poping of stack creating new string without vowels
   loop2: 
       beq        $t0, $t4, printIt
       lw         $t3, ($sp)                  #pop off a char
       addiu      $sp, $sp, 4                 # off stack 

       sb         $t3, noVowel($t0)           # store at noVowel[count] 
     
       addiu       $t0, $t0, 1                # count++
       j           loop2

    printIt:
       
        li          $v0, 4                    # code 4 == print string  
        la          $a0, noVowel
        syscall   

        la          $a0, yreason
        syscall        

    ## end
    end:
        li          $v0, 10                   # code 10 == exit
        syscall
    
    .data
askforstring:       .asciiz                  "enter a string: "  
wasEntered:         .asciiz                  "this was entered: "
space:              .space                   200
noVowel:            .space                   200
heresNoVowel:       .asciiz                  "string without vowels: "
newL:               .asciiz                  "\n"
storing:            .asciiz                  "storing this: "
yreason:            .asciiz                  "\n*only lower case\n*y always considered vowel"
## End of program


