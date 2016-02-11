          .globl   main
          .text

# *Exercise 3 -- Static Objects

#Add several additional objects to the Complete Program of ass36_19.html. Modify the main program so that it exercises several of the methods of the objects.

main:             # object1.print(); 
          la       $a0,object1        #   get address of first object
          lw       $t0,0($a0)         #   get address of print method
          jalr     $t0                #   call the method 
        
                  # object1.capitalize(); 
          la       $a0, object1       #   get address of first object
          lw       $t0,12($a0)         #   get address of print method
          jalr     $t0                #   call the method 

                   # object1.print();
          la       $a0,object1        #   get address of first object
          lw       $t0,0($a0)         #   get address of print method
          jalr     $t0                #   call the method

                  # object1.cancel();
          la       $a0,object1        #   get address of first object
          lw       $t0,4($a0)         #   get address of cancel method
          jalr     $t0                #   call the method
                 
                  # object1.print();
          la       $a0,object1        #   get address of first object
          lw       $t0,0($a0)         #   get address of print method
          jalr     $t0                #   call the method

                  # new line to seperate
          li       $v0, 4
          la       $a0, newL 
          syscall
        
                   # object1.clear();
          la       $a0,object1        #   get address of first object
          lw       $t0,8($a0)         #   get address of print method
          jalr     $t0                #   call the method

                  # object1.print();
          la       $a0,object1        #   get address of first object
          lw       $t0,0($a0)         #   get address of print method
          jalr     $t0                #   call the method

                  # new line to seperate
          li       $v0, 4
          la       $a0, newL 
          syscall
         
          # object2.print(); 
          la       $a0,object2        #   get address of first object
          lw       $t0,0($a0)         #   get address of print method
          jalr     $t0                #   call the method 
        
                  # object2.capitalize(); 
          la       $a0, object2       #   get address of first object
          lw       $t0,12($a0)         #   get address of print method
          jalr     $t0                #   call the method 

                   # object2.print();
          la       $a0,object2        #   get address of first object
          lw       $t0,0($a0)         #   get address of print method
          jalr     $t0                #   call the method

                  # object2.cancel();
          la       $a0,object2        #   get address of first object
          lw       $t0,4($a0)         #   get address of cancel method
          jalr     $t0                #   call the method
                 
                  # object2.print();
          la       $a0,object2        #   get address of first object
          lw       $t0,0($a0)         #   get address of print method
          jalr     $t0                #   call the method

                  # new line to seperate
          li       $v0, 4
          la       $a0, newL 
          syscall
        
                   # object2.clear();
          la       $a0,object2        #   get address of first object
          lw       $t0,8($a0)         #   get address of print method
          jalr     $t0                #   call the method

                  # object2.print();
          la       $a0,object2        #   get address of first object
          lw       $t0,0($a0)         #   get address of print method
          jalr     $t0                #   call the method

                  # new line to seperate
          li       $v0, 4
          la       $a0, newL 
          syscall 

          # object3.print(); 
          la       $a0,object3        #   get address of first object
          lw       $t0,0($a0)         #   get address of print method
          jalr     $t0                #   call the method 
        
                  # object3.capitalize(); 
          la       $a0, object3       #   get address of first object
          lw       $t0,12($a0)         #   get address of print method
          jalr     $t0                #   call the method 

                   # object3.print();
          la       $a0,object3        #   get address of first object
          lw       $t0,0($a0)         #   get address of print method
          jalr     $t0                #   call the method

                  # object3.cancel();
          la       $a0,object3        #   get address of first object
          lw       $t0,4($a0)         #   get address of cancel method
          jalr     $t0                #   call the method
                 
                  # object3.print();
          la       $a0,object3        #   get address of first object
          lw       $t0,0($a0)         #   get address of print method
          jalr     $t0                #   call the method

                  # new line to seperate
          li       $v0, 4
          la       $a0, newL 
          syscall
        
                   # object3.clear();
          la       $a0,object3        #   get address of first object
          lw       $t0,8($a0)         #   get address of print method
          jalr     $t0                #   call the method

                  # object3.print();
          la       $a0,object3        #   get address of first object
          lw       $t0,0($a0)         #   get address of print method
          jalr     $t0                #   call the method

                  # new line to seperate
          li       $v0, 4
          la       $a0, newL 
          syscall

          # object4.print(); 
          la       $a0,object4        #   get address of first object
          lw       $t0,0($a0)         #   get address of print method
          jalr     $t0                #   call the method 
        
                  # object4.capitalize(); 
          la       $a0, object4       #   get address of first object
          lw       $t0,12($a0)         #   get address of print method
          jalr     $t0                #   call the method 

                   # object4.print();
          la       $a0,object4        #   get address of first object
          lw       $t0,0($a0)         #   get address of print method
          jalr     $t0                #   call the method

                  # object4.cancel();
          la       $a0,object4        #   get address of first object
          lw       $t0,4($a0)         #   get address of cancel method
          jalr     $t0                #   call the method
                 
                  # object4.print();
          la       $a0,object4        #   get address of first object
          lw       $t0,0($a0)         #   get address of print method
          jalr     $t0                #   call the method

                  # new line to seperate
          li       $v0, 4
          la       $a0, newL 
          syscall
        
                   # object4.clear();
          la       $a0,object4        #   get address of first object
          lw       $t0,8($a0)         #   get address of print method
          jalr     $t0                #   call the method

                  # object4.print();
          la       $a0,object4        #   get address of first object
          lw       $t0,0($a0)         #   get address of print method
          jalr     $t0                #   call the method

                  # new line to seperate
          li       $v0, 4
          la       $a0, newL 
          syscall

          # object5.print(); 
          la       $a0,object5        #   get address of first object
          lw       $t0,0($a0)         #   get address of print method
          jalr     $t0                #   call the method 
        
                  # object5.capitalize(); 
          la       $a0, object5       #   get address of first object
          lw       $t0,12($a0)         #   get address of print method
          jalr     $t0                #   call the method 

                   # object5.print();
          la       $a0,object5        #   get address of first object
          lw       $t0,0($a0)         #   get address of print method
          jalr     $t0                #   call the method

                  # object5.cancel();
          la       $a0,object5        #   get address of first object
          lw       $t0,4($a0)         #   get address of cancel method
          jalr     $t0                #   call the method
                 
                  # object5.print();
          la       $a0,object5        #   get address of first object
          lw       $t0,0($a0)         #   get address of print method
          jalr     $t0                #   call the method

                  # new line to seperate
          li       $v0, 4
          la       $a0, newL 
          syscall
        
                   # object5.clear();
          la       $a0,object5        #   get address of first object
          lw       $t0,8($a0)         #   get address of print method
          jalr     $t0                #   call the method

                  # object5.print();
          la       $a0,object5        #   get address of first object
          lw       $t0,0($a0)         #   get address of print method
          jalr     $t0                #   call the method

                  # new line to seperate
          li       $v0, 4
          la       $a0, newL 
          syscall

          # exit program
          li      $v0,10              # return to OS
          syscall

