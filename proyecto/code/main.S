.global str1
str1: .word 0xDEADBEEF 

.text
.global _start
_start:
    ldr r1, str1
    b .
    
