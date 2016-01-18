## chapter14programs.asm
## 
## chapter 14 programming Exercises
##
## Register Use:

        .text
        .globl main
main:
    # Ex.1
        
        # Write a program to evaluate a polynomial, similar to newMult.asm from the chapter. 
        # Evaluate the polynomial:
    
        # 3x^2 + 5x -12
        
        # Pick a register to contain x and initialize it to an integer value (positive or negative) at the
        # beginning of the program. Assume that x is small enough so that all results remain in the lo 
        # result register. Evaluate the polynomial and leave its value in a register.
        
        # Verify that the program works by using several initial values for x.
        # Use x = 0 and x = 1 to start since this will make debugging easy.

        #------------------------------------------------------------------
        
        ori     $1, $0, 2           # I want to start with x=1
        mult    $1, $1              # x^2 is first
        mflo    $2                  # grab the value and put it in $2
        ori     $3, $0, 3           # put 3 in $3
        mult    $2, $3              # multiple x^2 by 3
        mflo    $2                  # put 3x^2 in reg $2

        ori     $3, $0, 5           # put 5 in $3
        mult    $1, $3              # multiply 5*x
        mflo    $3                  # put answer in $3
        
        addiu   $3, $3, -12         # subtract 12 from 5x
        addu    $1, $2, $3          # 3x^2 + 5x -12 = $1

        #------------------------------------------------------------------
        # clear the registers used
        ori     $1, $0, 0          
        ori     $2, $0, 0
        ori     $3, $0, 0
        ori     $4, $0, 0    
        #-----------------------------------------------------------------

    # Ex.2

        # Write a program similar to divEg.asm from the chapter to evaluate a rational function:
        
        # (3x+7)/(2x+8)

        # Verify that the program works by using several initial values for x.
        # Use x = 0 and x = 1 to start since this will make debugging easy. 
        # Try some other values, then check what happens when x = -4. 

        ori     $1, $0, 1           # put x in $1
        ori     $2, $0, 3           # put 3 in $2
        mult    $1, $2              # 3 * x
        mflo    $2                  # hold value in $2
        addiu   $2, $2, 7           # add 7 to 3x

        ori     $3, $0, 2           # put two in $3
        mult    $1, $3              # multiply x*2 
        mflo    $3                  # put answer in $3
        addiu   $3, $3, 8           # add 8 to 2x put in $3
        
        div     $2, $3              # (3x+7)/(2x+8)
        mflo    $1                  # put quotient in $1
        mfhi    $2                  # put the remainder in $2 

    #-------------------------------------------------------------------------
    # clear registers
    
        ori     $1, $0, 0
        ori     $2, $0, 0
        ori     $3, $0, 0 
                
    #-------------------------------------------------------------------------


    # Ex.3
        
        # Write a program that multiplies the contents of two registers which you have initialized using
        # an immediate operand with the ori instruction. Determine (by inspection) the number of 
        # significant bits in each of the following numbers, represented in two's complement. Use the program
        #  to form their product and then determine the number of significant bits in it.

        # operand 1         | 0x00001000    |   0X0000FF00      |  0x00008000    
        # significant Bits  |    13         |       12          |     16         
        # operand 2         | 0x00001000    |   0X00000FFF      |  0x00001000    
        # significant Bits  |    13         |       12          |     13         
        # Product           | 0x1000000     |   0xFEF0100       |  0x8000000     
        # Significant Bits  |   25          |      28           |     28         


        #operand 1
        ori     $1, $0, 0x1000      # put 0x1000 in $1
        mult    $1, $1              # multiply 0x1000 * 0x1000
        mflo    $3                  # move lo in 3 
        mfhi    $2                  # move hi in 2
       
        sll     $2, $2, 16          #move over 16 bits    
        or      $2, $3, $3          # put hi-low in same reg

        #operand 2
        ori     $4, $0, 0xFF00      # put 0xFF00 in $4
        ori     $5, $0, 0xFFF       # put 0xFFF in $5
        mult    $4, $5              # multiply FF00 * FFF 
        mflo    $5                  # move low in 5
        mfhi    $4                  # move hi in 4
       
        sll     $4, $4, 16          # move over 16 bits
        or      $4, $5, $5          # put hi-low in same reg
 
        #operand 3
        ori     $6, $0, 0x8000      # put 0x8000 in $6
        ori     $7, $0, 0x1000      # put 0x1000 in $7
        mult    $6, $7              # multiply 8000 * 1000
        mflo    $7                  # move low in 7
        mfhi    $6                  # move hi in  6
        
        sll     $6, $6, 16          # move over 16 bits
        or      $6, $7, $7          # put hi-low in same reg

        # im trying to rus to get through this but i messed up above it shows the answer 2 times re 2 - reg 7 

    #----------------------
    # clear the regs 
    
        ori    $1, $0, 0
        ori    $2, $0, 0
        ori    $3, $0, 0
        ori    $4, $0, 0
        ori    $5, $0, 0
        ori    $6, $0, 0
        ori    $7, $0, 0

    #----------------------

    # EX.4

        # Write a program that determines the value of the following expression:

        # (x*y)/z

        # Use x = 1600000 (=0x186A00), y = 80000 (=0x13880), and z = 400000 (=61A80).
        # Initialize three registers to these values. Since the immediate operand of the ori 
        # instruction is only 16 bits wide, use shift instructions to move bits into the correct 
        # locations of the registers.

        # Choose wisely the order of multiply and divide operations so that the significant bits 
        # always remain in the lo result register.

        ori     $1, $0, 0x186A      # move some of x in $1
        sll     $1, $1, 8           # move over 8 bits    

        ori     $2, $0, 0x1388      # move some of y in $2
        sll     $2, $2, 4           # move over 4 bits

        ori     $3, $0, 0x61A8      # move some of z in $3
        sll     $3, $3, 4           # move over 4 bits 

        divu    $1, $3              #  x/z         
        
        mflo    $1 
        multu   $1, $2              # multiple (x/z) *y

        mflo    $1                  # put in low in $5

## End of fill
