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
        la        $s3, 0xa                 # end string on unix
      
    ## LOOP
    loop:
        ## ASK FOR A STRING 
        li         $v0, 4                   # code 4 == print string
        la         $a0, prompt1             # "enter a string?"
        syscall

        ## HOLD THE STRING 
        la         $a0, input               # hold the input here
        li         $v0, 8                   # code 8 == collect string
        syscall
                
        ## IF THE STRING IS EMPTY END PROGRAM
        la         $t0, empty
        la         $t1, input
        beq        $t0, $t1, end                 
        nop 

        # stuff needed for the loop
        li         $t0, 0                   # set the index 

        ## LOOPING STRING
    stringloop: 
        lb         $v0, input($t0)          # load the bit of the string       
        nop
        beq        $v0, $zero, done
        nop
        addiu      $t0, $t0, 1
        j          stringloop
                     
        #END LOOPING STRING
    done:
        addiu      $t0, $t0, -1             # subtract the \n    
        ## TELL THE USER THE LENGTH
        li         $v0, 4                   # code 4 == print string 
        la         $a0, prompt2             # "the length is "
        syscall
       
        li         $v0, 1                   # code 1 == print int
        move       $a0, $t0                 # the length
        syscall

    ## END THE LOOP
        j          loop
    
    ## END OF PROGRAM
    end: 
         li      $v0, 10                # code 10 == exit
         syscall
    
            .data
prompt1:    .asciiz        "enter a string: "
input:      .space          200
prompt2:    .asciiz        "\n the length of the string you entered is: "
empty:      .asciiz        "\n"

    #2.) 
        # Write a program that asks the user for a string. After reading the string into a buffer, copy it in 
        # reversed order to a second buffer. Write out the reversed string. End the program when the first string 
        # entered is empty (when it consists only of the end of line character.)

        # The input strings will be terminated with "\n\0". Don't include these characters in the middle of the 
        # concatenated string.

        li         $v0, 4                   # code 4 == print string
        la         $a0, prompt1             # "enter a string?" 
        syscall
    
        la         $a0, input               # hold the input here
        li         $v0, 8                   # code 8 == collect string
        syscall

        ## stuff needed for the loop
        li         $t0, 0                   # set the index

        ## find input length
   stringlength:
        lb         $v0, input($t0)          # load the bit of the string 
        beq        $v0, $zero, foundlength 
        nop 
        addiu      $t0, $t0, 1
        j          stringlength
        nop

    foundlength:
        addiu      $t0, $t0, -1            # subtract the '\n'
        li         $t1, 0                  # set indecx to 0    
           
    backwords:
        lb         $v0, input($t0)
        sb         $v0, output($t1)
        beq        $t0,$0 , end
        nop
        addiu      $t0, $t0, -1
        addiu      $t1, $t1, 1
        j          backwords

    end: 
        li         $v0, 4                   # code 4 == print string
        la         $a0, prompt2             # "string backwards is " 
        syscall

        li         $v0, 4                   # code 1 == print int
        la         $a0, output
        syscall

        li      $v0, 10                # code 10 == exit
        syscall  
       
            .data
prompt1:    .asciiz         "Enter a sting to be reversed: "
prompt2:    .asciiz         "The word backwords is: "
input:      .space          200
output:     .space          200 

    # 3.)
       # Write a program that repeatedly asks the user for two strings. The strings are placed in separate 
       # buffers in memory. Now, in a third buffer, create a string that is the concatenation of the two strings. 
       # Print out the new string. 
       
        ## ask/collect for string 1
        j          askCollect
    one:
        ## ask/collect for string 2
        j          askCollect
    two:
        
       ## clean string 1
       li           $t0, 0             # loop counter 
    loop1:
        lb          $v0, space1($t0) 
        beq         $v0, $0, out1

        addiu       $t0, $t0, 1
        j           loop1       
    out1:
        addiu       $t0,$t0, -1 
        move        $t6,$0 
        sb          $t6, space1($t0)    # erases the '\n' from space1

        ## set up loop for filling string3 
        li          $t1, 0              # string 3 index
        li          $t0, 0              # string1 index ==0 

    fill1: 
        lb         $v0, space1($t0) 
        beq        $v0, $0, goToFill2
        sb         $v0, space3($t1)
        addiu      $t1, $t1, 1
        addiu      $t0, $t0, 1        
        j           fill1

   goToFill2: 
        li          $t0, 0              # string2 index ==0 

     fill2: 
        lb         $v0, space2($t0) 
        beq        $v0, $0, end
        sb         $v0, space3($t1)
        addiu      $t1, $t1, 1
        addiu      $t0, $t0, 1        
        j           fill2

    end:
        li          $v0, 4              # code 4 == print string
        la          $a0, prompt3        
        syscall

        la          $a0, space3
        syscall             
        
        li      $v0, 10                 # code 10 == exit      
        syscall
        
     askCollect:
        ## used to print collect one vs two
        
        beq        $s0,1 ,jump          # if s0 == 1 go to two
       
        li          $v0, 4              # code 4 == print string
        la          $a0, prompt1        # " ask for string 1"
        syscall
        la          $a0, space1
        j           collect             # skip to collecting
    jump:
        li          $v0, 4              # code 4 == print string
        la          $a0, prompt2        # " ask for string 1"
        syscall
        la          $a0, space2
        
        ## hold entered string
    collect:   
        li          $v0, 8              # code 8  == hold string 
        syscall     
        move        $t0, $v0            # put in temp0
 
        beq         $s0, 1, next        # decides where we return to
        li          $s0,1               # set s0 =  
        j           one                 
    next: 
        j           two 
        
            .data
