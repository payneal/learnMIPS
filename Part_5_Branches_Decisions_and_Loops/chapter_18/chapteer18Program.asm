        .data                       # for question 4
A:      .word               9      # A = 23
B:      .word               98      # B = 98
C:      .word               9       # C = 9 

        .text
        .globl main
main: 
    
    #ex.1 - Sum of evens, sum of odds
        #Write a program that computes three sums:

            # $10 =  1 + 2 + 3 + 4 + ... + 99 + 100

            # $9 = 1 + 3 + 5 + 7 + ... + 97 + 99

            # $8 = 2 + 4 + 6 + 8 + ... + 98 + 100

                ori          $8, $0 , 0          # this will hold  summ of even
                ori          $9, $0, 0           # this will hold sum of odd
                ori          $10, $0, 0          # this will hold sum of total
                ori          $2, $0 , 1          # loop counter
                ori         $11, $0, 101         # stop loop @ 100

       neededAdd:       
                # add loop counter to sum
                addu         $10, $10, $2        # total sum = sum + loop counter
        
                # divid the counter by 2 check its result
                ori          $3, $0, 2           # set $3 = 2
                div          $2, $3              # LOOPCOUNTER/2
                mfhi         $3                  # $3 = remainder

                # if its even then add to the summ of evens
                beq         $3 , $0, even         #if remainder = 0 add to evenSum
                sll         $0, $0, 0               # nothing
                #else  its odd so add to the odd sums 
                addu        $9, $9, $2           # oddSum += (odd)loopCounder  
                #if oddd dont want to add to even
                beq         $0, $0 odd
                sll         $0, $0, 0            # bs step
    even:    
                addu        $8, $8, $2           # evenSum += (even)loopCounter
                
    odd:
                # add to the loop counter
                addiu        $2, $2, 1          # loopCounter +1
    
                # if loopCount != 101 then go back to needAdd
                bne         $2, $11,  neededAdd     # get back to adding sums
                sll         $0, $0, 0               # bs step needed


    #ex.2  - Significant Bits

       # With an ori instruction, initialize $8 to a bit pattern that represents a positive integer. Now the program determines how many significant bits are in the pattern. The significant bits are the leftmost one bit and all bits to its right. So the bit pattern:

#0000 0000 0010 1001 1000 1101 0111 1101
#... has 22 significant bits. (To load register $8 with the above pattern, 0x00298D7D, use an ori followed by a left shift followed by another ori.)
           
                  ori       $8, $0, 0x29            # set up number
                  sll       $8, $8, 16              # move it over 
                  ori       $8, $8, 0x8D7D          # finsih number
                 
                  ori       $2, $0, 0               # loop counter = 0 
                  ori       $7, $0, 32              # $7 = 32 
                  ori       $9, $0, 1               # $9 = 1
           
    slideToRight: 
                   addu       $2, $2, $9              # add 1 to loop counter
                   subu        $7, $7, $9              # $7 -= 1 

                   srl         $3, $8, $7              # put leftmost bit start 32 
                   bne         $3, $9,  slideToRight    # move to next bit spot if bit isnt 1
                   sll         $0, $0, 0                   #bs step
                
                #  significant bit = $7 +1
                   addu        $2, $7, $9             # this is the sig bit #
                


#ex.3 - allowed Ranges
    
    # a A temperature in $8 is allowed to be within either of two ranges: 20 <= temp <= 40 and 60 <= temp <= 80. Write a program that sets a flag (register $3) to 1 if the temperature is in an allowed range and to 0 if the temperature is not in an allowed range.

