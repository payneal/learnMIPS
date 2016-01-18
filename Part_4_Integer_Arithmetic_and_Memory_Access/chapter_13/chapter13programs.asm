## chapter13programs.asm

## Program to complete all exercise assigmnets of chapter 13

    .text
    .globl main

main:

    #Ex.1

    # write a program that adds up the following Int's: 
    # 456
    # -229
    # 325
    # -552

   ori      $1, $0, 456          # put +456 into reg one
   addiu    $1, $1, -229         # add -229
   addiu    $1, $1, 325          # add 325
   addiu    $1, $1, -552         # add -552

   #Ex.2

   # initialize the sum in register $8 to zero. Then add 4096_10 to $8 sixteen times.
   # You don't know how to loop, yet, so do this by making 16 copies of the same instruction.
   # The value 409610 is 0x1000.

   ori      $8, $0, 0           # put 0 in reg $8
   addiu    $8, $8, 4096        # ADD 409610 x16 times
   addiu    $8, $8, 4096 
   addiu    $8, $8, 4096
   addiu    $8, $8, 4096
   addiu    $8, $8, 4096 
   addiu    $8, $8, 4096 
   addiu    $8, $8, 4096 
   addiu    $8, $8, 4096 
   addiu    $8, $8, 4096 
   addiu    $8, $8, 4096 
   addiu    $8, $8, 4096 
   addiu    $8, $8, 4096 
   addiu    $8, $8, 4096 
   addiu    $8, $8, 4096 
   addiu    $8, $8, 4096 
   addiu    $8, $8, 4096
       
   # Next initialize register $9 to 4096_10. Shift $9 left by the correct number of positions so that 
    #registers $8 and $9 contain the same bit pattern.

  ori       $9, $9, 4096
  sll       $9, $9,4 

  # initialize a register $10 to 4096_10. Add $10 to itself the correct number of times
    # so that it contains the same bit pattern as the other two registers.

  ori       $10, $10, 4096
  addu      $10, $10, $10
  addu      $10, $10, $10 
  addu      $10, $10, $10 
  addu      $10, $10, $10

  # clearing used regs 
  ori       $8, $0, 0
  ori       $9, $0, 0
  ori       $10, $0,0
  #------------------

  #Ex.3

  # Initialize register $9 to 0x7000. Shift the bit pattern so that $9 contains 0x70000000.
     # Now use addu to add $9 to itself. Is the result correct?

  ori       $9, $0, 0x7000
  sll       $9, $9, 4  
  addu      $9, $9, $9
  # check if correct

  #Now use the add instruction and run the program again. What happens?
  add       $10, $9, $9

  # clearning used regs
  ori       $9, $0, 0
  ori       $10, $0, 0
  #-------------------
  
#EX.4
   
# Let register $8 be x and register $9 be y. Write a program to evaluate:

    # 3x - 5y

# Leave the result in register $10. Inspect the register after running the program to check that the 
# program works. Run the program several times, initialize x and y to different values for each run.

    ori     $8, $0, 1       # I set reg 8 to 1 first so x =1

    sll     $7, $8, 1       # shift over 1  is like multiplying by 2
    addu    $7, $7, $8      # take num multiplied by 2 and add makes *3

    ori     $9, $0, 1       # I set reg 9 to 1 first so y =1 
    
    sll     $10, $9, 2      # shift over 2 is like multiplying by 4
    addu    $10, $10, $9    # take 

   subu     $1, $7, $10

    # clearing used regs
    
    ori     $1, $0, 0
    ori     $4, $0, 0
    ori     $7, $0, 0
    ori     $8, $0, 0
    ori     $9, $0, 0
    ori     $10,$0, 0 

    #------------------

# Ex. 5

#Let register $8 be x. Write a program that computes 13x. Leave the result in register $10. Initialize x to 1 for debugging. Then try some other positive values.

    ori     $8, $0, 1       # I set reg 8 to 1 first so x =1 
    sll     $10, $8, 3      # multiply x by 8 hold it in $10 
    sll     $9, $8,2        # multiply x by 4 hold it in $9
    addu    $10, $10, $8    # add value of x so $10 is x*9 
        
    # now that $9 = x*4 and $10 = x*9 we add
    addu   $10, $9, $10      # should be 13 when using 1 becauuse *13


#Extend your program so that it also computes -13x and leaves the result in register $11 (This will take one additional instruction.) Now initialize x to -1. Look at your result for 13x. Is it correct?

    nor   $11, $10, $10
    addiu  $11, $11, 1




## End of file