prompt1:    .asciiz     "enter first string: " 
space1:     .space      200 
prompt2:    .asciiz     "enter second string: "
space2:     .space      200
space3:     .space     400
prompt3:    .asciiz     "Your combined sting is: "


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
        
        li      $s0, 5          # save middle point
        li      $s1, 0x2A       # save star char here 

        li      $v0, 4          # code 4 == print string
        la      $a0, star       
        syscall                 # "print star"
        la      $a0, newL
        syscall        

        ## set up loop stuff
        li      $t0, 1          # count = 0 
        li      $t1, 5          # stop = 4
        
    loop: 
        beq     $t0, $t1, end
        addu    $t2, $t1, $t0
        subu    $t3, $t1, $t0      
        sb      $s1, star($t2)
        sb      $s1, star($s0)
        sb      $s1, star($t3)
        li      $v0, 4          # code 4 == print string 
        la      $a0, star         
        syscall
        la      $a0, newL
        syscall
        addiu   $t0, $t0, 1
        j       loop    

        ## end program
    end:
        li      $v0, 10                 # code 10 == exit
        syscall 
                
            .data
star:       .asciiz     "     *    "
newL:       .asciiz     "\n"

    #5.)

        # Compute the dot product of two vectors. A vector is an array of integers. Both vectors are the same length
        #. Ask the user for the length of the vectors. Then prompt for and read in the value of each element of each 
        # vector. Reserve space in memory for vectors of up to 10 elements, but allow vectors of any size one through 10.
     
        # The dot product of two vectors is the sum of the product of 
        # the corresponding elements. For example, (1, 2, 3) dot (4, 5, 6) is 1*4 + 2*5 + 3*6.

        #After computing it, write out the dot product to the monitor.
        
        ## constant
        li     $s1, 11              # hold 11
        li     $s0, 4               # hold 4

        ## ask for string
        li      $v0, 4              # code 4 == print string
        la      $a0, prompt   
        syscall                     #'how many?'
        
        ## read in input
        li      $v0, 5              # code 1 == read int
        syscall 
        
        ## hold the length
        sw      $v0, length         # save new value of length 

        bleu    $v0, $0, error      # if less than or == 0 -> error
        bgeu    $v0, $s1, error     # if greater than or == 11 -> error
       
        ## stuff for loop
        li      $t0, 0              # count == 0
        move    $t1, $v0            # loop size
        
        ## GET ARRAY 1
    getNums1:
        beq     $t0, $t1, gotNums1   # stop inputing when got nums
        li      $v0, 4               # code == print string
        la      $a0, array1
        syscall
        
        li      $v0, 5               # code 1 == read int
        syscall

        mul     $t5, $s0, $t0        # 4 times count
        sw      $v0, vectorA($t5)    # save input in vector1
         
        addiu   $t0, $t0, 1          # count++ 
        j       getNums1
    
        ## STUFF FOR LOOP
    gotNums1:
        li     $t0, 0
        
        ## GET ARRAY 2
    getNums2:
        beq     $t0, $t1, gotNums2  # stop inputing when got nums
        li      $v0, 4              # code == print string
        la      $a0, array2
        syscall
        
        li      $v0, 5
        syscall
        
        mul     $t5, $s0, $t0
        sw      $v0, vectorB($t5)   

        addiu   $t0, $t0, 1         #count++ 
        j       getNums2
    
    gotNums2:
        ## get to the math
        li      $t0, 0              # count == 0
        move    $t1, $v0            # loop size in $t1
        li      $t6, 0              # hold the total

    loop:
        beq     $t0, $t1, next      # get out loop 
        ## grab one form array1
        mul     $t2, $t0, $s0       # get the arry word position to pull
        lw      $t3, vectorA($t2)    # put array[x] in $t3
        ## grab one form array2
        lw      $t4, vectorB($t2)    # put array[x] in $t4
        mul     $t5, $t3, $t4       # array1[x] * array2[x]
        addu    $t6, $t6, $t5       # add to total
        addu    $t0, $t0, 1
        j       loop                # do again

    next:    
        ## print the answer
        li      $v0, 4              # code 4 == print string
        la      $a0, dot            # "the dot product is "
        syscall

        li      $v0, 1              # code 1 == print int
        move    $a0, $t6            
        syscall                     # print answer

       end:
        li      $v0, 10                 # code 10 == exit 
        syscall

       error:
        li      $v0, 4          # code 4 == print string
        la      $a0, errMg
        syscall        

          .data
