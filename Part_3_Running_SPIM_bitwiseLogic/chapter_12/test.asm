    .text
    .globl main

main:
        
        #ori $8, $0, 0x6F        # put bit pattern into reg $8
       # sll $9, $8, 2           # shift left logical by two

    # http://stackoverflow.com/questions/24542657/translating-a-mips-pseudo-instruction-rol

# trying to understand how a rol works 

ori $1,$0, 0xDEAD
sll $1,$1, 16     
ori $1, $1, 0xBEEF

srl 
ssl
or 

## End of file


