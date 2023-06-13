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
    loop: 
        ldr r3, [r0] 
        str r3, [r1]
        add r1, r1, #1
        add r0, r0, #1

    check_cond:
        cmp r0, r2
        blt loop
    
    _esperar_btn_carga:
        ldr r0, =__ctrl_val_2
        ldr r1, [r0]
        ldr r2, =flag_active
        ldr r3, [r2]
        cmp r1, r3 
        bne _esperar_btn_carga 

    // comenzar ecualización 
    ldr r0, =__image_r_start
    ldr r6, = __image_r_end
    _calc_frec:
        ldr r1, =__data_table_fi_start
        ldr r2, =zero
        ldr r2, [r2]
        b _buscar_valor
        _increm: //incrementa el contador en 1 y apunta a la siguiente direccion de memoria de fi
            add r2, r2, #1
            add r1, r1, #4
            b _buscar_valor
        _buscar_valor:
            ldr r4, [r0] //carga valor de image_r_start
            cmp r2,r4 //compara valor de pixel hasta encontrar columna correspondiente
            bne _increm
            ldr r5,[r1]
            add r3, r5, #1 //si encuentra el valor aumenta en 1 la frecuencia del valor del pixel 
            str r3,[r1] //almacena el valor en fi
            add r0, r0, #1 // apunta al proximo pixel 
            cmp r0, r6 // excluye el end porque es la dirección en la que comienza el siguiente pixel
            bne _calc_feq


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

    //bucle para crear la nueva I
    ldr r1, =__data_table_cuq_start
    ldr r2, =__data_table_I_prime_start
    ldr r6, = __data_table_I_prime_end
    // debo agregar b _calc_I_prima o sigue todo corrido ?
    _calc_I_prima: // se encarga de asingnar los nuevos valores para cada pixel en la tabla I_prima
        ldr r3, =zero // contador para poder indexar en i_prima
        ldr r3, [r3]
        ldr r0, =__data_table_cufeq_start
        _encontrar_cufeq:
            ldr r4, [r1]
            ldr r5, [r0]
            cmp r5,r4 //verifica que el valor tomado de cufeq sea mayor a cuq, si es así termina y guarda el valor de cufeq anterior
            bgt _agregar_feq
            add r3, r3, #1 // de no cumplirse la condicion sigue buscando el valor de cufeq adecuado
            add r0, r0,#4
            b _encontrar_cufeq
        _agregar_feq: // se encarga de agregar en I prima la posicion del valor de cufeq que se aproxima 
            str r3, [r2]
            add r2, r2, #4
            add r1, r1, #4
            cmp r2, r6
            bne _calc_I_prima

    ldr r0, =__image_r_start //carga direccion incial de imagen de input
    ldr r2, =__image_w_start //carga direccion inicial de imagen de output
    ldr r5, =__image_w_end
    _nueva_matriz:
        ldr r1, =__data_table_I_prime_start // carga direccion inicial la tabla I prima
        ldr r3, =zero //cont de indexacion que ayuda a llegar al valor de I prima que será agregado a la nueva matriz
        ldr r3, [r3]
        ldr r4, [r0] // carga el valor del pixel 
        _buscar_index: //se encarga de llegar a la posicion de la tabla I prima que contiene el valor de I para el pixel 
            cmp r3,r4
            bne _incrementar_cont 
            ldr r6, [r1]
            str r1, [r2] //almacena en el pixel de la nueva imagen el nuevo valor que tomará de la tabla I prima
            add r2, r2,#1 //carga el siguiente pixel
            add r0, r0,#1 //carga el siguiente pixel que se va a escribir
            cmp r2, r5 // compara si llego al final de la memoria. NOTA NO SÉ SI AL LLEGAR AQUI NO LEE EL ULTIMO PIXEL, VER CON JOSÉ
            bne _nueva_matriz 
        _incrementar_cont: // se encarga de incrementar el contador y la memoria
            add r3, r3, #1 //suma en uno el contador
            add r1,r1,#4 //mueve la direccion de memoria al inicio del proximo pixel
            b _buscar_index

            


    b .
    zero: .word 0
    flag_active: .word 1
    cte256: .word 256
    
