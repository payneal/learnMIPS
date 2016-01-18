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
        ori     $15, $0, 0                    # count = 0
        lui     $9, 0x1000                    # point to the first char
        
    loop:
        lbu     $10, 0($9)                  # get the char in $10 
        sll     $0, $0, 0                       # branch delay
        
        beq     $10, $0, done               # exit char == null
        sll     $0, $0, 0                   # branch delay
        
        # CHECK EACH CHAR IN STRING 
        
        # make sure char is lower case
            #is lower than a
        slti    $23, $10, 0x60              # if char is less than a set $23 to 1 
        bne     $23, $0, noUpper        
        sll     $0, $0, 0                       # branch delay
        #yes
            #is higher than = z
        slti    $23, $10, 0x7B               # if char is not less than 7B skip to no upper     
        beq     $23, $0 noUpper 
        sll     $0, $0, 0                       #branch delay
        
        #should get here if it is not a space and not null
        addiu   $15, $15, 1                  # count ++         
        ori     $17, $0, 1                  # make $17 = 1
        
       # if first letter aka $15 != $17 skip
       bne      $15, $17, pastFirstLetter       
       sll      $0, $0, 0                      # branch delay  
       
       # cap first letter
       ori     $17, $0, 0x20               # put 0x20 aka space in 17 
       sub     $10, $10, $17               # make first letter cap 
       #store this change
       sb      $10, 0($9)
       j       noUpper
       sll     $0, $0, 0                        # branch delay

   pastFirstLetter:
        # see if prev position was space
        ori     $17, $0, 1                  # make $17 = 1
        subu    $9, $9, $17                 # subtract 1 from 
        
        lbu     $10, 0($9)                  # load char to see if its 0x20 space
        sll     $0, $0, 0
        addiu   $9, $9, 1                   # restore $9's place
        ori     $17, $0, 0x20               # put 0x20 aka space in 17 
        
        bne     $10, $17, noUpper           # is $10 == 0x20
        sll     $0, $0, 0                       # branch delay
        
        #there is a space before so lets cap this letter
    #    addiu   $9, $9, 1                  # move back to letter
        lbu     $10, 0($9)                 # load char  
        
        sub     $10, $10, $17              # cap word

        # store the answer
        sb      $10, 0($9)                  # saved changed value
        sll     $0, $0, 0                       # branch delay
         
    noUpper:
 
        # move to next char
        addiu   $9, $9, 1                   # move to next character
        j       loop                        # do loop again
        sll     $0, $0, 0                       # branch delay

     done: 
        sll     $0, $0, 0                   # nothing step

        .data
string: .asciiz    "in a  hole in the   ground there lived a hobbit"
    
    

    ## Question #3
    

    ## Question #4


    ## Question #5

    
    ## Question #6
 

    ## Question #7

    

## End of program
