## Exercise 1A
##
## Program to put DEADBEEF bit pattern into register $1

    .text
    .globl main

main:

    #Exercise #1

    #A        
    ori         $1, $0, 0xDEAD      #put bit pattern in register $1 DEAD 
    sll         $1, $1, 16          #move over 16 bits = DEAD 0000   
    ori         $1, $1, 0xBEEF      # add BEEF so -> $1 - DEADBEEF
    #---------------------------------------------------------------------

    #B 
    #Somewhat harder: do this one letter at a time, using ori to load each letter (each nibble)
    #into a register, then shifting it into position. You will need to use ori, or, and sll instructions. 
    #Look at the contents of register $1 as you push F10 to single step the program.
    
    # assumed that I couldnt use  functions, arrays or loops

    ori $2, $0, 0xD                 # put D in $2
    sll $2, $2, 4                   # shift over 4 bits 
    ori $2, $2, 0xE                 # add E to $2
    sll $2, $2, 4                   # shift over 4 bits
    ori $2, $2, 0xA                 # add A to $2
    sll $2, $2, 4                   # shift over 4 bits 
    ori $2, $2, 0xD                 # add D to $2
    sll $2, $2, 4                   # shift over 4 bits 
    ori $2, $2, 0xB                 # add B to $2
    sll $2, $2, 4                   # shift over 4 bits 
    ori $2, $2, 0xE                 # add E to $2
    sll $2, $2, 4                   # shift over 4 bits 
    ori $2, $2, 0xE                 # add E to $2
    sll $2, $2, 4                   # shift over 4 bits 
    ori $2, $2, 0xF                 # add F to $2

    #looks like we have created DEADBEEF again     

    #---------------------------------------------------------------------
    
    ori $1, $0, 0                   # clear out reg #1 for Question2 
    ori $2, $0, 0                   # clear out reg #2

    #--------------------------------------------------------------------

    # Exercise #2
    
    #instructions: 
        # : In each register $1 through $7 set the corresponding bit. That is, in register 1 set bit 1 
        # (and clear the rest to zero), in $2 set bit 2 (and clear the rest to zero), and so on. Use only 
        #one ori instruction in your program, to set the bit in register $1.

        #       ori   $1,$0,0x01
       
         # Don't use any ori instructions other than that one. Note: bit 1 of a register is the second from the
         #right, the one that (in unsigned binary) corresponds to the first power of two.    
   
    ori $1, $0, 0x01            # put 1 in bit 1 
    sll $2, $1, 1               # 10
    sll $3, $2, 1               # 100
    sll $4, $3, 1               # 1000         
    sll $5, $4, 1               # 10000
    sll $6, $5, 1               # 100000
    sll $7, $6, 1               # 1000000

    #------------------------------------------------------------------------
    
    #clear out reg 1-7
    ori $1, $0, 0
    ori $2, $0, 0
    ori $3, $0, 0
    ori $4, $0, 0
    ori $5, $0, 0
    ori $6, $0, 0
    ori $7, $0, 0          

    #------------------------------------------------------------------------
    #Exercise #3
    
    #instructions: 
        # Start out a program with the instruction that puts a single one-bit
        # into register one:

         #ori   $1,$0,0x01
        
        # Now, by using only shift instructions and register to register logic instruction
        # , put the pattern 0xFFFFFFFF into register $1. Don't use another ori after the
        # first. You will need to use more registers than $1. See how few instructions
        # you can do this in. My program has 11 instructions.  

    ori     $1, $0, 0x01        # your one and only ori, set 1
    sll     $2, $1, 1           # shifted over one so 1 -> 10
    addu    $2 ,$2, $1          # added 1 + 10 => 11
    sll     $1, $2, 2           # shifted over 2 so 11-> 1100
    addu    $2 ,$2, $1          # added 11 + 1100 = 1111
    sll     $1, $1, 2           # shifter over 2 so 1100 -> 110000
    addu    $2, $1, $2          # added 110000 + 1111 = 111111
    sll     $1, $1, 2           # shfited over 2 so 110000 = 11000000
    addu    $2, $1, $2          # added 111111 + 11000000 = 11111111
    sll     $2, $2, 8           # shifted over 8 so 1111111100000000
    
    srl     $6, $2, 8           # heled 111111111 in a reg
    addu    $2, $6, $2          # add 1111111100000000 + 11111111
   
    sll    $2, $2, 8            # see below 
    # shift over 10 = 11111111111111111100000000
    
    addu    $2, $2, $6          # did some math my friend
    # should be 111111111111111111111111111 (need 36 1's to get FFFFFFFF)

    sll     $2, $2, 8           #shift 8 so now i got 32 bits
    addu    $1, $2, $6           #add 11111111 and now should have FFFFFFFF

    # I could edit this and get less steps I didnt undertstand when I first started to be honest but Im just trrying to get done

    #----------------------------------------------------------------------

    # clear out everything that I changed but stack pointer reg #29
    ori $1, $0, 0
    ori $2, $0, 0 
    ori $6, $0, 0
  
    #----------------------------------------------------------------------

    # Exercise 4
    
    #instructions: 
       # Put the bit pattern 0x55555555 in register $1. (Do this with three instructions.)

        # Now shift the pattern left one position into register $2 (leave $1 unchanged).

        # Put the the bit-wise OR of $1 and $2 into register $3. Put the the bit-wise AND of $1 and $2 into register $4. Put the the bit-wise XOR of $1 and $2 into register $5.

        # Examine the results.

        ori     $1, $0, 0x5555      # put bit pattern in $1 0x5555
        sll     $1, $1, 16          # shift left 16 bits
        ori     $1, $1, 0x5555      # add 0x5555 to the end

        # (3 instructions to put 0x55555555 in reg#1
        
        sll     $2, $1, 1           # shift teh pattern left one put in $2
        # 1010 1010 1010 1010 1010 1010 1010 1010
        or      $3, $1, $2          # bit-wise or $1 and $2 into $3
        # 1111 1111 1111 1111 1111 1111 1111 1111
        and     $4, $1, $2          # bit-wise and $1 and $2 into $4
        # 0000 0000 0000 0000 0000 0000 0000 0000
        xor     $5, $1, $2          # bit-wise xor $1 and $2 into $5
        # 1111 1111 1111 1111 1111 1111 1111 1111
            
    #----------------------------------------------------------------------
    
    # clear out used registers
        
        ori $1, $0, 0       #clearing regs 1-5
        ori $2, $0, 0
        ori $3, $0, 0
        ori $4, $0, 0
        ori $5, $0, 0

    #---------------------------------------------------------------------
 
    # Exercise 5
    
    #instructions:
        # Put the bit pattern 0x0000FACE into register $1. This is just an example pattern; assume that $1 can start out with any pattern at all in the low 16 bits (but assume that the high 16 bits are all zero).

        # Now, using only register-to-register logic and shift instructions, rearrange the bit pattern so that register $2 gets the bit pattern 0x0000CAFE.

        # Write this program so that after the low 16 bits of $1 have been set up with any bit pattern, no matter what bit pattern it is, the nibbles in $2 are the same rearrangement of the nibbles of $1 shown with the example pattern. For example, if $1 starts out with 0x00003210 it will end up with the pattern 0x00001230

        #A. Moderately Easy program: do this using ori instructions to create masks, then use and and or instructions to mask in and mask out the various nibbles. You will also need rotate instructions.

        #B. Somewhat Harder program: Use only and, or, and rotate instructions.

   # ori     $1, $0, 0x1000          # setting up test program 0x1000FACE 
   # sll     $1, $1, 16              # shift over 16 bits 
    ori     $1, $1, 0xFACE          # now test case $1 = Ox10000FACE 

    # things are technically in place

    ori     $2, $0, 0x0F0F          # created the bit mask 
    and    $2, $1, $2              # have mask holding A and E 

    ori     $3, $0, 0xF000          # another bit mask 
    and    $3, $1, $3              # pattern  holding F 
    srl     $3, $3, 8               # we put F in C's spot 
     
    ori     $4, $0, 0x00F0          # another bit mask 
    and    $4, $1, $4              # pattern holding c 
    sll     $4, $4, 8               # we put C in Fs spot

    # now its time to or all the bit mask

    or     $2, $2, $3
    or     $2, $2, $4
    
    or    $1, $0, $2

    # Chris said I could just do A, because we were not sure on directions

    #----------------------------------------------------------------------
    
    # clear out used registers
    ori $1, $0, 0       #clearing regs 1-4
    ori $2, $0, 0
    ori $3, $0, 0
    ori $4, $0, 0
    #----------------------------------------------------------------------

    #Exercise #6
    
    #instructions: 
        #Start out register $1 with any 32-bit pattern, such as 0x76543210. Now, put the reverse of that pattern into register $2, for the example, 0x01234567.
    
    # $1 holds the original pattern
    # $2 holds the mask
    # $3 holds the pattern where making
    # $4 holds what we are working on

    ori     $1, $0, 0x8765          # put bit pattern in $1 8765
    sll     $1, $1, 16              # move over 16 bits = 87650000
    ori     $1, $1, 0x4321          # add 3201 so 0x87654321
 
    ori     $2, $0, 0xF             # $2 =0000 0000F

    and     $2, $1, $2              # 8675 4321
                                    # 0000 000F
                                    # ---------
                                    # 0000 0001
   
    #next

    sll     $2, $2, 4               # $2 = 0000 0010
    ori     $3, $0, 0xF0            # $3 = 0000 00F0

    and     $3, $1, $3              # 8675 4321
                                    # 0000 00F0
                                    # ---------
                                    # 0000 0020

    srl     $3, $3, 4               # $3 = 0000 0002
    
    or      $2, $2, $3              # 0000 0010
                                    # 0000 0002
                                    # ---------
                                    # 0000 0012
   
    # next 
 
    sll     $2, $2, 4               # $2= 0000 0120    
    ori     $3, $0, 0xF00           # $3 - 0000 0F00

    and     $3, $1, $3              # 8675 4321
                                    # 0000 0F00
                                    #----------
                                    # 0000 0300
    
    srl     $3,$3,8                 # $3= 0000 0003 
    
    or      $2, $2, $3              # 0000 0120
                                    # 0000 0003
                                    #----------
                                    # 0000 0123
    #next
    
    sll     $2, $2, 4               # $2= 0000 1230
    ori     $3, $0, 0xF000          # $3= 0000 F000
    
    and     $3, $1, $3              # 8675 4321
                                    # 0000 F000
                                    #----------
                                    # 0000 4000
    
    srl    $3, $3, 12               # 0000 0004
    
    or     $2, $2, $3               # 0000 1230
                                    # 0000 0004
                                    #----------
                                    # 0000 1234
    
    #next
    
    sll     $2, $2, 4               # $2= 0001 2340
    ori     $3, $0, 0xF
    sll     $3, $3, 16              #$3 = 0xF 0000
    
    and     $3, $1, $3
    srl     $3, $3, 16 
    or      $2, $2, $3
   
    #next
    
    sll     $2, $2, 4
    ori     $3, $0, 0xF0
    sll     $3, $3, 16
    and     $3, $1, $3
    srl     $3, $3, 20
    or      $2, $2, $3

    #next

    sll     $2, $2, 4
    ori     $3, $0, 0xF00
    sll     $3, $3, 16
    and     $3, $1, $3
    srl     $3, $3, 24
    or      $2, $2, $3

    #next

    sll     $2, $2, 4 
    ori     $3, $0, 0xF000
    sll     $3, $3, 16
    and     $3, $1, $3
    srl     $3, $3, 28
    or      $2, $2, $3

 
##end of File



