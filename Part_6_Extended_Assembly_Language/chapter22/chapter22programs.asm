        .text 
        .globl main

main: 

    ## ex.1 

    ## Write a program that repeatedly prompts the user for the number of miles traveled and the gallons of gasoline consumed, and then prints out the miles per gallon. Use integer math. Exit when the user enters 0 for the number of miles.
    
    #loop:
        #li         $v0, 4              # code 4 == print string
        #la         $a0, promp1         # Number of miles traveled 
        #syscall                        # have op system make it happen
   
        #li         $v0, 5              # read in miles
        #syscall
        #beq        $v0, $0, end             # if mills == 0 end program
        #nop
        #move       $t0, $v0            # put answer in $t0

        #li         $v0, 4              # code 4 == Print string
        #la         $a0, promp2         # Number of gallons used
        #syscall 

        #li         $v0, 5              # read in gallons
        #syscall    
        #move       $t1, $v0            # put answer in $t1
        
        #div        $t0, $t1            # miles/gallons
        #mflo       $a0                 # put answer in $0 to print it

        #li         $v0, 1              # code 1 == print int
        #syscall
        #li         $v0, 4              # code 4 === print string
        #la         $a0, answer         # print MPG
        #syscall        

        #j           loop               # do again
        #nop

    #end:
        #li         $v0, 10             # code 10 == exit
        #syscall                        # halt the program

        #.data
#promp1:.asciiz      "Number of miles travled?\n"
#promp2:.asciiz      "Gallons of Gasoline consumed?\n"
#answer:.asciiz      " MPG\n"


    ## ex.2
    
    ## As in Exercise1, write a program that repeatedly prompts the user for the number of miles traveled and the gallons of gasoline consumed, and then prints out the miles per gallon. Exit when the user enters 0 for the number of miles.

    ## Use fixed-point arithmetic for this. Multiply input value of miles by 100. Divide miles by gallons to get miles per gallon. The answer will 100 times too large. So divide it by 100 to get whole miles per gallon in hi and hundredths in lo. Print out lo followed by "." followed by hi to get an output that looks like: "32.45 mpg".

        
        #li        $s0, 100              # multiplicating by 100
    #loop: 
        #li        $v0, 4
        #la        $a0, prompt1          # Number of miles traveled
        #syscall                        # have op system make it happen

        #li        $v0, 5               # read in miles
        #syscall                        

        #beq       $v0, $0, end         # if miles == 0 end program
        #nop
        #move      $t0, $v0             # put answer in $t0
        
        #Multiply input value of miles by 100
        #mult      $t0, $s0             # muliply by 100 
        #mflo      $t0
        # ----------------------------------

        #li        $v0, 4               # code 4 == Print
        #la        $a0, prompt2          # Number of gallons Used
        #syscall                 

        #li        $v0, 5               # read  in gallons
        #syscall
        #move      $t1, $v0             # put answer in $t1
        
        #div       $t0, $t1             # miles/gallons
        #mflo      $t0                  # put answer in $t0
        
        # divid it by 100 to give whole miles per gallon
        #div       $t0, $s0             # div by 100
        #mflo      $t0                  # put quotient in $t0
        #mfhi      $t1                  # put remainer in $t1
                
        #li        $v0, 1               # code 1 == print int
        #move      $a0, $t0          
        #syscall 

        #li        $v0, 4               # code 4 ==== print string
        #la        $a0, period          # print .
        #syscall
        
        #li        $v0, 1               # code 1 == print int
        #move      $a0, $t1
        #syscall
        
        #li        $v0, 4               # code 4 ==== print string
        #la        $a0, answer          # print answer
        #syscall

        #j         loop                 # do again
        #nop 
    #end: 
        #li      $v0, 10                # code 10 == exit
        #syscall 
    
       #.data
#prompt1:.asciiz      "Number of miles travled?\n"
#prompt2:.asciiz      "Gallons of Gasoline consumed?\n"
#answer:.asciiz      " mpg\n"
#period:.asciiz      "."

    ## ex.3 
        # Write a program that asks the user for a string of digits that represent a positive integer. 
        # Read in the string using service number 8, the "read string" service. Now convert the string of digits into an integer by the following algorithm:
        
        # value = 0;

        # for each digit starting with the left-most:
        
        #{
            #convert the digit into an integer D by subtracting 0x30
            #value = value*10 + D
        #}

        # You might recognize this as Horner's method. After converting the integer, check if it is correct by writing it out on the simulated monitor using service 1.

        # Notes: assume that the input is correct (that it contains only digits and can be converted to a 32-bit integer). 
        # Be sure to deal properly with the end-of-line character that is at the end of the user's input.


        li        $s0, 0x30             # for subtracting 
        li        $s1, 10               # for multiplication
        li        $v0, 4                # code 4 == print string
        la        $a0,prompt1           # print "enter string ..." 
        syscall
        
        la        $a0, input
        li        $v0, 8                # code 8 == read string
        syscall
        
        # test to make sure got string
        li        $v0, 4                # code 4 ==== print string
        la        $a0, test             # print "you entered: "
        syscall

        la        $a0, input            # print string given
        syscall

        li        $t0, 0               # set value= 0   
        li        $t5, 0               # set count = 0
        la        $a0, input    
        lb        $t3,0($a0)           # load the number
        or        $26, $0, $t3         # put
        nop
        nop 

    loop:
        beq       $t3, $zero, done     # if address points to null we are done
        nop                         
   
        subu      $t3, $t3, $s0       # sub 0x30 to change char to #
        #blt       $t1, 48, error   #check if char is not a digit (ascii<'0')
        nop
        #bgt       $t1, 57, error   #check if char is not a digit (ascii>'9')        
        nop

        mult      $t0, $s1
        mflo      $t0
        
        addu      $t0, $t0, $t3

        li        $v0, 1               # set up print int
        move      $a0, $t3             # 
        syscall

        addiu    $a0, $a0, 1           # point to next car
        addiu    $t5, $t5, 1           # add to count

        la        $a0, input
        addu      $a0, $a0, $t5     
        lb        $t3,0($a0)           # load the number 

        j         loop                 # redo the loop
        nop 

    done: 
        nop
        # for checking puropse look at $8
            

        li      $v0,10      # code 10 == exit
        syscall             # Halt the program.                


        .data
prompt1:.asciiz         "Enter a string of numbers: "
prompt2:.asciiz         "Here is your string as int: "
test:   .asciiz         "you entered: "
newL    .asciiz         "\n"
input:  .space          20

    ## ex.4 


## end of program
