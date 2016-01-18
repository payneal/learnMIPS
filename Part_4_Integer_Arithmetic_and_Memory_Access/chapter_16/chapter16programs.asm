            .data
            .byte   12
            .byte   97
            .byte   133
            .byte   82
            .byte   236
            .byte   0 

            .text
            .globl main

main: 
    
            lui     $10, 0x1000        # Init base register 
            
            lbu     $11,0($10)        # load byte 12 into $11
            lbu     $12,1($10)        # load byte 97 into $12
            lbu     $13,2($10)        # load byte 133 into $13
            lbu     $14,3($10)        # load byte 82 into $14
            lbu     $15,4($10)        # load byte 236 into $15

            addu    $11, $12, $11     # $11 = 12 + 97
            addu    $11, $13, $11     # $11 = 109 + 133
            addu    $11, $14, $11     # $11 = 242 + 82
            addu    $11, $15, $11     # $11 324 + 236
            
            # $11 = 560

            ori     $1, $0, 5         # put division number in $1 = 5 
            
            div     $11, $1           # 560 / 5 
            mflo    $1                # put answer in $1
            
            # answer should be 122

            sb      $1,5($10)         #store 122 at hold
            
            lbu     $2,5($10)         # load 122 to make sure save worked

            ori     $1, $0, 0         # bs step
            ori     $1, $0, 0         # bs step
    
## End of File
