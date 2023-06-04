.text
.global _start
_start:
    // limpiar ram de video al resetear
    ldr r0, =__image_w_start 
    ldr r1, =__image_w_end
    ldr r2, =zero
    ldr r3, [r2]
    b check_clean
    clean_loop:
        str r3, [r0]
        add r0, r0, #1
    check_clean:
        cmp r0, r1
        bne clean_loop 
    // no empezar hasta tener el boton 0 activo
    ldr r0, =__ctrl_val_1
    ldr r1, [r0]
    ldr r2, =flag_active
    ldr r3, [r2]
    cmp r1, r3 
    bne _start 
    // copiar imagen original de rom a la ram de video
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
    zero: .word 0
    flag_active: .word 1
    