array1:   .asciiz     "enter numbers for array1\n"
array2:   .asciiz     "enter numbers for array2\n"
enter:    .asciiz     "enter number: "
errMg:    .asciiz     "Error, must be between 1-10"
prompt:   .asciiz     "how many ints do you have in your vectors? " 
dot:      .asciiz     "the dot product is: "
length:   .word  0
vectorA:  .space 40   # space for 10 integers
vectorB:  .space 40   # space for 10 integers

     #6.) 
     
        # Declare an array of integers: 

        # Write a program that repeatedly asks the user for an integer to search for. After the user enters the integer, the program scans through the array element by element looking for the integer. When it finds a match it writes a message and reports the index where the integer was found. If the integer is not in the array it writes a failure message.
        
        li      $v0, 4          # 4 == print string
        la      $a0, what       # "what you looking for"
        syscall
    
        li      $v0, 5          # 5 == read int
        syscall
        
        move    $s0, $v0        # hold  the input in $s0

        ## grab the length of array
        lw      $s1, size
        
        ## loop stuff 
        li      $t0, 0           # count = 0
        
        ## start loop
   loop:
        mul     $t1, $t0, 4      # this is to get array posittion 
        lw      $t2, array($t1)
        beq     $t0, $s1, nope
        beq     $t2, $s0, found
        addiu   $t0, $t0, 1
        j       loop

    nope:       
         li      $v0, 4          # 4 == print string 
         la      $a0, no       # "not in array"
         syscall 

     end:
        li      $v0, 10          # code 10 == exit
        syscall
    
    found:
        li      $v0, 4          # 4 == print string
        la      $a0, yes       # "what you looking for" 
        syscall
    
        li      $v0, 1          # 5 == print int
        move    $a0, $t0
        syscall
        j       end

          .data
no:        .asciiz   "the number was not found"
yes:       .asciiz   "we have found a match at index " 
size:     .word     12
array:    .word     50, 12, 52, -78, 03, 12, 99, 32, 53, 77, 47, 00
what:     .asciiz   "what int are you looking for? "

        #7.) 
        # Write a program that processes an array by applying an averaging filter to it. An averaging filter works like this: 
        #create a new array where each element at index J is the average of the three elements from the old array at indexes J-1, J, and J+1

        
        ## grab the length of the array
        lw      $s0, size

        ## setup outter loop
        li      $t0, 0              # count
        ## loop fo the length
    loop:
        beq     $t0, $s0, done      # loops over when count == length
        mul     $t3, $t0, 4         # this is to index array
        lw      $t4, array($t3)     # hold array[x]
                    
        ## want average of j-1, j, j+1
        li      $t2, 0              # total
        li      $t6, 0              # numbers for division
        addu    $t2, $t2, $t4       # add j
        addiu   $t6, $t6, 1         # div by +1
        addiu   $t5, $t0, -1        
        bltz    $t5,noFirst    # if one first array element skip j-1 
            
        mul     $t7, $t5, 4         # get j-1 index amount
        lw      $t4, array($t7)     # get j-1 
        addu    $t2, $t2, $t4       # total =+ array[j-1]
        addiu   $t6, $t6, 1         # div by +1        
    
    noFirst:
        addiu   $t5, $t0, 1         # get index of j+1
        
        bgeu    $t5, $s0, noLast
        mul     $t7, $t5, 4         # get index amount
        lw      $t4, array($t7)     # get j+1
        addu    $t2, $t2, $t4       # total =+ array[j+1]
        addiu   $t6, $t6, 1         # div by +1

     noLast:
        ## div to get the average
        div     $t2, $t2, $t6       # total / #'s added
        
        ## store answer in result array 
        sw      $t2, result($t3)     # put average in result[count] 
        
        addiu   $t0, $t0, 1        
        j       loop
    done:     

        ## print the old array
        li          $v0, 4              # code 4 == print string
        la          $a0, oldArray  
        syscall 
        
        ## set up loop
        li          $t0, 0              # count == 0
        
        ## the printing loop
   print1:
        beq         $t0, $s0, printNew
        mul         $t1, $t0, 4         # get # to acces array index
        lw          $t2, array($t1)    # put element in $t2

        li          $v0, 1              # code 1 == print int
        move        $a0, $t2            # '#' 
        syscall
    
        li          $v0, 4              # code 4 == print string
        la          $a0, space          # ' '
        syscall
        
        addiu       $t0, $t0, 1
        j           print1

    printNew:
        ## print the new array
        li          $v0, 4              # code 4 == print string
        la          $a0, newArray
        syscall 

        ## set up loop 
        li          $t0, 0              # count == 0
    
   print2:
        beq         $t0, $s0, end
        mul         $t1, $t0, 4         # get # to access array index
        lw          $t2, result($t1)    # put element in $t2
        
        li          $v0, 1              # code 1 == print int
        move        $a0, $t2            # '#'
        syscall

        li          $v0, 4              # code 4 == print string
        la          $a0, space          # ' '
        syscall
        addiu       $t0, $t0, 1
        j           print2

       ## end it
    end:
        li          $v0, 10             # code 10 == exit
        syscall                         # halt the program

           .data
