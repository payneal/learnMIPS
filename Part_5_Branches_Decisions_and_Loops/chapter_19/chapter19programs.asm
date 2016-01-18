                .data               ## in case I need to use stored varibles

number1:         .word       6       ## this is perfect
isPerfect1:      .word       0
number2:         .word       12      ## this is not
isPerfect2:      .word       0
number3:         .word       28      ## this is perfect
isPerfect3:      .word       0

        .text
        .globl main

main: 

    ## Question #1 - Sequential Memory Locations
    
        # Write a program that stores the number 0 in the first four bytes of the .data section, then stores the number 1 in the next four bytes, then stores the number 2 in the four bytes after that and so on. Do this for numbers 0 through 24.
        
        lui     $1, 0x1000          # put place in memory in $1
        ori     $2, $0, 0           # starting number
        ori     $3, $0, 0           # memory jump 
        ori     $4, $0, 25          # set loop stop
        
addToMem :
        sw      $2, 0($1)
        sll     $0, $0, 0 
        sll     $0, $0, 0 

        #this is not needed I just wanted to verifiy info stored in memory
        lw      $23, 0($1)
        sll     $0, $0, 0 
        sll     $0, $0, 0 
        # end 
        
        #loop stuff
        addiu   $2, $2, 1        # add one to starting number
        addiu   $3, $3, 4        # add to memory jump 
        
        addu    $1,$1,$3         # move to next word in memory 
        
        #see if we should continue loop
    
        bne     $2,$4, addToMem  #loop again is $2 != 25
        sll     $0,$0,0          #bs step
        sll     $0,$0,0          #bs step

    ## Question #2 - Perfect Number Verifier

        ## A perfect number is an integer whose integer divisors sum up to the number. 
        ##For example, 6 is perfect because 6 is divided by 1, 2, and 3 and 6 = 1 + 2 + 3. Other perfect numbers are 28 and 496.

        ##Write a program that determines if an integer stored in memory is a perfect number. 
        ## Set a location in memory to 1 if the number is perfect, to 0 if not.

        lui     $1, 0x1000          # put place 
        ori     $2, $0, 0           # set big loop
        ori     $24,$0, 3           # big loop stop
        ori    $23, $0, 1           # have varible with one in it 
     
isPerfect : 
        lw      $3, 0($1)           # load the word from memory
        ori     $4, $0, 0           # loop counter
        ori     $5, $0, 0           # total sum of remainer free values
        subu    $26,$3, $23         # inner loop stopper # - 1 
loopit :
        # loop through number
        addiu   $4, $4, 1           # add one to loop counter
        div     $3, $4              # #/counter
        mflo    $6                  # set quotient to $6
        mfhi    $7                  # set remainder to $7
        
        bne     $7, $0, skipAdd     # if #/loop has remainder jump
        sll     $0, $0, 0           
        sll     $0, $0, 0
        addu    $5, $5, $4          # add number tpp total sum

skipAdd : 
        bne     $4, $26, loopit      # do loop it untill number == counter 
        sll     $0, $0, 0               # bs step
        sll     $0, $0, 0               # bs step

        # check to see if total == number
        addiu  $1, $1, 4            #move to next place in memory 
        bne    $5, $3, notPerfect   #  check is perfect number
        sll    $0, $0, 0                #bs step
        sll    $0, $0, 0                #bs step
        
        #place 1 if number is perfect
        sw     $23, 0($1)           # store 1 for perfect        
        sll    $0, $0, 0                # bs
        sll    $0, $0,0                 # bs
                
notPerfect:
        addiu  $1, $1, 4            #move to next place in memory to grap #
        addiu  $2, $2, 1            # add one to loop stop
        bne    $2, $24, isPerfect   # do it for 3 numbers in memory
        sll    $0, $0, 0                # bs step
        sll    $0, $0, 0                # bs step

        # load to see if they are correct
        lui     $1, 0x1000 
        lw      $10, 4($1)
        lw      $11, 12($1)
        lw      $12, 20($1)
        sll     $0, $0, 0 
        sll     $0, $0, 0 

    ## Question #3 - Perfect Number Verifier 
        #Write a program that searches for perfect numbers. It has an outer loop that counts upward from two to some limit. Each number is tested (as above) to see if it is a perfect number. If it is a perfect number it is stored at a memory location. Store perfect numbers at successive full-word memory locations. Look at exercise 1 for a way to do this

        
        lui     $1, 0x1000          # load memory space
        ori     $2, $0, 2           # outter loop counts upwards from 2
        ori     $10, $0, 11         # set stopping number
        ori     $7, $0, 1           #something to equal one
isPerfect: 
        ori     $4, $0, 0           # loop counter
        ori     $5, $0, 0           # total sum of remainer free values
        subu    $6,$2, $7           # inner loop stopper # - 1

loopit: 
        ## loop through the number
        addu    $4, $4, $7          # add one to the loop counter
        div     $2, $4              # #/counter
        mflo    $8                  # set quotient to $8
        mfhi    $9                  # set quotient to $9
        
        bne     $9, $0, skipAdd     # if #/loop has remainder jump
        sll     $0, $0, 0               # bs
        sll     $0, $0, 0               # bs
        addu    $5, $5, $4          # add number to total sum
        
skipAdd: 
        bne     $4, $6, loopit      #do loopit untill # == counter
        sll     $0, $0, 0               # bs
        sll     $0, $0, 0               # bs
        
        #check to see if total == number
        bne     $5, $2, notPerfect  # check is a perfect number
        sll     $0, $0, 0               #bs step \
        sll     $0, $0, 0               #bs step
        
        ## place the number in memory
        sw      $2, 0($1)           # save perfect tp memory 
        addiu   $1, $1, 4           # move to next saving location
        sll     $0, $0, 0               # bs step

notPerfect: 
        addiu   $2, $2, 1          # add one to loop
        bne     $2, $10, isPerfect  #if != 11 then do again
        sll     $0, $0, 0               # bs 
        sll     $0, $0, 0               # bs 
    
        lui     $1, 0x1000          # load mem spot
        lw      $10, 0($1)          # should put 6 in 10 
        sll     $0, $0, 0           
        sll     $0, $0, 0               #bs st


## End of the file
