        .text
        .globl main

main: 

#1 

    #Write a program that asks the user for a positive integer. The program then tests if the integer is prime and writes out its result.

    #A number is prime if it cannot be divided evenly by any number other than 1 and itself. So you will need a counting loop that starts at two and divides the number for each value of the loop counter until the number is divided evenly or the limit is reached.

#   For the upper limit of the loop use the number divided by two. (A better upper limit would be the square root of the number, see below.)

    ## set up constansts 
        #li          $s0, 1                           # need to hold the value 1

    ## ask for number
        #li          $v0, 4              # code 4 == print string
        #la          $a0, prompt1        # "enter a pos int"
        #syscall
    
    ## read in number
        #li          $v0, 5              # code 5 == read int
        #syscall
    
    ## number < 1 
        #blt         $v0, $s0, error1      # less than 1 so senf to error 
        #nop
    
    ## hold entered #
        #move         $t0, $v0            # moved input number top temp0   

    ## number == 1 
       #beq          $t0, $s0, notPrime  # number == 1 so send to error 
       #nop

    ## loop that goes 2 -> number if remainder != 0 break (not prime) only go number/2
       #div          $s1, $t0, 2         # number entered / 2 put in $s1       
       #li           $t1, 2              # count == 2
    
    #loop:                               
        #bgt         $t1, $s1, prime     # if is makes it to this point number is prime
        #nop    
 
        #remu        $t2, $t0, $t1       # $t2 = remainder of - (x/2) / count
        
        #beq         $t2, $0, notPrime   # if remainder == 0 its not prime 
        #nop
        #addiu        $t1, $t1, 1
        #j           loop                # keep going entire loop
        #nop
        
    ## end of the program
   
    #end:
        #li          $v0, 10             # code 10 == exit
        #syscall                         # halt the program

   #error1: 
        #li          $v0, 4              # code 4 == print string
        #la          $a0, err1           # "must enter pos int"  
        #syscall                         

        #j           end                 # programs over
        #nop  
       
   #notPrime:      
        #li          $v0, 1              # code 1 == print int
        #move        $a0, $t0            # put entered value in position to print
        #syscall

        #li          $v0, 4              # code 4 == print string
        #la          $a0, err2           # "is not a prime number"
        #syscall

        #j           end                 # programs over
        #nop
    
    #prime: 
        #li          $v0,1              # code 1 == print int
        #move        $a0, $t0           # put eneteded value in position to print
        #syscall

        #li          $v0, 4            # code 4 === print string
        #la          $a0, itsPrime     # "its prime"
        #syscall
        #j           end               # programs over
        #nop

#            .data
#prompt1:    .asciiz  "Enter a positive integer: "
#prompt2:    .asciiz  "you entered: "
#newL:       .asciiz  "\n"
#err1:       .asciiz  "You must enter a positive enter\n"
#err2:       .asciiz  " is not a prime number\n"
#itsPrime:   .asciiz  " is a prime number\n"

#2 

    # Write a program that asks the user for an integer and then computes the square root of that integer. Use only integer arithmetic. 
    # The integer square root of N is the positive integer X who's square is exactly N, or who's square is less than N but as close to N as possible. Examples:

    # iSqrt(25) == 5 since 5*5 == 25.
    # iSqrt(29) == 5 since 5*5 == 25 and 6*6 == 36, so 6 is too big.
    # iSqrt(60) == 7  since 7*7 == 49  and 8*8 == 64, so 8 is too big.
    # iSqrt(0) == 0,  iSqrt(1) == 1, iSqrt(2) == 1.
    # The integer square root is undefined for negative integers.

    #There are various fast ways of computing the integer square root (Newton's method is one). But for this program, use a counting loop that generates 
    # integers 0, 1, 2, 3, ... and their squares 0, 1, 4, 9, ... As soon as the square of an integer exceeds N, then the previous integer is the integer square root of N.
    
        ## ask for a number
        #li          $v0, 4              # code 4 == print string  
        #la          $a0, prompt1        # "enter a number"
        #syscall

        ## collect int entered
        #li          $v0, 5              # code 5 == read int  
        #syscall 
        #move        $s0, $v0            # store the number entered in save reg
        
        ## integer square root is undefined for negative integers
        #blt         $s0, $0, negNum    # if input # < 0, its negitive number
        #nop         
        
        ## set up for loop
        #li         $t0, 0               # count == 0  

    #loop: 
        ## loop to get 
        #mul        $t1, $t0, $t0       # $t1 = count*count
        #bgt         $t1, $s0, sqrt      # if 2(count) >      
        #nop
        
        #move        $t3, $t0            # put value in t0 in t3
        #addiu       $t0, $t0, 1         # count ++
        #j           loop                # do loop again
        #nop
        
        ## end of the program
    #end:
        #li          $v0, 10             # code 10 == exit
        #syscall                         # halt the program
    
    #sqrt: 
        #li          $v0, 4              # code 4 == print string
        #la          $a0, theSqrt        
        #syscall

        #li          $v0, 1              # code 1 == print int 
        #move        $a0, $s0            
        #syscall
        
        #li          $v0, 4              # code 4 == print string 
        #la          $a0, is 
        #syscall             

        #li          $v0, 1              # code 1 == print int
        #move        $a0, $t3            
        #syscall
        
        #j           end                 # end of program 
        #nop

    #negNum:
        #li          $v0, 4              # code 4 == print string
        #la          $a0, negative       # "undefined" 
        #syscall
        #j           end
        #nop
        
