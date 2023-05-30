.text
.global _start
_start:
    ldr r1, =__data_table_start
    ldr r2, =0xfff
    str r2, [r1]
    b .
    
