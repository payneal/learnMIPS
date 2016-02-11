        .globl main
        .text

# **Exercise 5 -- Dynamic Objects

# Design an object that has an integer for its data. Its methods are set(), double(), and print(). The set() method is passed a parameter in $a0 and sets the object's data to that value. The double() method doubles an object's integer, and the print() method prints out the integer.

# Write a main routine that creates several objects and tests their methods.

main:  
                                      # OBJECT 1 = NEW OBJECT(); 
          li      $v0, 9              # allocate 16 bytes 
          li      $a0, 16             #
          syscall                     # $v0 = address 
          sw      $v0, object1        #

          la      $t0, set            # initialize jump table
          sw      $t0,0($v0)          #
          la      $t0, double         #
          sw      $t0,4($v0)          #
          la      $t0, print          #
          sw      $t0,8($v0)          #

          # ask for the number
          li      $v0, 4              # print string
          la      $a0, askNumb        #
          syscall

          li      $v0, 5              # read int
          syscall

          move    $a0, $v0            # put number entered as arguement 

          # object1.set(); 
          lw      $a1, object1        # get address of object1
          lw      $t0,0($a0)          # get address of set method 
          jalr    $t0                 # call the method 
            
          # object.print(); 
          lw      $a0, object1        # get address of object1
          lw      $t0,8($a0)          # get address of print method 
          jalr    $t0
 
          # object1.double(); 
          #lw      $a0, object1        # get address of object1
          #lw      $t0,4($a0)          # get address of double method 
          #jalr    $t0  

          # object.print(); 
          #lw      $a0, object1        # get address of object1
          #lw      $t0,8($a0)          # get address of print method 
          #jalr    $t0

          # exit program
          li      $v0,10              # return to OS
          syscall     

           .data
object1:   .word        0 
object2:   .word        0 
object3:   .word        0
askNum:    .asciiz      "what is the number for this object: "        
         
## end of main
      
#######################################

# set() method
# Parameter: $a0 == what to set value to 
# Parameter: $a1 == address of the object
        .text
set: 
        move     $s1,$a1           # save objects address 
         
        addiu    $a1, $s1, 12      # $a1 = address of where objects value is stored 
 
        sw       $a0,0($a1)        # save the value
                 
        jr       $ra               # return to caller

        .data
ask:    .asciiz     ""
#######################################

# double() method
        .text
double:
           
        
        jr       $ra             # return to caller

#######################################

# print() method
# Parameter: $a0 == address of the object
        .text
print:
        li        $v0, 1         # print int
        addiu     $a0, $a0, 12   # address of objects int 
        syscall     

        li        $v0, 4        # print  string
        la        $a0, newL     # new line
        syscall
        
        jr       $ra             # return to caller

        .data
newL:   .asciiz     "\n"
#######################################

