        .text
        .globl main

# ex 1

#Translate the following little program into MIPS assembly language. Do a line-by-line translation as a simple compiler might do (as done in the chapter). Use stack-based variables for the program's local variables. Assemble and run your program under SPIM

#main()
#{
#  int f;
#  int c;
  
#  f = 50;
#  c = toCent( f );
  
#  print( "f=", f, "c=", c );
#}

#int toCent( int x )
#{
#  int v;
#  v =  x - 32;
#  v =  5*v
#  v =  v/9;
#  return v;
#}
#You could, of course, write the program without using variables since there are plenty of "T" registers available. But practice using local variables as in the chapter. For each assignment statement, for each variable on the right of the equal sign retrieve a value from a variable on the stack. For the variable on the left of an assignment statement, store a value into the variable, even if the very next statement requires that the value be retrieved.

# IDK IF I REALLY GET THIS 

main: 
        li              $s0, 50         #f = 50

                        # prolog
        sub             $sp, $sp, 4     #1. push return address
        sw              $ra, ($sp)
       
        sub             $sp, $sp, 4     #2. push callers frame pointer
        sw              $fp, ($sp)      
       
        sub             $sp, $sp,4      #3.push S registres
        sw              $s0, ($sp)

        sub             $fp, $sp, 8     #4. $fp = $sp - space for varibles in this ex. v in toCent(x)
        move            $sp, $fp        #5. $sp = $fp
        
                        # subroutine call
                                        #1. No T regs to push
        move            $a0, $s0        #2. put argumnet into $a0  
        jal             toCent          #3. jump and link to subroutine
        nop
    
                                        # return from subroutine
                                        # 1. no T registers to restore
        sw              $v0,0($fp)      # c = toCent( f )
                
        li              $v0, 4          # print string
        la              $a0, Fequals    # "F= "
        syscall
    
        li              $v0, 1          # print int
        lw              $a0,8($fp)      # load a into $a0
        syscall

        li              $v0, 4          # print string
        la              $a0, Cequals    # "C= "
        syscall

        li              $v0, 1          # print int
        lw              $a0,0($fp)        # load a into $a0
        syscall

    exit:
        ## end the program
        li              $v0, 10             # code 10 == exit
        syscall
        
.data 
Fequals:     .asciiz         "f= "
Cequals:     .asciiz         "\nc= "
                     
## END OF Main 


##############
### toCent ###
##############
#int toCent( int x )
#{
#  int v;
#  v =  x - 32;
#  v =  5*v
#  v =  v/9;
#  return v;
#}

        .text
        .globl toCent
toCent: 
                #prolog
        sub             $sp, $sp, 4         #1. push return address 
        sw              $ra, ($sp)
        sub             $sp, $sp, 4         #2. push caller's frame pointer
        sw              $fp, ($sp)

        sub             $sp, $sp, 4         #3. push reg $s1
        sw              $s1, ($sp)
    
        sub             $fp, $sp, 8         #4. $fp = $sp - space for varibles
        
        move            $sp, $fp            #5. $sp = $fp 
                
                # body of subroutine
        addu            $s1, $a0, -32       # arg - 32 
        sw              $s1,0($fp)          # v = " "

        lw              $t0, 0($fp)         # get v 
        mul             $s1, $t0, 5         # 5*v 
        
        sw              $s1,0($fp)          # v = ' '
        
        lw              $t0, 0($fp)         # get v
        div             $s1, $t0, 9         # v/9 
        
        sw              $s1,0($fp)          # v = " "

                # epilog
        lw              $v0, 0($fp)         #1. Put return value in $v0
        add             $sp, $fp,8          #2. $fp + space for varibles
        lw              $s1, ($sp)          #3. pop register $s1
        add             $sp, $sp,4
        lw              $fp, ($sp)          #4. pop $fp
        add             $sp, $sp, 4
        lw              $ra, ($sp)          #5. pop $ra
        add             $sp,$sp,4           
        
        jr              $ra                 #6. return to caller
        nop

##  end of toCent


