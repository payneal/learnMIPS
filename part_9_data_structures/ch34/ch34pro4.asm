        .text 
        .globl main 

# Copy the final program of the chapter, linked.asm. Modify it so that it does the following: The user enters an integer and then the program traverses the list looking at each node until it finds that integer. It prints out a message when it finds the integer. If it continues to the end of the list without finding the integer it prints out a failure message.

#Keep doing this until the user enters a negative value to signal the end.



main: 
            li      $v0, 4          # code 4 + print string
            la      $a0,ask         # "ask "
            syscall 
     
            li      $v0, 5 
            syscall
            
            blt     $v0, $0, exit
            move    $s1, $v0            
  
            # check through linked list
            la     $s0,head       # get pointer to head
          
        loop:     
            beqz   $s0,done       # while not null
            lw     $t0,0($s0)     #   get the data 
        
            bne    $t0,$s1,skip
            nop
            li      $v0, 4          # code 4 + print string
            la      $a0,found         # "ask "
            syscall 
            j       main


            skip:   
         

            lw     $s0,4($s0)     #   get next
            b      loop            
                        
       done:

            # if you make it here then its not in linked list
            li      $v0, 4          # code 4 + print string 
            la      $a0,notfound         # "not found "
            syscall 
            j       main
            
          exit: 
            li      $v0, 4          # code 4 + print string
            la      $a0,terminated  # "ask "
            syscall 

 
            li      $v0, 10         # exit code == 10 
            syscall 

                .data
ask:            .asciiz     "what nuber do you want to look for: "
terminated:     .asciiz     "You terminated the program\n"
found:          .asciiz     "your entered number was found\n"
notfound:            .asciiz     "your entered number was NOT found\n"

head:
elmnt01:  .word  1
          .word  elmnt02

elmnt02:  .word  2
          .word elmnt03 

elmnt03:  .word  3
          .word elmnt04 

elmnt04:  .word  5
          .word  elmnt05
          
elmnt05:  .word  7
          .word  0


## end of main
