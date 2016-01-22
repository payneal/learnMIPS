        .text 
        .globl main

main: 

    ## ex.1 

    ## Write a program that repeatedly prompts the user for the number of miles traveled and the gallons of gasoline consumed, and then prints out the miles per gallon. Use integer math. Exit when the user enters 0 for the number of miles.
    
    loop:
        li         $v0, 4              # code 4 == print string
        la         $a0, promp1         # Number of miles traveled 
        syscall                        # have op system make it happen
   
        li         $v0, 5              # read in miles
        syscall
        beq        $v0, $0, end             # if mills == 0 end program
        nop
        move       $t0, $v0            # put answer in $t0

        li         $v0, 4              # code 4 == Print string
        la         $a0, promp2         # Number of gallons used
        syscall 

        li         $v0, 5              # read in gallons
        syscall    
        move       $t1, $v0            # put answer in $t1
        
        div        $t0, $t1            # miles/gallons
        mflo       $a0                 # put answer in $0 to print it

        li         $v0, 1              # code 1 == print int
        syscall
        li         $v0, 4              # code 4 === print string
        la         $a0, answer         # print MPG
        syscall        

        j           loop               # do again
        nop

    end:
        li         $v0, 10             # code 10 == exit
        syscall                        # halt the program

        .data
promp1:.asciiz      "Number of miles travled?\n"
promp2:.asciiz      "Gallons of Gasoline consumed?\n"
answer:.asciiz      " MPG\n"


    ## ex.2
    
    ## As in Exercise1, write a program that repeatedly prompts the user for the number of miles traveled and the gallons of gasoline consumed, and then prints out the miles per gallon. Exit when the user enters 0 for the number of miles.

    ## Use fixed-point arithmetic for this. Multiply input value of miles by 100. Divide miles by gallons to get miles per gallon. The answer will 100 times too large. So divide it by 100 to get whole miles per gallon in hi and hundredths in lo. Print out lo followed by "." followed by hi to get an output that looks like: "32.45 mpg".

        
        li        $s0, 100              # multiplicating by 100
    loop: 
        li        $v0, 4
        la        $a0, prompt1          # Number of miles traveled
        syscall                        # have op system make it happen

        li        $v0, 5               # read in miles
        syscall                        

        beq       $v0, $0, end         # if miles == 0 end program
        nop
        move      $t0, $v0             # put answer in $t0
        
        #Multiply input value of miles by 100
        mult      $t0, $s0             # muliply by 100 
        mflo      $t0
        # ----------------------------------

        li        $v0, 4               # code 4 == Print
        la        $a0, prompt2          # Number of gallons Used
        syscall                 

        li        $v0, 5               # read  in gallons
        syscall
        move      $t1, $v0             # put answer in $t1
        
        div       $t0, $t1             # miles/gallons
        mflo      $t0                  # put answer in $t0
        
        # divid it by 100 to give whole miles per gallon
        div       $t0, $s0             # div by 100
        mflo      $t0                  # put quotient in $t0
        mfhi      $t1                  # put remainer in $t1
                
        li        $v0, 1               # code 1 == print int
        move      $a0, $t0          
        syscall 

        li        $v0, 4               # code 4 ==== print string
        la        $a0, period          # print .
        syscall
        
        li        $v0, 1               # code 1 == print int
        move      $a0, $t1
        syscall
        
        li        $v0, 4               # code 4 ==== print string
        la        $a0, answer          # print answer
        syscall

        j         loop                 # do again
        nop 
    end: 
        li      $v0, 10                # code 10 == exit
        syscall 
    
       .data
prompt1:.asciiz      "Number of miles travled?\n"
prompt2:.asciiz      "Gallons of Gasoline consumed?\n"
answer:.asciiz      " mpg\n"
period:.asciiz      "."

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
        # question for chris why does 0xa end the string and not null? 
            
            # *I think I found answer http://stackoverflow.com/questions/2575867/reading-the-file-name-from-user-input-in-mips-assembly
                # not exact situation but relatable I would assume  

        beq       $t3, $zero, done     # if $T3 ==  null we are done
        nop        
        
        la        $s3, 0xa
        beq       $t3, $s3, done
 
        # -------------------------------------------------------------
    
        blt       $t3, 48, error   #check if char is not a digit (ascii<'0')
        nop
        bgt       $t3, 57, error   #check if char is not a digit (ascii>'9')        
        nop

        subu      $t3, $t3, $s0       # sub 0x30 to change char to #    

        mult      $t0, $s1            # value * 10
        mflo      $t0                 # put answer back in $t0
        
        addu      $t0, $t0, $t3       # value = value  +  int(char)

        li        $v0, 1               # set up print int
        move      $a0, $t3             # prints value in $t3
        syscall
        
        li        $v0, 4                # code 4 == print string 
        la        $a0, newL             # print new line
        syscall

        addiu    $t5, $t5, 1           # add to count

        la        $a0, input           # load the adress input
        addu      $a0, $a0, $t5     
        lb        $t3,0($a0)           # load the number we are on by adding count 

        j         loop                 # redo the loop
        nop 

    done:
        li        $v0, 4                # code 4 ==== print string 
        la        $a0, prompt2          # "here is you string as an int "
        syscall
        
        li        $v0, 1                # code 1 == print int
        move    $a0, $t0                # value int(char)
        syscall

        nop
        li      $v0,10      # code 10 == exit
        syscall             # Halt the program.

    error:
        li        $v0, 4                # code 4 == print string
        la        $a0, errmsg           # print "you entered: ""
        syscall

        move   $27, $t3

        li      $v0,10      # code 10 == exit
        syscall             # Halt the program.
        
        # for checking puropse look at $8


        .data
