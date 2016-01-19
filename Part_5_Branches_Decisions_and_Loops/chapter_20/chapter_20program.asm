            .text
            .globl main 
main: 

    ## Question #1 — To Lower Case
    
    ## Write a program that converts the string to all lower case characters. Do this by adding 0x20 to each character in the string. (See Appendix F to figure out why this works.)

    ## Assume that the data consists only of upper-case alphabetical characters, with no spaces or punctuation.
            
        ## A = 0x41, a = 0x61
        ## B = 0x42 ,b = 0x62
        ## C = 0x43, c = 0x63
        ## D = 0x44, d = 0x64
        ## E = 0x45, e = 0x65
        ## F = 0x46, f = 0x66
        ## G = 0x47, d = 0x67
        
        #lui     $9, 0x1000                  # point at first char

    ## while not ch == null do
    #loop: 
        #lbu     $10 , 0($9)                 # get char to reg $10
        #sll     $0, $0, 0                   # branch delay

        #beq     $10, $0, done               # exit loop if char == null
        #sll     $0, $0, 0                   # branch delay

        #addiu   $10, $10, 0x20              # add 0x20 to make lower case
        
        #sb      $10, 0($9)                  # saved changed value
        #sll     $0, $0, 0                   # branch delay 

        #addiu   $9, $9, 1                   # point at the next char

        #j       loop                        # jump to  loop again
        #sll     $0, $0, 0                   # branch delay

    #done:
        ## string should be all lower case
        #sll     $0, $0, 0                   # branch delay
       
        
        ## prove you changed the string
        #lui     $8 , 0x1000                  # POINT AGAIN TO FIRST CHAR 
        #lbu     $9 , 0($8)                   # load into reg $9 (prove A => a 
        ## check that hex = 6# 1-7
        #sll     $0, $0, 0 
        #lbu     $9 , 4($8)                  # load reg $9 (prove D => d 
        #sll     $0, $0, 0         
        #sll     $0, $0, 0        

        #.data
#string: .asciiz "ABCDEFG"                   # word #1 is working on
    
    ## Question #2 -
    
    ## Write a program that capitalizes the first letter of each word, so that after running your program the data will look like this:

    ## "In A  Hole In The   Ground There Lived A Hobbit"

    # grap location of string   
        #lui     $9, 0x1000                    # point to the first char
        #ori     $15, $0, 0                    # count = 0  
        #sll     $0, $0, 0                       # branch delay
    
    #loop:
        #lbu     $10, 0($9)                  # get the char in $10 
        #sll     $0, $0, 0                       # branch delay
        #sll     $0, $0, 0                       # branch delay
 
        #beq     $10, $0, done               # exit char == null
        #sll     $0, $0, 0                       # branch delay
    
# CHECK EACH CHAR IN STRING 
        
        # make sure char is lower case
            #is lower than a
        #slti    $23, $10, 0x60              # if char is less than a set $23 to 1 
        #sll     $0, $0, 0
        #bne     $23, $0, noUpper        
        #sll     $0, $0, 0                       # branch delay
        #yes
            #is higher than = z
        #slti    $23, $10, 0x7B               # if char is not less than 7B skip to no upper     
        #beq     $23, $0 noUpper 
        #sll     $0, $0, 0                       #branch delay
        
        #should get here if it is not a space and not null
        #addiu   $15, $15, 1                  # count ++         
        #ori     $17, $0, 1                  # make $17 = 1
        
       # if first letter aka $15 != $17 skip
       #bne      $15, $17, pastFirstLetter       
       #sll      $0, $0, 0                      # branch delay  
       
       # cap first letter
       #ori     $17, $0, 0x20               # put 0x20 aka space in 17 
       #sub     $10, $10, $17               # make first letter cap 
       #store this change
       #sb      $10, 0($9)
       #j       noUpper
       #sll     $0, $0, 0                        # branch delay

   #pastFirstLetter:
        # see if prev position was space
        #ori     $17, $0, 1                  # make $17 = 1
        #subu    $9, $9, $17                 # subtract 1 from 
        
        #lbu     $10, 0($9)                  # load char to see if its 0x20 space
        #sll     $0, $0, 0
        #addiu   $9, $9, 1                   # restore $9's place
        #ori     $17, $0, 0x20               # put 0x20 aka space in 17 
        
        #bne     $10, $17, noUpper           # is $10 == 0x20
        #sll     $0, $0, 0                       # branch delay
        
        #there is a space before so lets cap this letter
    #    addiu   $9, $9, 1                  # move back to letter
        #lbu     $10, 0($9)                 # load char  
        #sll     $0, $0, 0                       # branch delay
        #sub     $10, $10, $17              # cap word

        # store the answer
        #sb      $10, 0($9)                  # saved changed value
        #sll     $0, $0, 0                       # branch delay
         
    #noUpper:
 
        # move to next char
        #addiu   $9, $9, 1                   # move to next character
       # j       loop                        # do loop again
       # sll     $0, $0, 0                       # branch delay

     #done: 
       # sll     $0, $0, 0                   # nothing step

       # .data
