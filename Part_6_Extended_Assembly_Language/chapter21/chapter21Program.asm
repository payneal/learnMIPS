        .text
        .globl main

main: 

    # ex. 1    

    ## Evaluate the following polynomial using Horner's method:    
    ##      ax3 + bx2 + cx + d  

    ## Now the values for the coefficients a, b, c, d as well as for x come from the .data section of memory:

            lw      $s0, x          # get x
            lw      $s1, a          # get a
            lw      $s2, bb         # get bb
            lw      $s3, c          # get c
            lw      $s4, d          # get d 

            # have all needed varibles
            
            mult    $s1, $s0        # x * a           
            mflo    $t0             # answer in $0
            
            addu    $t0, $t0,$s2    # xa + b 
            nop                     # bs step to that 2 steps b4 mult
            
            mult   $t0, $s0         # (xa+b)x
            mflo   $t0              # answer = ax^2+bx
            
            addu    $t0, $t0, $s3   # ax^2+bx+c
            nop 
            
            mult   $t0, $s0         # (ax^2+bx+c)x
            mflo   $t0              # answe = ax^3 + bx^2 + cx
        
            addu   $t0, $t0, $s4    # ax^3 + bx^2 + cx + d
            
            # store the answer in memory
            sw     $t0, result
            
            .data
    x:      .word    7
    a:      .word   -3
    bb:     .word    3
    c:      .word    9
    d:      .word  -24
    result: .word    0
    
    # ex. 2
    
    ## Declare three arrays, each of the same size:

    ## Initialize a base register for each array (use the la instruction.) Now implement a loop that adds corresponding 
    ## elements in the first two arrays and stores the result in the corresponding element of the result array. Do this 
    ## by moving each of the three base registers to its next array element after each addition.
        
            la      $t0, size                 # point to size array
            lw      $t1, 0($t0)               # hold the value of size at $t1 
            li      $t8, 0                    # $t8 = count = 0
            la      $t2, array1               # point to array1
            la      $t4, array2               # point to array2
            la      $t7, result               # point to array3   
        
            #loop 
    loop: 
            beq     $t8, $t1, done            # if count == loop then done
            lw      $t3, 0($t2)               # put array1[0] in $t3
            nop
 
            lw      $t5, 0($t4)               # put array2[0] in $t4
            nop
            nop   
            addu   $t6, $t5, $t3              # array1[x] + array2[x]         
     
            sw      $t6, 0($t7)               # store answer 
        
            addiu   $t2, $t2, 4               # array1 move to next element
            addiu   $t4, $t4, 4               # array2 move to next element
            addiu   $t7, $t7, 4               # result move to next      
            addiu   $t8, $t8, 1               # count++ 
            nop                                     #bs

            j       loop                      # loop back
            nop                                    #bs
    done:                   
            nop 
            
            # check answer below
            
             li      $t8, 0                   # rest count 0
             la      $t7, result               # point to result
    loop2:
            beq     $t8, $t1, checkDone
            lw      $20, 0($t7)               # put result[x] in $t3 
            nop 
            nop
            addiu   $t8, $t8, 1               # add 1 to count
            addiu   $t7, $t7, 4
            j       loop2                     # go back to loop2
    checkDone:
            nop
            
             .data
    size:    .word       7
    array1:  .word     -30, -23, 56, -43, 72, -18, 71
    array2:  .word      45,  23, 21, -23, -82,  0, 69
    result:  .word       0,   0,  0,   0,   0,  0,  0


    # EX.3 

         ## declare two null-terminated  stringl
        
         # nitialize a base register for each string (use the la instruction.) Write a program that sets result to 1 if the two strings are equal and to 0 if the strings are not equal.

         #Two strings are equal if they are the same length and contain the same character in each location. Otherwise the strings are not equal.

         #Test your program for a variety of strings. You will have to edit the data section of your program for each pair of strings tested.

        #Extra: write the program so that it does case insensitive string comparison. Here, two strings are equal if they are the same length and 
        # have the same letter (disregarding case) in each location.
   

            la      $t0, string1                # point to string1
            la      $t1, string2                # point to string2
              
      loop: 
            lb      $t2,0($t0)                  # put char in $t2
            lb      $t3,0($t1)                  # put char in $t3
            nop
            nop
            
            beq     $zero, $t2, endOfString     # char in string1 == null go to end
            nop            
            
            beq     $zero, $t3, endOfString     # char in string2 == null go to end      
            nop
            
            bne     $t2, $t3, done               # if two chars !== go to bad
            nop     

            addiu   $t0, $t0, 1                 # move to the next char
            addiu   $t1, $t1, 1                 # move to the next char 
            j       loop                        # do loop again
            nop
      
       endOfString:
            bne    $t2, $t3, done                # see if both strings are @ end of string
            nop
            #if they are the same
            li      $t4, 1                      # set value to 1
            la      $t0, result                   # point to word
            sw      $t4, 0($t0)                 # store the 1 if they are the same
            nop 
            nop
            j       done
            nop

     done: 
            nop 

     # didnt do extra credit but it would be easy just see if letters are in asicc a-z orA-Z
    #  if char is < a and >z then lower case so add 0x20 that is the differences on chart 
    # if letters dont match at that point branch to done becayse strings arent the same

             .data
    result:  .word     0
    string1: .asciiz   "puffin"
    string2: .asciiz   "puffin"


## program over
