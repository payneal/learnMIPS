        .text
        .globl main

## ex. 2 

# Write a program that computes the value of triangle numbers using a recursive subroutine. The definition of triangle numbers is:

# Triangle( 1 ) = 1

# Triangle( N ) = N + Triangle( N-1 )
# For examples:
# Triangle( 1 ) = 1
# Triangle( 2 ) = 3
# Triangle( 3 ) = 6
# Triangle( 4 ) = 10

#  main ()
# {         
#   int x,a; 
#   a = triangle(x);
#   write('triangle = '); 
#   write(a); 
# }         
#
main: 
                # prolog
    sub         $sp, $sp, 4         #1. push return address
    sw          $ra, ($sp)
    sub         $sp, $sp, 4         #2. push caller's frame pointer
    sw          $fp, ($sp)

                                    #3. No S registers to push
    sub         $fp, $sp, 8         #4. $fp = $sp - space for variables
    move        $sp, $fp            #5. $sp = $fp

    li          $v0, 4              # code 4 == print string
    la          $a0, ask            # "n = "
    syscall
    
    li          $v0, 5              # code 5 == read int
    syscall
    sw          $v0, 0($fp)         # save in varible x
 
                # subroutine call 
                                    #1. no T registers to push
    lw          $a0, 0($fp)         #2. put argument into $a0
    jal         triangle            #3. jump and link to subroutine
    nop 
            
                                    # return from subroutine
                                    #1. No T registers to restore 
    
    sw          $v0,4($fp)          # a = triangle(x)
    
    li          $v0, 4              # CODE 4 = print string
    la          $a0, answer         # 'answer = '
    syscall
                                    # print(a)
    lw          $a0, 4($fp)         # load a into $a0 
    li          $v0,1               # print integer service 
    syscall
        
                # epilog 
                                    #1. No return value
    add         $sp, $fp, 8         #2. $sp = $fp + spaceVarible
                                    #3. No S registers to pop
    lw          $fp, ($sp)          #4. Pop $fp 
    add         $sp, $sp, 4         
    
    lw          $ra, ($sp)          #5. Pop $ra 
    add         $sp, $sp, 4    

    # end of progran
    li          $v0, 10             # code 10 == exit
    syscall     

        .data
ask:    .asciiz             "what value do you want to use: "    
answer: .asciiz             "answer is: "
## end of Main


############
# triangle #
############
.text
.globl triangle

# int triangle(int x)
#{ 
#   if (x==1)
#       return 1; 
#   else 
#      return x + triangle(x-1)
#} 

triangle: 
                # prolog 
      sub       $sp, $sp, 4         #1. Push return
      sw        $ra, ($sp)
      
      sub       $sp, $sp, 4         #2. Push callers frame pointer
      sw        $fp, ($sp)

      sub       $sp, $sp, 4         #3. push register $s1
      sw        $s1, ($sp)
      
      sub       $fp, $sp, 0         #4. $fp = $sp - spaceVariables
      move      $sp, $fp            #5. $sp = $fp 
    
                # body subroutine
      move      $s1, $a0            # save argument in $s1
      li        $t1, 1              # get a 1
      bne       $s1, $t1, recurse   # if x 
      nop
      li        $v0, 1              # return 1 
      b         epilog
      nop

    recurse:                        # else
                                    # return return x + triangle(x-1)
      sub       $a0, $s1, 1         # n-1 
                # subroutine call
                                    #1. No T registers to push
                                    #2. Argument is in $a0
      jal       triangle            #3. Jump and link to subroutine
      nop
      addu      $v0, $v0, $s1       # x + triangle(x-1)

    epilog:                         # epilog
                                    #1. Return value is alreadt in $v0
      add       $sp, $fp,0          #2. $sp = $fp + spaceForVariables
      lw        $s1, ($sp)          #3. pop register $s1
      add       $sp, $sp, 4
      lw        $fp, ($sp)          #4. POP $fp 
      add       $sp, $sp, 4 
      lw        $ra, ($sp)          #5. POP $ra 
      add       $sp, $sp, 4
      jr        $ra
      nop
## end of triangle