# Objects constructed in static memory.
# The implementation of an object consists of the data for each object
# and a jump table of entry points common to all objects
# of this type.

          .data
newL:     .asciiz     "\n" 
object1:
          .word    print                    # Jump Table
          .word    cancel
          .word    clear
          .word    capitalize
          .asciiz  "Hello World\n"          # This object's data
          
object2:
          .word    print                    # Jump Table
          .word    cancel
          .word    clear
          .word    capitalize
          .asciiz  "Silly Example\n"        # This object's data

object3: 
          .word    print 
          .word    cancel
          .word    clear
          .word    capitalize 
          .asciiz  "My Name is Ali Payne\n" # This objects data

object4: 

          .word    print 
          .word    cancel
          .word    clear
          .word    capitalize
          .asciiz  "The cat in the hat wears black\n" # This objects data

object5: 
          
          .word    print 
          .word    cancel
          .word    clear
          .word    capitalize
          .asciiz  "how's life\n" # This objects data

# print() method
# Parameter: $a0 == address of the object
          .text         
print:
          li       $v0,4                   # print string service
          addiu    $a0,$a0,16              # address of object's string
          syscall                          # 
          jr       $ra
          
# cancel() method
# Parameter: $a0 == address of the object
# 
# Registers:
# $t0 == address of the char in the string
# $t1 == char from the string
# $t2 == 'x'

          .text         
cancel:
          addiu    $t0,$a0,16       # the string starts 8 bytes
                                   # from the start of the object
          li       $t2,'x'         # replacement character                             
          lb       $t1,0($t0)      # get first ch of string
loop:     beqz     $t1,canDone     # while ( ch != '\0' )
          sb       $t2,0($t0)      #   replace ch with 'x'
          addiu    $t0,$t0,1       #
          lb       $t1,0($t0)      #   get next ch
          b        loop            # end while     
canDone:
          jr       $ra             # return to caller

###################################################################

# clear() method
# Parameter: $a0 == address of the object
# 
# Registers:
# $t0 == address of the char in the string
# $t1 == char from the string
# $t2 == 

# method that makes the first byte of an objects string the null byte (in effect deleting the string) 
          .text
clear: 
          addiu    $t0, $a0, 16    # the string starts 8 bytes
                                   # from the start of the object
          li       $t2, 0x0        # store null char          
          sw       $t2, 0($t0)     # replace ch with null

          jr       $ra             # return to caller

####################################################################

# capitalize method 
# Parameter: $a0 == address of the object
# 
# Registers:
# $t0 == address of the char in the string
# $t1 == char from the string

# changes each lower case character of the object's string to a capital letter. Do this by adding 0x20 to each lower case letter

        .text
capitalize: 
          # li      $v0, 4
          # la      $a0, yourInCaps
          # syscall

          addiu     $t0, $a0, 16   # the string starts 8 bytes
          li        $t1, 'a'       # hold a 
          li        $t2, 'z'       # hold z 
          li        $t3, 0x20      # adding 0x20 

          lb        $t4, 0($t0)
            
        loop1: 
          beqz      $t4, capDone
         
          blt       $t4, $t1, skip
          bgt       $t4, $t2, skip
        
          sub       $t4, $t4, $t3  # make caped
          sb        $t4, 0($t0) 
         
       skip:
          addiu     $t0, $t0, 1 
          lb        $t4, 0($t0)    # get next ch 
          b         loop1

       capDone:
          jr       $ra             # return to caller

        .data
yourInCaps:    .asciiz         "you made it to caps section\n"
#####################################################################
