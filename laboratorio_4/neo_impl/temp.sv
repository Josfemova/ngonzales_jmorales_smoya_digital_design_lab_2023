assign lose_condition = // primero vemos si ningun adyacente es igual
              ((gmatrix_aux[0][0] !== gmatrix_aux[0][1]) && (gmatrix_aux[0][0] !== gmatrix_aux[1][0]) 
            && (gmatrix_aux[0][1] !== gmatrix_aux[1][1]) && (gmatrix_aux[0][1] !== gmatrix_aux[0][2]) 
            && (gmatrix_aux[0][2] !== gmatrix_aux[1][3]) && (gmatrix_aux[0][2] !== gmatrix_aux[0][3]) 
            && (gmatrix_aux[0][3] !== gmatrix_aux[1][3]) && (gmatrix_aux[1][0] !== gmatrix_aux[1][1]) 
            && (gmatrix_aux[1][0] !== gmatrix_aux[2][0]) && (gmatrix_aux[1][1] !== gmatrix_aux[1][2]) 
            && (gmatrix_aux[1][1] !== gmatrix_aux[2][1]) && (gmatrix_aux[1][2] !== gmatrix_aux[1][3]) 
            && (gmatrix_aux[1][2] !== gmatrix_aux[2][2]) && (gmatrix_aux[1][3] !== gmatrix_aux[2][3]) 
            && (gmatrix_aux[2][0] !== gmatrix_aux[2][1]) && (gmatrix_aux[2][0] !== gmatrix_aux[3][0]) 
            && (gmatrix_aux[2][1] !== gmatrix_aux[2][2]) && (gmatrix_aux[2][1] !== gmatrix_aux[3][1]) 
            && (gmatrix_aux[2][2] !== gmatrix_aux[2][3]) && (gmatrix_aux[2][2] !== gmatrix_aux[3][2]) 
            && (gmatrix_aux[2][3] !== gmatrix_aux[3][3]) && (gmatrix_aux[3][0] !== gmatrix_aux[3][1]) 
            && (gmatrix_aux[3][1] !== gmatrix_aux[3][2]) && (gmatrix_aux[3][2] !== gmatrix_aux[3][3])
            // y luego si ningun valor es 0
            && (gmatrix_aux[0][0] !== 0) && (gmatrix_aux[0][1] !== 0) && (gmatrix_aux[0][2] !== 0) 
            && (gmatrix_aux[0][3] !== 0) && (gmatrix_aux[1][0] !== 0) && (gmatrix_aux[1][1] !== 0)
            && (gmatrix_aux[1][2] !== 0) && (gmatrix_aux[1][3] !== 0) && (gmatrix_aux[2][0] !== 0) 
            && (gmatrix_aux[2][1] !== 0) && (gmatrix_aux[2][2] !== 0) && (gmatrix_aux[2][3] !== 0) 
            && (gmatrix_aux[3][0] !== 0) && (gmatrix_aux[3][1] !== 0) && (gmatrix_aux[3][2] !== 0)
            && (gmatrix_aux[3][3] !== 0));