    .text
    .globl main

main:
    
    ori $7, $0, 146
    ori $8, $0, 82
    nor $8, $8, $0
    ori $9, $0, 1
    addu $8, $8, $9
    addu $10, $7, $8


## end of file
