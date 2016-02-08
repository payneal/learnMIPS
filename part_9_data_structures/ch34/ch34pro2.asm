            .text
            .globl main

# Exercise 2 — Two Linked Lists

# In the data section declare linked list nodes for the integers 1 through 25 (using copy and paste in your text editor will help here.) Declare two symbolic addresses headP for the address of the node that contains 1, and headC for the address of the node that contains 4.

# Regard headP as the head element for a linked list of primes. Edit the nodes that belong in this list so that they are linked together in order.

# Regard headC as the head element for a linked list of composite numbers (all those not prime). Edit the nodes that belong in this list so that they are linked together in order

#Write a program (much like the one above) that first prints out the elements in the list of primes and then prints out the elements in the list of composites. Writing a subroutine that traverses a linked list would be very useful here.



#####################################################
#
#   ***** Program does what its suppose to do but, I do get multiple exceptions, IDK why?????? *************
#
######################################################

main: 

     # * technicall 1 is not a prime number  so Idk what this program is talking about

      #prime numbers: 2, 3, 5, 7, 11, 13, 17, 19, 23 

      la    $t0, headP                  # point to start of all numbers
      li    $s0, 25                     # hold 25 in $s0
      li    $t1, 0                      # count = 0
      
    loop:
      lw    $t3($t0)                    # put number in $t3
      beq   $t1,$s0, exit               # if count == 25 exit it
      nop 
      
      # its first prime # although its not really prime....
      # BUT IF THEY ARE GOING TO START HEAD C @ 4 
      # then clearly 1 is prime
      li    $t4, 1
      beq   $t4,$t3, startOfPrime

      # skipping 4 intentially becaue its first non prime
      li    $t4, 4
      beq   $t4, $t3, startOfNon

      li    $t4,2
      beq   $t4, $t3, setPrime      
      nop
 
      li    $t4,3
      beq   $t4, $t3, setPrime      
      nop

     
      li    $t4,5
      beq   $t4, $t3, setPrime      
      nop

     
      li    $t4,7
      beq   $t4, $t3, setPrime      
      nop

     
      li    $t4,11
      beq   $t4, $t3, setPrime      
      nop

     
      li    $t4,13
      beq   $t4, $t3, setPrime      
      nop

     
      li    $t4,17
      beq   $t4, $t3, setPrime      
      nop

     
      li    $t4,19
      beq   $t4, $t3, setPrime      
      nop

     
      li    $t4,23
      beq   $t4, $t3, setPrime      
      nop
    
    # then link to not prime    
      sw     $t0,($s7)     # saving address  
      addu   $s7, $t0, 4   # make $s6 point to $t0's next location
 
    backFromChange:
      addu  $t0, $t0, 8          # move tp next number
      addu  $t1, $t1, 1          # count++
      b     loop 
      nop  

    exit:
      la      $a1, headP     
      la      $a0, printPrime
      jal     printNumbers
      nop

      la      $a1, headC 
      la      $a0, printNot    
      jal     printNumbers
      nop

      # exit
        li      $v0,10         # return to OS
        syscall   

      # connect all of the prime  
      setPrime: 
         sw     $t0,($s6)     # saving address  
         addu   $s6, $t0, 4   # make $s6 point to $t0's next location
         j      backFromChange
         nop

      startOfPrime:
          # hold the next position of this number
         addu   $s6, $t0, 4   # make $s6 point to $t0's next location     
         j      backFromChange
         nop

      startOfNon: 
          # hold the next position of this number   
          addu   $s7, $t0, 4   # make $s6 point to $t0's next location
          j      backFromChange
         nop

        

            .data
printPrime: .asciiz       "The following are Prime: "
printNot:   .asciiz       "The Following are NOT Prime: "  

headP:
elmnt01:  .word  1
          .word  0

elmnt02:  .word  2
          .word  0

elmnt03:  .word  3
          .word  0

headC: 
elmnt04:  .word  4
          .word  0
          
elmnt05:  .word  5
          .word  0

elmnt06:  .word  6
          .word  0

elmnt07:  .word  7
          .word  0
 
elmnt08:  .word  8
          .word  0

elmnt09:  .word  9
          .word  0
 
elmnt10:  .word  10
          .word  0

elmnt11:  .word  11
          .word  0

elmnt12:  .word  12
          .word  0

elmnt13:  .word  13
          .word  0 

elmnt14:  .word  14
          .word  0
          
elmnt15:  .word  15
          .word  0

elmnt16:  .word  16
          .word  0

elmnt17:  .word  17
          .word  0
 
elmnt18:  .word  18
          .word  0

elmnt19:  .word  19
          .word  0
 
elmnt20:  .word  20
          .word  0

elmnt21:  .word  21
          .word  0

elmnt22:  .word  22
          .word  0

elmnt23:  .word  23
          .word  0
 
elmnt24:  .word  24
          .word  0

elmnt25:  .word  25
          .word  0
## end program


###########################################
            .text
            .globl printNumbers

printNumbers: 

            li      $v0, 4
            syscall
            
            la      $a0, newL
            syscall        

        lp:       
          beqz   $a1, done      # while not null
          lw     $a0,0($a1)     #   get the data 
          li     $v0,1          #   print it
          syscall               #
          la     $a0,space      #   print separator
          li     $v0,4
          syscall
          lw     $a1,4($a1)     #   get next
          b      lp
          nop  

        done:
          la      $a0, newL
          syscall        

          jr      $ra
          nop

        .data
space:      .asciiz         " "
newL:       .asciiz         "\n"
## end of printNUmbers
