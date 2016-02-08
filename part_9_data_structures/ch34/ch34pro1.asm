            .text 
            .globl main 

# Copy the final program of the chapter, linked.asm and get it to work. Now rearrange the order of the elements of the linked list that are declared in memory. Check that the program still works.

# Next, add more elements to the list. If you wish to keep this a list of prime numbers, add elements for 11, 13, 17, 19, and 23. Add these to scattered locations in the data section. Check that the program still works.

main:
          la     $s0,head     # get pointer to head
          
loop:     beqz   $s0, done      # while not null
          lw     $a0,0($s0)     #   get the data 
          li     $v0,1          #   print it
          syscall               #
          la     $a0,sep        #   print separator
          li     $v0,4
          syscall
          lw     $s0,4($s0)     #   get next
          b      loop
          nop  
        
done:     la     $a0,linef      # print end of line
          li     $v0,4
          syscall               # print ending message
          la     $a0,endmess
          li     $v0,4
          syscall
          
          li     $v0,10         # return to OS
          syscall   


# i dont understand how to implement tail without getting expection error, program still works 
          .data

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
              
sep:      .asciiz "  "
linef:    .asciiz "\n"
endmess:  .asciiz "done\n"
## end of program 

