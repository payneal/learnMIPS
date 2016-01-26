            .text
            .globl main

main:

    #1.) 

        # Write a program that repeatedly asks the user for a string and then calculates and 
        # prints out the string length. Stop the program when the string is empty (when the user 
        # hits "enter" without anything else on the line.)

        # Be sure to reserve enough memory in the .data for the string. Use indexed addressing to 
        # scan through the string. Strings read in with the trap handler service include a '\n' 
        # character at the end, followed by the null termination. Don't count the '\n' or the 
        # null as part of the string length.

    ## SET CONSTANTS
        #la        $s3, 0xa                 # end string on unix
      
    ## LOOP
    #loop:
        ## ASK FOR A STRING 
        #li         $v0, 4                   # code 4 == print string
        #la         $a0, prompt1             # "enter a string?"
        #syscall

        ## HOLD THE STRING 
        #la         $a0, input               # hold the input here
        #li         $v0, 8                   # code 8 == collect string
        #syscall
                
        ## IF THE STRING IS EMPTY END PROGRAM
        #la         $t0, empty
        #la         $t1, input
        #beq        $t0, $t1, end                 
        #nop 

        # stuff needed for the loop
        #li         $t0, 0                   # set the index 

        ## LOOPING STRING
    #stringloop: 
        #lb         $v0, input($t0)          # load the bit of the string       
        #nop
        #beq        $v0, $zero, done
        #nop
        #addiu      $t0, $t0, 1
        #j          stringloop
                     
        #END LOOPING STRING
    #done:
        #addiu      $t0, $t0, -1             # subtract the \n    
        ## TELL THE USER THE LENGTH
        #li         $v0, 4                   # code 4 == print string 
        #la         $a0, prompt2             # "the length is "
        #syscall
       
        #li         $v0, 1                   # code 1 == print int
        #move       $a0, $t0                 # the length
        #syscall

    ## END THE LOOP
        #j          loop
    
    ## END OF PROGRAM
    #end: 
         #li      $v0, 10                # code 10 == exit
         #syscall
    
            #.data
#prompt1:    .asciiz        "enter a string: "
#input:      .space          200
#prompt2:    .asciiz        "\n the length of the string you entered is: "
#empty:      .asciiz        "\n"

    #2.) 
        # Write a program that asks the user for a string. After reading the string into a buffer, copy it in 
        # reversed order to a second buffer. Write out the reversed string. End the program when the first string 
        # entered is empty (when it consists only of the end of line character.)

        # The input strings will be terminated with "\n\0". Don't include these characters in the middle of the 
        # concatenated string.

        #li         $v0, 4                   # code 4 == print string
        #la         $a0, prompt1             # "enter a string?" 
        #syscall
    
        #la         $a0, input               # hold the input here
        #li         $v0, 8                   # code 8 == collect string
        #syscall

        ## stuff needed for the loop
        #li         $t0, 0                   # set the index

        ## find input length
   #stringlength:
        #lb         $v0, input($t0)          # load the bit of the string 
        #beq        $v0, $zero, foundlength 
        #nop 
        #addiu      $t0, $t0, 1
        #j          stringlength
        #nop

    #foundlength:
        #addiu      $t0, $t0, -1            # subtract the '\n'
        #li         $t1, 0                  # set indecx to 0    
           
    #backwords:
        #lb         $v0, input($t0)
        #sb         $v0, output($t1)
        #beq        $t0,$0 , end
        #nop
        #addiu      $t0, $t0, -1
        #addiu      $t1, $t1, 1
        #j          backwords

    #end: 
        #li         $v0, 4                   # code 4 == print string
        #la         $a0, prompt2             # "string backwards is " 
        #syscall

        #li         $v0, 4                   # code 1 == print int
        #la         $a0, output
        #syscall

        #li      $v0, 10                # code 10 == exit
        #syscall  
       
            #.data