#string: .asciiz    "in a  hole in the   ground there lived a hobbit"
    
    ## Question #3
   
    # Write a progeam that removes all the spaces from the string so that the  resulting string looks like: 

    #  "IsthisadeggerwhichIseebeforeme?" 

        #lui     $9, 0x1000                    # point to the first char

    #loop:                                     # loop the whole word

        #lbu     $10, 0($9)                    # get the char in $10 
        #sll     $0, $0, 0                       # branch delay
 
        #beq     $10, $0, done                 # is char == null then done
        #sll     $0, $0, 0

        #ori     $11, $0, 0x20                 # load space into $11
        
        #bne     $10, $11, aSpace           # check that char == space aka 0x20
        #sll     $0, $0, 0                          # branch delay
       
         #if here we know char is space
        
        # keep moving through string till char is not x20 or null hold count
        #or      $15, $0, $9                    # $15 points to where we are on string
        #addiu   $15, $15, 1                     # move to the next char

    #innerL:  
        #lbu     $16, 0($15)                   # load the char
        #ori     $17, $0, 0x20                 # put space in $17
        #sll     $0, $0, 0                       # branch delay
        
        # if we find char hold it but make it a x20
        #beq     $0, $16, done                 # if char == null your done
        #sll     $0, $0, 0                       # branch delay

        #beq     $17, $16, anotherSpace        # if chat == space 
        #sll     $0, $0, 0
        

        ## here we know location of next char that != 0x20
        # hold value
        #or      $1, $0, $16                   # put the letter in $1
        # store the letter in string
        #sb      $1, 0($9)                     # move the letter
        #sll     $0, $0, 0                       #branch delay
        #sb      $17, 0($15)                   # put 
        #sll     $0, $0, 0                       # branch delay
        #j       aSpace           
        #sll     $0, $0, 0                       # branch delay

     #anotherSpace: 
        #addiu   $15, $15, 1                  # move to next char
        #j       innerL                       # do innerL again
        #sll     $0, $0, 0                       # branch delay
                    
        #so we want to move it back the count loop and store it
        # subtract 1
    #aSpace:        
        #addiu   $9, $9, 1                     # move to the next char
        #j       loop                          # do loop again
        #sll     $0, $0, 0                          # branch delay
    
    #done:
        #sll    $0, $0, 0                           # just because 
        #sb     $0, 0($9)                      # set the new null end character 
        
    #again:
        # check if the next char is a space
        #addiu  $9, $9, 1                      #move to the next char
        #lbu    $10, 0($9)                    # get the char in $10   
        #sll    $0, $0, 0                        # branch delay
        
        # if  this is space make it null
        #ori    $17, $0, 0x20                # give $17 space
        #beq    $17, $10, done 
        #sll    $0, $0, 0                        # branch delay

        # really done

    #.data
