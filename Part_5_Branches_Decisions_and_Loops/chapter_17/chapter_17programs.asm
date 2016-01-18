
      .text
      .globl  main

main:
    #Exercise 1 — Non-ending Loop

    #Write a program that computes the sum:
         #1 + 2 + 3 + 4 + 5 + ...
 
      addiu     $8,$8,1     # ADD 1  
      j         main        # LOOP TO MAIN AGAIN
      sll       $0,$0,0     # non sense required for jump


    #exercise 2 - Non-ending Loop with Overflow

    #Write a program that adds $8 to itself inside a non-ending loop. Initialize $8 before the loop is entered. Use the add instruction so that when overflow is detected the program ends with a trap.

    ori         $8, $0, 14  #make $8 = 14
    test: 
    addu         $8, $8, $8  # add 14 + 14 we should get overflow eventually
    j           test        
    sll         $0, $0, 0   #non sense
    
    #add overflow at 1879048192
    
    #addu overflow never happened at some point reg went - then 0 

    # Exercise 3 — Counting Loop
        # Write a program that computes the sum:
            # 1 + 2 + 3 + 4 + 5 + ... + 98 + 99 + 100

    ori         $8, $0, 1       #set $1 = 1
    ori         $2, $0, 101     #set $2 = 101
    ori         $3,$0,0         # SET $3 = 0 
    addthis:                    #LOOP HERE
    
    addu        $3, $8, $3      # $3 = $1 +1
    addiu       $8,$8, 1       # $1 = $1 + ($1 +1)
    
     beq         $8, $2, exit    # if $1 == 101 exit
    sll         $0, $0, 0      # non sense
    j           addthis        # jump to addthis
    sll         $0, $0, 0      #non sense
    exit: 

   # Exercise 4 — Fibonacci Series

        # Write a program that computes terms of the Fibonacci series, defined as:
            #1, 1, 2, 3, 5, 8, 13, 21, 34, 55, ...
            # Write the program as a counting loop that terminates when the first 100 terms of the series have been computed

   ori          $2, $0, 2       # set the counting loop to 2
   ori          $7, $0, 1       # one 
   ori          $8, $0, 1       # two
   ori          $3, $0, 0       #total
   ori          $15, $0, 100    # set to 100 for if statement

   fib:                         #loop here
   addu         $3, $7, $8      # total = fib1 +fib2
   addu         $9, $7, $8      # hold new fib number at $9
   or           $7, $0, $8      # fib1 becomes fib2
   or           $8, $0, $9      # fib2 become fib1+fib2
   addiu        $2, $2, 1       # add one each loop
   beq          $2, $15, exit   #quit program at 100 
   j            fib             # do the fib thing again
   sll          $0,$0,0         #non sense required
   exit:

  # loop is correct but math isnt after a ceratin point i dont know if the question was concerned about the math or how to loop
## End of file