#It would be helpful to draw a flowchart before you start programming.

                  ori       $2, $0 , 81             # this is the temp
                  ori       $3, $0, 0              # set allow range initially to No
                    
                  # see if temp is less than 41
                  sltiu     $7, $2, 41              # $7 (T/F) temp under 41
                  beq       $7, $0, high            # if $7 is fale see if under 80
                  sll       $0, $0, 0                   #BS DO NOTHING

                  # make sure its higher than 20
                  sltiu     $7, $2, 19              # $7 (T/F) temp under 19
                  bne       $7, $0, answer          # answer has been found
                  sll       $0, $0, 0                   #BS DO NOTHING

                  ori       $3, $0,1                # set $3 because 20 <= temp <= 40
                  beq       $0, $0 answer           # collected answer end program
                  sll       $0, $0 0                    #BS DO NOTHING 
        high: 
                  # make sure tem <= 80
                  sltiu     $7, $2, 81              # see if temp is under 81 degrees
                  beq       $7, $0, answer          # temp too high we know answer
                  sll       $0, $0, 0                   # BS step
                  
                  # make sure tem >= 60
                  sltiu     $7, $2, 59              # see if tmp is less than 59 
                  bne       $0, $0, answer          # we know answer
                  sll       $0, $0, 0                   # BS STEP
                
                  ori       $3, $0, 1               # set $3 because 60 <= temp => 80
        answer: 
                 ori        $2, $0, 0               # CLEAR OUT TEMP

#ex.4 - median of Three
    # Write a program that computes the median of three values in memory. After it has been found, store the median in memory.

     #      .data
     #A:    .word 23
     #B:    .word 98
     #C:    .word 17
    
    #  The median of three integers is greater than or equal to one integer and less than or equal to the other. With the above three integers the median is "23". Assume that the data changes from run to run. Here is some more possible data:

    #       .data
    #A:    .word 9
    #B:    .word 98
    #C:    .word 9    

    #with the new data, the median is "9"

    #program:
            lui     $10, 0x1000         # init base reg

            lw      $11, 0($10)         # load A into $11
            lw      $12, 4($10)         # load B into $12
            lw      $13, 8($10)         # load C into $13
            
            
            sll     $0, $0, 0           # bs step so that 12 is loaded
            sll     $0, $0, 0           # bs step so $13 loaded

          
            # check if a == b 
            beq          $11,$12, answerA    # we know the answer
            sll          $0, $0, 0
            
            # check  if a == c
            beq          $11, $13, answerA   # we know the answer
            sll          $0, $0, 0           #bs 

            # check if b == c
            beq          $12, $13, answerC   # we know the answer
            sll          $0, $0, 0           # bs      

            # is  a < b?
            sltu         $1,$11, $12         #is a < b
            bne          $1, $0, alessb      # true go to alessb
            sll          $0, $0, 0              #bs nothing
            # a > b
            
            #if c < a => a median
            sltu         $2, $13, $12       # is c < a? 
            bne          $2, $0, answerA    # answer is A
            sll          $0, $0, 0              #bs step
            
            #if b < c => b median
     alessb:
             #a < b
             sltu        $2, $12, $13        #is b < c
             bne         $2,$0, answerB      #if answer true answerB
             sll         $0, $0, 0              # bs step 
             # c < b 
             sltu       $2, $11, $13        # is a < c
             bne        $2, $0, answerC     # a is less than c - c median
             sll        $0, $0, 0           # nothing
            
             beq        $2, $0,  answerA     # a is median
             sll        $0, $0, 0
            
     amoreb:    
            #b < a
            sltu       $2, $11, $13          # is a < c 
            bne        $2, $0, answerA      # if answer true answerA
            sll        $0, $0, 0                #bs step
            
            # is b < c
            sltu        $2, $12, $13        #is b < c
            bne          $2, $0, answerC     # b is less than c
            sll         $0, $0, 0               #bs step 

            beq         $2, $0, answerB    # b is median
            sll         $0, $0 , 0          # bs step
                       
    answerA: 
             or      $23, $0, $11
             beq     $0,$0, done
             sll     $0, $0, 0
 
    answerB:    
             or      $23, $0, $12
             beq     $0, $0, done
             sll     $0, $0, 0
    answerC: 
             or      $23, $0, $13 
             beq     $0, $0, done
             sll     $0, $0, 0

    done:  
            # we have an answer
            sll      $0, $0, 0
            
# End of file
