.text
.global _start
_start:
    
    // limpiar ram de datos al resetear
    ldr r0, =__data_table_start
    ldr r1, =__data_table_end
    ldr r2, =zero
    ldr r3, [r2]
    b check_clean_dt
    clean_loop_dt:
        str r3, [r0]
        add r0, r0, #1
    check_clean_dt:
        cmp r0, r1
        bne clean_loop_dt 
    
    // limpiar ram de video al resetear
    ldr r0, =__image_w_start 
    ldr r1, =__image_w_end
    ldr r2, =zero
    ldr r3, [r2]
    b check_clean_vga
    clean_loop_vga:
        str r3, [r0]
        add r0, r0, #1
    check_clean_vga:
        cmp r0, r1
        bne clean_loop_vga 

    // no empezar hasta tener el boton 0 activo
    check_boton_1:
        ldr r0, =__ctrl_val_1
        ldr r1, [r0]
        ldr r2, =flag_active
        ldr r3, [r2]
        cmp r1, r3 
        bne check_boton_1 

    // copiar imagen original de rom a la ram de video
    ldr r0, =__image_r_start
    ldr r1, =__image_w_start
    ldr r2, =__image_r_end
    b check_cond
    cpy_loop: 
        ldr r3, [r0] 
        str r3, [r1]
        add r1, r1, #1
        add r0, r0, #1

    check_cond:
        cmp r0, r2
        blt cpy_loop
   
    _esperar_btn_carga:
        ldr r0, =__ctrl_val_2
        ldr r1, [r0]
        ldr r2, =flag_active
        ldr r3, [r2]
        cmp r1, r3 
        bne _esperar_btn_carga    


    // comenzar ecualización 

    /* Calcular tabla de frecuencia de pixeles */
    ldr r0, =__image_r_start
    ldr r1, =__image_r_end
    ldr r3, =__data_table_fi_start
    loop_frec:
        ldr r4, [r0] //cargar valor de pixel
        add r4, r4, r4 //multiplicar *2
        add r4, r4, r4 //multiplicar *4
        add r5, r3, r4 //r5 almacena direccion de columna correspondiente a valor actual
        ldr r6, [r5] //cargar valor actual de columna
        add r6, r6, #1 //agregarle 1
        str r6, [r5] //cargar nuevo valor a columna
        add r0, r0, #1 //avanzar puntero de imagen
    comp_frec:
        cmp r0, r1
        bne loop_frec


    // calculo de fila de frecuencia acumulada 
    // se carga el valor inicial de la frecuencia
    ldr r0, =__data_table_cuq_start
    ldr r1, = __data_table_fi_start
    ldr r2, [r1] 
    str r2, [r0] //asigna el primer elemento de la tabla cuq
    ldr r6, =__data_table_cuq_end

    //comienza el bucle para el calculo de la frecuencia acumulada 
    _dist_acum:
        ldr r3, [r0] // se lee el valor de la cuq
        add r0, r0, #4 // se apunta al proximo valor de la tabla cuq
        add r1, r1, #4 // se apunta al siguiente valor de la tabla fi
        ldr r5, [r1]
        add r4, r3, r5  //se suma el valor de fi mas el valor cuq actual
        str r4, [r0] // se guarda el nuevo valor de cuq 
        cmp r0,r6 // se compara si se llegó al final de la memoria. NOTA PREGUNTAR A JOSÉ SI TOMA EN CUENTA EL VALOR DEL ULTIMO OBJETO DE LA LISTA
        bne _dist_acum

    ldr r5, =cte256 // como se restringe la ecualizacion a una imagen de 256x256, la frecuencia acumulada siempre será de 65536, al dividir por 256, se obtiene 256, por lo que se decide manejarlo como constante
    ldr r5, [r5]
    ldr r0, =__data_table_feq_start
    ldr r6, = __data_table_feq_end
    _calc_feq: //bucle que asigna los valores promedio a la tabla feq
        str r5, [r0] //se almacena el valor de 256 en la posición de memoria apuntada
        add r0,r0,#4
        cmp r0, r6
        bne _calc_feq

    // Calculo de Cufeq normalizada
    //El proceso es exactamente el mismo que para cuq
    ldr r0, =__data_table_cufeq_start
    ldr r1, = __data_table_feq_start
    ldr r2, [r1]
    str r2, [r0] //carga 1er valor de feq en cufeq
    ldr r6, =__data_table_cufeq_end

    //comienza el bucle para el calculo de Cufeq 
    _bucle_cufeq:
        ldr r3, [r0] // carga valor de cufeq
        add r0, r0, #4 //mueve puntero cufeq 
        add r1, r1, #4 //mueve puntero feq
        ldr r5, [r1] //carga valor de feq
        add r4, r3, r5 //cufeq anterior + feq actual
        str r4, [r0] 
        cmp r0, r6
        bne _bucle_cufeq

    /* Calcular I prima */
    ldr r0, =__data_table_cuq_start // Tabla de Cuf
    ldr r1, =__data_table_cuq_end // Tabla de Cuf
    ldr r2, =__data_table_I_prime_start // Tabla I prima 
    ldr r11, =__data_table_cufeq_end
    loop_calc_iprima:
        ldr r3, =zero
        ldr r3, [r3] // i_prima
        ldr r4, [r3] // i_prima_prev
        ldr r5, [r3] // diff_actual
        ldr r6, [r0] // diff_prev, inicialment valor de cuf[i]
        ldr r7, =__data_table_cufeq_start //puntero cufeq
        ldr r8, [r0] //cargar valor de cuf a comparar
        
        loop_encontrar_cufeq:
            ldr r9, [r7] //cargar valor de cufeq
            cmp r9, r8 //cufeq >= cuf
            bhs diff_case2
            diff_case1:
                sub r5, r8, r9
                b diff_end
            diff_case2:
                sub r5, r9, r8
            diff_end:
            cmp r5, r6 // diff_actual > diff_prev
            bhs guardar_iprima_prev
            add r6, r5, #0 // diff_prev = diff_actual
            add r4, r3, #0 // i_prima_prev = i_prima
            add r7, r7, #4 // mover puntero de cufeq
            cmp r7, r11 // ver si no se llegó al final de cufeq
            bne aumentar_i_prima
            b guardar_iprima
            aumentar_i_prima:
                add r3, r3, #1 // i_prima ++
                b loop_encontrar_cufeq
        guardar_iprima_prev:
            add r3, r4, #0 // i_prima=i_prima_prev
        guardar_iprima:
            str r3, [r2]
        add r0, r0, #4 //mover puntero cuf 1 pixel
        add r2, r2, #4 //mover puntero de tabla I prima 1 pixel
    cmp_iprima:
        cmp r0, r1
        bne loop_calc_iprima
    
    /* Cargar imagen con valores cambiados a memoria de video */
    /* Nota: indice de tabla corresponde a valor de pixel viejo */
    ldr r0, =__image_r_start
    ldr r1, =__image_r_end
    ldr r2, =__image_w_start
    ldr r3, =__data_table_I_prime_start
    loop_reemplazo:
        ldr r4, [r0] // cargar valor de pixel viejo
        add r4, r4, r4 //multiplicar *2
        add r4, r4, r4 //multiplicar *4
        add r5, r3, r4 // calcular direccion de columna de I prima
        ldr r5, [r5] // cargar nuevo valor de pixel
        str r5, [r2] // esribir nuevo valor de pixel
        add r0, r0, #1 //avanzar puntero de imagen leída
        add r2, r2, #1 //avanzar puntero de imagen a escribir
    cmp_reemplazo:
        cmp r0, r1
        bne loop_reemplazo

    __fin_programa:
    b __fin_programa
    zero: .word 0
    flag_active: .word 1
    cte256: .word 256
    