size:     .word 12
array:    .word 50, 53, 52, 49, 48, 51, 99, 45, 53, 47, 47, 50
result:   .word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
oldArray: .asciiz   "The old array: "
newArray: .asciiz   "\nThe new array: "
space:    .asciiz   " "

    # 8.)
    
        # Perform selection sort on an array in memory:        
        
        #The selection sort algorithm looks like this:

        #int out, in, min, temp;

        #// each time the outer loop is
        #// executed, replace the element
        #// at out with the minimum of the
        #// elements to its right.
        #for ( out=0; out<size-1; out++ )
        #{
        #  min = out;
 
        #  // find the location of the minimum
        #  // in the remaining elements 
        #  for ( in=out+1; in<size; in++ )
        #    if ( array[in] < array[min] )
        #      min = in;
 
        #  // swap the element at out with
        #  // the minimun of the remaining elements     
        #  temp       = array[out];
        #  array[out] = array[min];
        #  array[min] = temp;  
        #}
        

        ## grab the  array length       
        lw      $s0, size                 
        
        ## not suppose to use s like this but it will make it easier
        li      $t2, 0                  #in 
        li      $t3, 0                  #min
        li      $t4, 0                  #temp 
    
        ## set up loop
        li      $t0, 0                  # $t1 = count == 0 aka out

        ## stat loop the size of the length
    length: 
        beq     $s0, $t0, end           # if count == length get out
            ##min = out;
            move    $t3, $t0
    
            ##inner loop
            addiu   $t1, $t0, 1         # in=out+1 aka inner loop 
            ##---------------------------------------------------------
            lengthAgain: 
            beq       $s0, $t1, outInner          # if innerloop count == length
            
            ## get two array indexs
            mul     $t5, $t1, 4            
            lw      $t8, array($t5)     # in number
            
            mul     $t5, $t3, 4 
            lw      $t9, array($t5)     # min number
            
            bgt     $t8, $t9, skip
            move    $t3, $t1            
          skip:                     
            
            addiu   $t1, $t1, 1         # add innerloop count++ 
            j       lengthAgain
            ##--------------------------------------------------------
        outInner:       
 
       ## swap the element at out with
       ## the minimun of the remaining elements
        
        ## temp = array[out];    
        mul       $t5,$t0,4
        lw        $t4, array($t5)
        ## array[out] = array[min];        
        sw        $t9, array($t5) 
        ## array[min] = temp;
        mul       $t5,$t3,4
        sw        $t4, array($t5)

        addiu     $t0, $t0, 1
        j         length 

    end:
        # print out the array
        li          $v0, 4              # code 4 == print string
        la          $a0, here
        syscall

        ## loop stuff
        li          $t0, 0              # count = 0
   
     lastloop: 
        beq     $t0, $s0, realEnd 
        mul     $t1, $t0, 4      # this is to get array posittion
        lw      $t2, array($t1) 
        
        li      $v0, 1          # 1 == print in
        move    $a0, $t2
        syscall
        
        li      $v0, 4
        la      $a0, space
        syscall 
        
        addiu       $t0, $t0, 1         # count++
        j           lastloop 
        
  realEnd: 
        li          $v0, 10             # code 10 == exit
        syscall     

          .data
here:     .asciiz   "here is the sorted string: \n"
space:    .asciiz   " "
size:     .word 20
array:    .word 99, 23, 45, 82, 09, 34, 71, 64, 88, 42, 12, 87, 33, 36, 83, 18, 17, 04, 52, 46
## End of program