#            .data
#prompt1:    .asciiz     "Enter a number: "
#negative:   .asciiz     "The integer square root is undefined for negative integers.\n"
#theSqrt:    .asciiz     "the square root of "
#is:         .asciiz     " is " 
    

#(idk why it jumps to #6) 
#6 

    #To win a lottery you must correctly pick K out of N numbers. For example, you might need to pick 6 numbers out of the numbers 1 to 50. There are

    # *cant fit the example below in 32 bit because 50 * 49 * 48 * 47 * 46 * 45 = 34 bit int

    # (50 * 49 * 48 * 47 * 46 * 45 )/(1 * 2 * 3 * 4 * 5 * 6)
    # ways of picking 6 out of 50 numbers. So your odds of winning are 1 in that number of ways. If you must pick 6 out of 50 numbers, 
    # your odds of winning are 1 in 15,890,700. In general, there are

    # N * (N-1) * (N-2) * (N-3) * (N-4) * ... * (N-K+1)
    # -------------------------------------------------
    #       1  *   2   *   3   *  4    * ... * K

    # ways of picking K out of N numbers.

    # Write a program that asks the user for integers N and K and writes out the odds of winning such a lottery.


    # Test that the program works for reasonable values of N and K

    ## ask how many numbers
        li          $v0, 4              # code 4 == print string      
        la          $a0, prompt1        # "how many numbers" 
        syscall     
        
    ## read in number
        li          $v0, 5              # code 5 == read int
        syscall 

    ## make sure number positive
        li          $t0, 1              # $t1 == 1
        blt         $v0, $t0, tooLow    
        nop 
        move        $s0, $v0            # hold numbers in $s0       

    ## ask for start
        li          $v0, 4              # code 4 == print string
        la          $a0, prompt2        # intro
        syscall
        
        la          $a0, prompt3       # "where numbers start" 
        syscall

    ## read in start
        li          $v0, 5              # code 5 == read int 
        syscall
        move        $s1, $v0            # hold start in $s1 

    ## ask for end 
        li          $v0, 4              # code 4 == print string
        la          $a0, prompt4        # "where numbers end
        syscall

    ## read in end
        li          $v0, 5              # code 5 == read int
        syscall
        move        $s2, $v0            # hold end in $s2

    ## check to make sure start < end
        blt        $s2, $s1, bad       # bad start end vale
        nop 
 
    ## get how many numbers are inbetween start and end  
        subu       $s3, $s2, $s1       # put the difference in $s3 
        addiu      $s3, $s3, 1         # add one

        # idk if I need this
        bgt        $s0, $s3, tooMany   #  can't ask for more # that options
        nop 
        # ----------------
        
        

    ## set up first part of division
        li         $t0, 0             # count = 0 
        li         $t1, 0             # total = 0 
        move       $t2, $s3           # put range $t3

    loop1: 
        beq        $t0, $s0, loop1End # stop when count == how many numbers
        nop
        
        bne        $t0, $0, added1    # if on 1st loop just add to total
        nop
        addu       $t1, $t1, $t2      # total = 0 + range
        j          continue
    
    added1:        
        mul        $t1, $t1, $t2     # mult options

    continue:
        addiu      $t2, $t2, -1      # sub range -1
        addiu      $t0, $t0, 1       # count++
        j          loop1
    
    loop1End: 
    ## set up second part of division
        

    ## divid the two

    ## print the answer
             
    end: 
        li          $v0, 10             # code 10 == exit
        syscall
    
    tooLow:
        li          $v0, 4             # code 4 == print string
        la          $a0, low           #  'min value is 1' 
        syscall
        j           end                # end program 
        nop
    
    bad: 
        li          $v0, 4             # code 4 == print string
        la          $a0, badStartEnd   # "start must be lower than end" 
        syscall
        j           end
        nop
    
    tooMany: 
        li          $v0, 4             # code 4 == print string
        la          $a0, alot          
        syscall 
        j           end 
        nop


            .data
prompt1:    .asciiz     "how many numbers do you need to pick? "
prompt2:    .asciiz     "\nneed to know numbers you can choose ex 1-50 so start= 1, end= 50\n"
prompt3:    .asciiz     "where do number picks start at? " 
prompt4:    .asciiz     "\nwhere do number picks end at? " 
low:        .asciiz     "min value is 1\n"
badStartEnd:.asciiz     "start must be lower than end\n"
alot:       .asciiz     "range must be greater than amount of numbers\n"  # idk if I need this

## end of program
