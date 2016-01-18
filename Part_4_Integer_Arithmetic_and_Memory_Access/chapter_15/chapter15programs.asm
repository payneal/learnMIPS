   
            .data
    x:      .word           1      # x = decimal 1
    y:      .word           0      # y = decimal 0
    poly:   .word           0      # holder of poly
    a:      .word          -3      # a = decimal -3
    b:      .word           3      # b = decimal 3
    c:      .word           9      # c = decimal 9
    d:      .word         -24      # d = decimal -24

            .text
            .globl main

main: 
    #$4,$5,$6, and $29 already have values
 
    #1  (didnt do optional)
        #instructions: evaluate 3x^2 +5x - 12

            lui         $10, 0x1000         # Init base register

            #above sets $10 to 268435456 mem location???

            lw          $11,0($10)          # Load x into 11
            
            ori         $3, $0, 3           # put 3 in $3 
            ori         $7, $0, 5           # put 5 in $5  

            mult        $11, $11            # x^2 is first 
            mflo        $2                  # grab the value and
                                            # put it in $2 

            mult        $2, $3              # multiple x^2 by 3
            mflo        $2                  # put 3x^2 in reg $2
            
            mult        $7, $11             # multiply 5*x
            mflo        $3                  # put answer in $3 

            addiu       $3, $3, -12         # 5x-12  
            addu        $1, $2, $3          # 3x^2 + 5x -12 = $1 
            
            sw          $1, 8($10)          # store poly value 
           
    #----------------------------
       # clear it
            ori $1, $0, 0 
            ori $2, $0, 0 
            ori $3, $0, 0
            ori $7, $0, 0
            
    #---------------------------
    
    #2
        #evaluate 17xy - 12x -6y +12 i

        # used - write the program following the hardware 
            # rule that two or more instructions must follow
            # a mflo instruction before another mult instruction
        
        # base reg already has been init and x loaded to $11
        
        lw              $12, 4($10)         # load y into 12
        ori             $1, $0, 17          # put 17 in $1
        ori             $2, $0, 12          # put 12 in $2
         
        mult            $2, $11             # 12 * x 
        mflo            $7                  # $7= 12X
        
        ori             $3, $0, 6           # put 6 in $3
        or              $8, $0, $2          # put 12 in $8
        
        mult            $3,$12              # 6*y 
        mflo            $3                  # $3 = 6Y
        
        addu            $3, $3, $8          # $3 = 6y +12
        subu            $3, $7, $3          # $3 = 12x-6y+12
        
        mult            $11, $12            # x*y 
        mflo            $2                  # $2 = x*y

        ori             $8, $0, 0           # clear out $8
        ori             $7, $0, 0           # clear out $7

        mult            $1, $2              # 17*x*y
        mflo            $1                  # $1 = 17xy
        
        subu            $1, $1, $3          # 17xy-12x-6y+12


    #----------------------------
       #clear it

        # nothing to clear be aware x=$11, y=$12
    #----------------------------
    
    #3
        # evaluate the polynomial: 6x^3 - 3x^2 +7x +2
        # use $7 as a accumulator
    
        ori             $7, $0, 6            #put the coefficient of the first term into the accumulator
        mult            $7, $11             # multiply that value by x
        mflo            $7                  # put answer in $7
        ori             $1, $0, 3           # put 3 in $1
        subu            $7, $7, $1          # 6x-3
        mult            $7, $11             # multiply that sum by x
        mflo            $7                  # 6x^2-3x
        ori             $1, $0, 7           # hold the 7
        addu            $7, $7, $1           # add coefficient to the next term
        mult            $7, $11             # multiply that sum by x
        mflo            $7                  #  6x^3 - 3x^2 + 7x
        addiu           $7, $7, 2           # 6x^3 - 3x^2 + 7x +2
        ori             $1, $0, 0           # clear register $1
        
        sw              $7, 8($10)          # store poly value 
                
    #----------------------------
       #clear it
        
        ori             $7, $0, 0           # clear 7
    
    #----------------------------

    #4
        # evaluate the poly: ax^3+bx^2+cx+d
        # use $7 as a accumulator: 
        
        lw              $7, 12($10)        # put a in $7
        
        #idk how else to make up 2 steps
        ori             $1, $0, 0          # bs step
        ori             $2, $0, 0          # bs step
        
        lw              $1, 16($10)        # put b in $1
                                           # b=3 

        mult            $7, $11            # a*x -> a=-3
        mflo            $7                 # $7 = a*x
        
        lw              $2,20($10)         # put c in $2 

        addu            $7, $7, $1         # $7 =ax+b
        mult            $7, $11            # (ax+b)x
        mflo            $7                 # ax^2+bx

        addu            $7,$7, $2          # ax^2+bx+c

        lw              $1,24($10)         # put d in $1
        
        mult            $7, $11            # (ax^2+bx+c)x
        mflo            $7                 # ax^3+bx^2+cx
        
        addu            $7, $7, $1         # ax^3+bx^2+cx+d
        
         
## End of File
