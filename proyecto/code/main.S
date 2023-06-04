.text
.global _start
_start:
    ldr r0, =__image_r_start
    ldr r1, =__image_w_start
    ldr r2, =__image_r_end
    b check_cond
    loop: 
        ldr r3, [r0] 
        str r3, [r1]
        add r1, r1, #1
        add r0, r0, #1

    check_cond:
        cmp r0, r2
        blt loop
    b .
    