#prompt1:    .asciiz         "Enter a sting to be reversed: "
#prompt2:    .asciiz         "The word backwords is: "
#input:      .space          200
#output:     .space          200 

    # 3.)
       # Write a program that repeatedly asks the user for two strings. The strings are placed in separate 
       # buffers in memory. Now, in a third buffer, create a string that is the concatenation of the two strings. 
       # Print out the new string. 
       
        ## ask/collect for string 1
        #j          askCollect
    #one:
        ## ask/collect for string 2
        #j          askCollect
    #two:
        
       ## clean string 1
       #li           $t0, 0             # loop counter 
    #loop1:
        #lb          $v0, space1($t0) 
        #beq         $v0, $0, out1

        #addiu       $t0, $t0, 1
        #j           loop1       
    #out1:
        #addiu       $t0,$t0, -1 
        #move        $t6,$0 
        #sb          $t6, space1($t0)    # erases the '\n' from space1

        ## set up loop for filling string3 
        #li          $t1, 0              # string 3 index
        #li          $t0, 0              # string1 index ==0 

    #fill1: 
        #lb         $v0, space1($t0) 
        #beq        $v0, $0, goToFill2
        #sb         $v0, space3($t1)
        #addiu      $t1, $t1, 1
        #addiu      $t0, $t0, 1        
        #j           fill1

   #goToFill2: 
        #li          $t0, 0              # string2 index ==0 

     #fill2: 
        #lb         $v0, space2($t0) 
        #beq        $v0, $0, end
        #sb         $v0, space3($t1)
        #addiu      $t1, $t1, 1
        #addiu      $t0, $t0, 1        
        #j           fill2

    #end:
        #li          $v0, 4              # code 4 == print string
        #la          $a0, prompt3        
        #syscall

        #la          $a0, space3
        #syscall             
        
        #li      $v0, 10                 # code 10 == exit      
        #syscall
        
     #askCollect:
        ## used to print collect one vs two
        
        #beq        $s0,1 ,jump          # if s0 == 1 go to two
       
        #li          $v0, 4              # code 4 == print string
        #la          $a0, prompt1        # " ask for string 1"
        #syscall
        #la          $a0, space1
        #j           collect             # skip to collecting
    #jump:
        #li          $v0, 4              # code 4 == print string
        #la          $a0, prompt2        # " ask for string 1"
        #syscall
        #la          $a0, space2
        
        ## hold entered string
    #collect:   
        #li          $v0, 8              # code 8  == hold string 
        #syscall     
        #move        $t0, $v0            # put in temp0
 
        #beq         $s0, 1, next        # decides where we return to
        #li          $s0,1               # set s0 =  
        #j           one                 
    #next: 
        #j           two 
        
            #.data
#prompt1:    .asciiz     "enter first string: " 
#space1:     .space      200 
#prompt2:    .asciiz     "enter second string: "
#space2:     .space      200
#space3:     .space     400
#prompt3:    .asciiz     "Your combined sting is: "


    # 4.) 
        
        # Write a program that writes the following pattern to the simulated terminal:
        
        #     *
        #    ***
        #   *****
        #  *******
        # ********* 
        
        # The last row starts in column one. Use a counting loop to print the five lines. The body of the counting
        # loop contains two other loops which, in sequence, fill the line buffer with the right number of spaces 
        # and stars for the current line.
        
        #li      $s0, 5          # save middle point
        #li      $s1, 0x2A       # save star char here 

        #li      $v0, 4          # code 4 == print string
        #la      $a0, star       
        #syscall                 # "print star"
        #la      $a0, newL
        #syscall        

        ## set up loop stuff
        #li      $t0, 1          # count = 0 
        #li      $t1, 5          # stop = 4
        
    #loop: 
        #beq     $t0, $t1, end
        #addu    $t2, $t1, $t0
        #subu    $t3, $t1, $t0      
        #sb      $s1, star($t2)
        #sb      $s1, star($s0)
        #sb      $s1, star($t3)
        #li      $v0, 4          # code 4 == print string 
        #la      $a0, star         
        #syscall
        #la      $a0, newL
        #syscall
        #addiu   $t0, $t0, 1
        #j       loop    

        # end program
    #end:
        #li      $v0, 10                 # code 10 == exit
        #syscall 
                
            #.data
#star:       .asciiz     "     *    "
#newL:       .asciiz     "\n"

    #5.)

        # Compute the dot product of two vectors. A vector is an array of integers. Both vectors are the same length
        #. Ask the user for the length of the vectors. Then prompt for and read in the value of each element of each 
        # vector. Reserve space in memory for vectors of up to 10 elements, but allow vectors of any size one through 10.
     
        # The dot product of two vectors is the sum of the product of 
        # the corresponding elements. For example, (1, 2, 3) dot (4, 5, 6) is 1*4 + 2*5 + 3*6.

        #After computing it, write out the dot product to the monitor.
        
        ## constanst        
    
        li      $s1, 11         # hold 11

        li      $v0, 4          # code 4 == print string
        la      $a0, prompt   
        syscall                 #'how many?'
        
        li      $v0, 5          # code 1 == read int
        syscall 
    
        sw      $v0, length     # save new value of length 
        
        bleu    $v0, $0, error
        bgeu    $v0, $s1, error
        
       # get to the math
       li       $t0, 0         # count == 0
       move     $t1, $v0       # loop size in $t1
    loop: 
        beq     $t0, 
        
# here

        j       loop  


       end:
        li      $v0, 10                 # code 10 == exit 
        syscall

       error:
        li      $v0, 4          # code 4 == print string
        la      $a0, errMg
        syscall   
          .data
errMg:    .asciiz     "Error, must be between 1-10"
prompt:   .asciiz     "how many ints do you have in your vectors? " 
length:   .word  0
vectorA:  .space 40   # space for 10 integers
vectorB:  .space 40   # space for 10 integers

## End of program
