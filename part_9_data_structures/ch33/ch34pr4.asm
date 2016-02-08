        .text
        .globl main

# Write a program that asks the user for the size of an image: R rows and C columns. Then allocate space for R*C bytes.
# Fill row 1 with 1s, fill row 2 with 2s, and so on. Examine the data section of the simulator to see if you did this correctly.

main: 

      li    $v0, 4          # code 4 == print string
      la    $a0, askRow     # how many Rows?
      syscall 

      li    $v0, 5          # collect answer
      syscall
      move  $s0, $v0        # save answer
    
      li    $v0, 4          # code 4 == print string
      la    $a0, askCol     # how many Cols?
      syscall 

      li    $v0, 5          # collect answer
      syscall
      move  $s1, $v0         # save answer
      
      mul   $t0,$s0,$s1     # row * col
      mul   $t0,$t0, 4      # mult by 4 for bytes
    
      addu  $t0, $t0, 4     # this is to prevent execption holder
   
      move  $a0, $t0        # bytes of mem needed
      li    $v0, 9          # code 9 == allocate mem
      syscall 
    
      move  $s2, $v0        # make a safe copy
      move  $t5, $s2        # hold starting point in $t5

      # set up outter loop
      li    $t0, 0          # count = 0
      li    $t3, 1          # start number
  
  loopO:
     beq    $t0, $s0, exit  # if innerCount == Rows break     
     # set up inner loop
     li     $t1, 0
      loopI: 
         beq    $t1, $s1, outL  # if outterCount == Cols break     
         
         sw     $t3, ($t5)     # store the value of $t3 in the array
         addu   $t5, $t5, 4    # move to next position in the array
         addu  $t1, $t1, 1     # inner count ++
         b     loopI
         nop
  outL:

    addu  $t0, $t0, 1      # outter count ++ 
    addu  $t3, $t3, 1      # start number ++ 
    b      loopO 
    nop
            
    # terminate the program
    exit:
      li    $v0, 10         # code 10 == exit
      syscall

            .data
askRow:     .asciiz         "How many Rows is this image: "
askCol:     .asciiz         "How many Cols is this image: "
## end of program


