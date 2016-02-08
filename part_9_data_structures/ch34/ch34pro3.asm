                .text
                .globl main 
# Exercise 3 — Sum of Elements

#Copy the final program of the chapter, linked.asm. Modify it so that instead of printing the elements of the linked list it adds them all together. Upon reaching the end of the list it prints out the sum.

main: 
    
          la     $s0,head     # get pointer to head
          li     $t0, 0       # set total = 0

loop:     beqz   $s0, done      # while not null
          lw     $t1,0($s0)     #   get the data 
          addu   $t0, $t0, $t1  # total += data

          lw     $s0,4($s0)     #   get next
          b      loop
          nop  
        
done:    
          li    $v0, 4          # code for print string
          la    $a0, total
          syscall
            
          move   $a0,$t0        # print the total
          li     $v0,1          # code for print int
          syscall
          
          li     $v0,10         # return to OS
          syscall   


# i dont understand how to implement tail without getting expection error, program still works 
          .data
total:    .asciiz       "TOTAL = "

elmnt06:  .word  11
          .word  elmnt07
elmnt07:  .word  13
          .word  elmnt08
elmnt08:  .word  17
          .word  elmnt09
elmnt09:  .word  19
          .word  elmnt10
elmnt10:  .word  23
          .word  0
head: 
elmnt01:  .word  1
          .word  elmnt02
elmnt04:  .word  5
          .word  elmnt05
elmnt05:  .word  7
          .word  elmnt06
elmnt02:  .word  2
          .word elmnt03 
elmnt03:  .word  3
          .word elmnt04 
## end of the main