#string:   .asciiz    "Is  this a dagger    which I see before me?" 


    ## Question #4
        #Declare an array of integers, something like:

            #.data
    #size:   .word 8
    #array:  .word 23, -12, 45, -32, 52, -72, 8, 13
    # Write a program that determines the minimum and the maximum element in the array. Assume that the array has at least one element (in which case, that element will be both the minimum and maximum.) Leave the results in registers

        #lui    $9, 0x1000                   # set array pointer 
        #lw    $10, 0($9)                       # $10 = size of array
        #sll    $0, $0, 0                             #branch delay
        #addiu  $9, $9, 4                        # point to first entry in array
        #lw     $2, 0($9)                         # put the first array element in $2
        #sll    $0, $0, 0                             #branch delay
        #sll    $0, $0, 0                             #branch delay
        #sll    $0, $0, 0
      
        #or     $7, $2, $0                        # $7 sets the high
        #or     $8, $2, $0                        # $8 sets the low
        #ori    $1, $0, 1                       # $1 = loop count         

    #loop: 
        #beq    $10, $1, done                    # if loopcount == size of Array ..done
        #sll    $0, $0, 0                           # bs step
        
        #addiu  $9, $9, 4                        # move to the next word in array
        #lw     $2, 0($9)                        # put the next array element in $2
        #sll    $0, $0, 0                            # bs step

        # check if $2 is less than low
        #slt   $23, $2, $7                       # if current array word < high set $23 to one
        #sll   $0, $0, 0                             # branch delay
                
        #bne   $23, $0, notLess                  # if $23 is != 0 that go to notLess
        #sll   $0, $0, 0                             # branch delay
        
        # set the high
        #or   $7, $2, $0                         # set the high

    #notLess:
        # check if $2 is higher than high
        #slt   $24, $2, $8                       # if current < low set $24 to one
        #sll   $0, $0, 0                             # branch delay  
            
        #beq   $24, $0, notHigh                  # if $24  == 0 go to not high
        #sll   $0, $0, 0                             # branch delay

        # set the low
        #or  $8, $2, $0

    #notHigh:             
        #addiu   $1, $1, 1                           # count ++ 
        #j       loop                                # redo loop
        #sll     $0, $0, 0                           # branch delay

    #done:
        #sll    $0, $0, 0                        # bs step
        
    #        .data
    #size:   .word       8
    #array:  .word       23, -12, 45, -32, 52, -72, 8, 13

    ## Question #5

    #Declare an array of integers, something like:

        #.data
    #size:   .word 10
    #array:  .word 2, 4, 7, 12, 34, 36, 42, 8, 57, 78
    #Write a program that determines if the numbers form an increasing sequence where each integer is greater than the one to its left. If so, it sets a register to 1, otherwise it sets the register to 0.

    #Of course, write the program to work with an array of any size, including 0. Arrays of size 0 and size 1 are considered to be ascending sequences. The array can contain elements that are positive, negative, or zero. Test the program on several sets of data.
        
        #lui    $9, 0x1000                   # set array pointer  
        #lw     $10, 0($9)                   # $10 = size of array 
        #sll    $0, $0, 0                         #branch delay
        #sll    $0, $0, 0
        #ori    $8, $0, 0                    # loop count= 0 
        #addiu  $9, $9, 4                    # point to first entry in array
        #lw     $2, 0($9)                    #put first element in array in two
        #sll    $0, $0, 0                        # branch delay
        #sll    $0, $0, 0                        # branch delay
        #ori    $1, $0, 1                    # set list to assending
        
    #loop:    
        #beq    $10, $8, done                    #if $10 == $8 your done
        #sll    $0, $0, 0                        # branch delay 
        
        # load the next number 
        #addiu  $9, $9, 4                    # move to the next word
        #lw     $3, 0($9)                    # put number in $3
        #sll    $0, $0, 0                        # branch delay
        #sll    $0, $0, 0                        # branch delay
        
        #slt    $23, $2, $3                  # if $2 < $3 set $23 to 1
        #sll     $0, $0, 0                       # branch delay
        
        #bne    $0, $23, good                # things look good keep it moving
        #sll    $0, $0, 0                        # branch delay 
        
        #ori    $1, $0, 1                    # bad so change flag
        #j      done                         # over 
        #sll     $0, $0, 0                       # branch delay

   #good:
        #addiu  $8, $8, 1                        # add one to loop counter
        #or     $2, $3, $0                       
        #ori    $23, $0, 0                       # make 23 = 0
        #j      loop                             # do loop again
    #done:
        #sll    $0, $0, 0                        # branch delay
        #        .data
        #size:   .word 10
        #array:  .word 2, 4, 7, 12, 34, 36, 42, 8, 57, 78


    ## Question #6
         
        # In this program data comes in pairs, say height and weight:
        # Write a program that computes the average height and average weight. Leave the results in two registers.

        #lui     $9, 0x1000                   # set array pointer
        #lw      $10, 0($9)                   # give size varible to $10
        #ori     $1, $0, 0                    # count = 0
        #ori     $2, $0, 0                    # height = 0 
        #ori     $3, $0, 0                    # weight = 0 
  #loop:
        #beq     $1, $10, done                # is loop count == array size
        #sll     $0, $0, 0                       # branch delay
        #addiu   $9, $9, 4                    # next number
        #lw      $7, 0($9)                    # give height varible to $7 
        #sll     $0, $0, 0                       # branch delay
        #addiu   $9, $9, 4                    # next number
        #lw      $8, 0($9)                    # give weight varible to $8
        #sll     $0, $0, 0                       # branch delay
        #sll     $0, $0, 0                       # branch delay
        
        #addu    $2, $2, $7                   # add to get total height
        #addu    $3, $3, $8                   # add to get total width
        #addiu   $1, $1, 1                    # count++
        #j       loop                         # redo loop
                
  #done:
        # need to get the average
        #div     $2, $10 
        #mflo    $2
        
        #div     $3, $10
        #mflo    $3
        # average height = $2,  width = $3 

        #.data
#pairs:  .word 5                  # number of pairs
#        .word 60, 90             # first pair: height, weight
#        .word 65, 105
#        .word 72, 256
#        .word 68, 270
#        .word 62, 115

    ## Question #7
  
    #Declare an array of integers in the usual way:

            #.data
    #size :  .word 7                     # number of elements
    #        .word 1, 2, 3, 4, 5, 6, 7
    #Write a program that reverses the order of elements in the array. The result will be as if the array were declared:

            #.data
    #size :  .word 7                     # number of elements
    #       .word 7, 6, 5, 4, 3, 2, 1
    #Test that the program works on arrays of several lengths, both even and odd lengths.


        lui    $9, 0x1000                   # set array pointer 
        lw     $10, 0($9)                   # $10 = size of array
        sll    $0, $0, 0                        # branch delay
        sll    $0, $0, 0                        # branch delay
        
        ori    $1, $0, 2                    # set $1 to 2 for division
        div    $10, $2                      # div size/2
         
        mflo   $1                           
        mfhi   $2
        

       
          
        .data
size :  .word 7                     # number of elements
        .word 1, 2, 3, 4, 5, 6, 7

## End of program
