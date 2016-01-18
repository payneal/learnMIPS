## progrAM TO ADD TWO PLUS THREE
    .text
    .globl main

main:
        ori     $8, $0, 0x2                 #put two's comp. of 2 into register 8
        ori     $9, $0, 0x3                 #put 2's comp. of 3 into register 9
        addu    $10, $8, $9                 # add register 8 and 9, put result in 10

## End of file

