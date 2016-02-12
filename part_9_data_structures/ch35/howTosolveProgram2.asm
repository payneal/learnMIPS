.text
.globl main


main: 

 li $v0, 4
 la $a0, enter
 syscall 

 li $v0, 8 
 syscall

move $t0, $a0  

li  $v0, 9 
li  $a0, 200
syscall

sw $t0,0($v0)

sw $v0, test

move $t8, $v0

 li $v0, 4
 la $a0, you
 syscall 

lw $a0, test
lw $a0, ($a0)
li $v0, 4
syscall

lw $a0, test
li $v0, 4
syscall

lw  $a0, newL
li  $v0, 4 # print char
syscall


lw  $a0,0($t0) 
li  $v0, 4 # print char
syscall


lw  $a0, newL
li  $v0, 4 # print char
syscall


lw  $a0,($t8) 
li  $v0, 1 # print char
syscall


        .data
enter:  .asciiz     "enter a string: "
you:    .asciiz     "you entered the following: "
newL:   .asciiz     "\n"
test:   .word      0 

# end of main