prompt1:.asciiz         "Enter string  of numbers: "
prompt2:.asciiz         "Here is your string as int: "
test:   .asciiz         "you entered: "
input:  .space          20
errmsg: .asciiz         "Error you entered a char thats not a varible"  
newL:   .asciiz         "\n"


    ## ex.4 
        
    # Write a program that repeatedly asks the user for a scale F or a C (for "Fahrenheit" or "Celsius") on one line followed
    # by an integer temperature on the next line. It then converts the given temperature to the other scale. Use the formulas:

    # F = (9/5)C + 32

    # C = (5/9)(F - 32)
    # Exit the loop when the user types "Q". Assume that all input is correct. For example:

    # Enter Scale      : F
    # Enter Temperature: 32
    # Celsius Temperature: 0C

    # Enter Scale      : C
    # Enter Temperature: 100
    # Fahrenheit Temperature: 212F

    # Enter Scale      : Q
    # done

    # C to F is not that correct



    li        $s0, 90             # constants 
    li        $s1, 5
    li        $s2, 32
    li        $s3, 0x46          # F   
    li        $s4, 0x43          # C   
    li        $s5, 0x51          # Q   
    li        $s6, 10            # 10 for math stuff
    li        $s7, 55            # dirty math 
loop:
    li        $v0, 4             # code 4 == print string  
    la        $a0, prompt1       # "Enter Scale
    syscall

    la        $a0, input         # set up for holding f or C 
    li        $a1, 2             # only allows 1 character to be input

    li        $v0, 8             # code 5 == read string
    syscall
   
    lb        $t0,0($a0)         # load the input to $t0
 
    beq       $t0, $s3, F        # input == F 
    nop    
    beq       $t0, $s4, C        # input == C 
    nop
    beq       $t0, $s5,done     # input == Q your done
    nop
    li        $v0, 4             # code 4 == print string  
    la        $a0, bad           # "bad entry" 
    syscall    
 
    j         loop              #jump to done if bad char
    nop
  
  F:  
    li        $v0, 4             # code 4 == print string 
    la        $a0,Far
    syscall
    j         getInput
  
  C:
    li        $v0, 4            # code 4 == print string
    la        $a0, Cel          
    syscall

 getInput:    
    li       $v0, 5             # code 5 == read int
    syscall

    move     $t1, $v0           # put input in $t1 
    
    beq       $t0, $s3, FMath   # input == F   
    nop
    
    li        $v0, 4            # code 4 == print string 
    la        $a0, testC          
    syscall

    #here
        
    div       $s0, $s1         # 90/5 
    mflo      $t3              # put answer in $t3
   
    mult      $t3, $t1
    mflo      $t3

    div       $t3, $s6         # answer/10
    mflo      $t3              #quotient
    mfhi      $t4              # remainder


    addu      $t3, $t3, $s2    # add 32 
    

    li        $v0, 1          # prints the first number
    move      $a0, $t3
    syscall  
    
    li        $v0, 4          # prints the . 
    la      $a0, period
    syscall

    li         $v0, 1         # prints the second number
    move       $a0, $t4
    syscall    

    li        $v0, 4          # prints the f
    la        $a0, Fsign
    syscall
 
    j        loop
    nop
    
  FMath:
    li        $v0, 4           # code 4 == print string     
    la        $a0, testF       
    syscall 

    # here
    
    addiu      $t3, $t1, -32   # INPUT - 32
 
    mult       $s7, $t3        # answer * 55
    mflo       $t3  

    mult       $s6, $s6       # 10 *10 
    mflo       $t5            # 100

    div        $t3, $t5       # answer / 100 
    
    mfhi       $t3            #  remainer
    mflo       $t4            # number

    li        $v0, 1          # prints the first number 
     move      $a0, $t4 
    syscall 

    li        $v0, 4          # prints the .    
    la      $a0, period 
    syscall

    li         $v0, 1         # prints the second number
    move      $a0, $t3   
    syscall

    li        $v0, 4          # prints the c    
    la        $a0, Csign
    syscall    
   
    j         loop
    nop
    
  done:
    li        $v0, 4             # code 4 == print string  
    la        $a0, doneTxt      # "done" 
    syscall
    
    li      $v0,10      # code 10 == exit
    syscall             # Halt the program.

    .data
prompt1:.asciiz           "Enter Scale C or F         : "  
prompt2:.asciiz           "Enter Temperature          : "
input:  .space            20  
Cel:    .asciiz           "\nCelsius Temperature      : "
Far:    .asciiz           "\nFahrenheit Temperature   : "
enter:  .asciiz           "Enter Scale              : "
doneTxt:.asciiz           "\ndone"
Csign:  .asciiz           "C\n"
Fsign:  .asciiz           "F\n"
testC:  .asciiz           "C math here\n" 
testF:  .asciiz           "F math here\n"  
bad:    .asciiz           "\nBad value try agian\n"
period: .asciiz           "."
## end of program
