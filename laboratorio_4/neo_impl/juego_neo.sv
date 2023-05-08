module juego_neo(
    input clk, reset, 
    input [4:0] goal,
    input [3:0] dir, //codificado one-hot
    output reg [3:0] gmatrix[0:3][0:3], // valor por casilla es potencia de 2
    output reg [11:0] score,
    output logic [1:0] draw_state
);

initial begin 
    gmatrix = '{default:0};
end 

typedef enum logic [1:0]{
    DRAW_ACTIVE = 2'b00,
    DRAW_WIN = 2'b01,
    DRAW_LOSE = 2'b10
} draw_st;


typedef enum logic [3:0]{
    NONE = 4'b0000,
    IZQUIERDA = 4'b0001,
    ARRIBA = 4'b0010,
    ABAJO = 4'b0100,
    DERECHA = 4'b1000 
    // cualquier valor que no haga match se toma como NONE
} direccion;

typedef enum logic [3:0]{
	START,
    GEN, 
    DETRANS,
    SHOW_M, //matriz salida a detrans
    CHECK_WIN,
    CHECK_LOSE, // Pasa a wait
    WAIT_INPUT,
    DEBOUNCE,
    SHIFT,
    MERGE,
    WIN,
    LOSE         
} estado;

estado estado_act = START;
estado estado_sig; 
direccion last_dir;

reg [3:0] gmatrix_proxy[0:3][0:3];
reg [3:0] gmatrix_aux[0:3][0:3];
reg [3:0] shifted, merged;
reg [12:0] row_points [0:3]; // puntos por fila, se suman al final

wire [3:0] n2o4;
randn_gen #(.WIDTH(4), .OPTIONS(2)) randx(
    .clk(clk), 
    .reset(reset), 
    .options('{1,2}), 
    .number(n2o4));

wire [2:0] row;
randn_gen #(.WIDTH(3), .OPTIONS(4)) randrow(
    .clk(clk), 
    .reset(reset), 
    .options('{0,1,2,3}), 
    .number(row));

wire lose_condition;
wire [3:0] z0,z1,z2,z3,ma,mb,mc;
wire [3:0] win_condition;
wire [3:0] gmatrix_rot90der [0:3][0:3];
wire [3:0] gmatrix_rot90izq [0:3][0:3];
wire [3:0] gmatrix_h_flipped [0:3][0:3];

genvar i,j;
generate 
    for(i =0; i<4; i=i+1) begin : generate_checkers
        // detector de  zeros 
        // se usa en condiciones para shift y gen
        assign z0[i] = gmatrix_aux[i][0] == 0;
        assign z1[i] = gmatrix_aux[i][1] == 0;
        assign z2[i] = gmatrix_aux[i][2] == 0;
        assign z3[i] = gmatrix_aux[i][3] == 0;
        
        // condiciones para merge
        assign ma[i] = (~z0[i]) && (gmatrix_aux[i][0] == gmatrix_aux[i][1]);
        assign mb[i] = (~z2[i]) && (gmatrix_aux[i][2] == gmatrix_aux[i][3]);
        assign mc[i] = (~z1[i]) && (gmatrix_aux[i][1] == gmatrix_aux[i][2]);

        // detectores de 2048
        assign win_condition[i] = gmatrix_aux[i][0] == goal 
            || gmatrix_aux[i][1] == goal
            || gmatrix_aux[i][2] == goal
            || gmatrix_aux[i][3] == goal;

        for(j=0; j<4; j = j+1) begin : generate_matrices
            // rotacion -90° (hacia la derecha)
            assign gmatrix_rot90der[i][3-j] = gmatrix_proxy[j][i];
            // rotación de 180°
            assign gmatrix_h_flipped[i][j] = gmatrix_proxy[i][3-j];
            // rotacion +90° (hacia la izquierda)
            assign gmatrix_rot90izq[3-j][i] = gmatrix_proxy[i][j]; 
        end 
    end
endgenerate 

assign lose_condition = // primero vemos si ningun adyacente es igual
              ((gmatrix_aux[0][0] !== gmatrix_aux[0][1]) && (gmatrix_aux[0][0] !== gmatrix_aux[1][0]) 
            && (gmatrix_aux[0][1] !== gmatrix_aux[1][1]) && (gmatrix_aux[0][1] !== gmatrix_aux[0][2]) 
            && (gmatrix_aux[0][2] !== gmatrix_aux[1][2]) && (gmatrix_aux[0][2] !== gmatrix_aux[0][3]) 
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


// lógica de estados
always @(posedge clk) begin
    if (reset) begin
        estado_act <= START;
    end
    else begin
        case(estado_act)
            START: begin
                gmatrix <= '{default:0};
                gmatrix_proxy <= '{default:0};
                gmatrix_aux <= '{default:0};
                score <= 0;
                shifted <= 4'b1; //para que GEN genere algo
                last_dir <= IZQUIERDA;
                merged <= 4'b0; //no queremos sumar puntos
            end
            GEN: begin
                if((shifted != 4'b0) || (merged != 4'b0)) begin
                    if (merged != 4'b0) begin 
                        // actualizar puntaje
                        score <= score + row_points[0]  + row_points[1]  + row_points[2] + row_points[3];
                    end
                    // Cuando se llega a GEN sabemos que 
                    // NO se está en estado de pérdida
                    if (z0[row]) begin 
                        gmatrix_aux[row][0] <= n2o4;
                    end else if(z1[row]) begin 
                        gmatrix_aux[row][1] <= n2o4;
                    end else if(z2[row]) begin 
                        gmatrix_aux[row][2] <= n2o4;
                    end else if(z3[row]) begin 
                        gmatrix_aux[row][3] <= n2o4;
                    end else begin 
                        // Si no se encontró un 0 no se cambia de estado
                    end
                end else begin 
                end 
            end
            DETRANS: begin 
                // cambiar la matriz a la cual se le sacan todas las rotaciones
                gmatrix_proxy <= gmatrix_aux;
            end
            SHOW_M: begin 
                // selecciona la rotacion correcta dependiendo de la direccion
                // del ultimo movimiento
                case (last_dir)
                    ARRIBA   : begin
                        // se rotó antes 90 izq, ahora se rota alverez
                        gmatrix <= gmatrix_rot90der;
                        gmatrix_aux <= gmatrix_rot90der;
                     end
                    ABAJO    : begin
                        // se rotó antes 90 der, ahora se rota alverez
                        gmatrix <= gmatrix_rot90izq;
                        gmatrix_aux <= gmatrix_rot90izq;
                     end
                    DERECHA  : begin
                        gmatrix <= gmatrix_h_flipped;
                        gmatrix_aux <= gmatrix_h_flipped;
                     end
                    default: begin
                        // cubre caso de la izquierda
                        gmatrix <= gmatrix_proxy;
                        gmatrix_aux <= gmatrix_proxy;
                     end
                endcase
            end
            CHECK_WIN: begin
                if(win_condition != 0) begin
                end else begin
                end
                gmatrix_proxy <= gmatrix;
            end
            CHECK_LOSE: begin 
                if(lose_condition != 0) begin
                end else begin
                end
            end
            WAIT_INPUT: begin 
                // hasta recibir UNA sola direccion no cambia de estado
                case (dir)
                    IZQUIERDA: begin
                        last_dir <= IZQUIERDA;
                        gmatrix_aux <= gmatrix_proxy;
                     end
                    ARRIBA   : begin
                        last_dir <= ARRIBA;
                        gmatrix_aux <= gmatrix_rot90izq;
                     end
                    ABAJO    : begin
                        last_dir <= ABAJO;
                        gmatrix_aux <= gmatrix_rot90der;
                     end
                    DERECHA  : begin
                        last_dir <= DERECHA;
                        gmatrix_aux <= gmatrix_h_flipped;
                     end
                    default: begin
                        last_dir <= NONE;
                    end
                endcase
            end
            SHIFT: begin 
                // corre la matrix aux
                for(int i=0; i< 4; i = i+1) begin
                    if (z0[i]) begin
                        if(z1[i]) begin 
                            if(z2[i]) begin
                                //[0,0,0,x] 
                                gmatrix_aux[i][0] <= gmatrix_aux[i][3];
                                gmatrix_aux[i][3] <= 0;
                                if(z3[i]) shifted[i] <= 1'b0;
                                else shifted[i] <= 1'b1;
                            end else begin
                                //[0,0,2,x] 
                                gmatrix_aux[i][0] <= gmatrix_aux[i][2];
                                gmatrix_aux[i][1] <= gmatrix_aux[i][3];
                                gmatrix_aux[i][2] <= 0;
                                gmatrix_aux[i][3] <= 0;
                                shifted[i] <= 1'b1;
                            end
                        end else begin 
                            if(z2[i]) begin
                                //[0,2,0,x] 
                                gmatrix_aux[i][0] <= gmatrix_aux[i][1];
                                gmatrix_aux[i][1] <= gmatrix_aux[i][3];
                                gmatrix_aux[i][2] <= 0;
                                gmatrix_aux[i][3] <= 0;
                                shifted[i] <= 1'b1;
                            end else begin 
                                //[0,2,2,x]
                                gmatrix_aux[i][0] <= gmatrix_aux[i][1];
                                gmatrix_aux[i][1] <= gmatrix_aux[i][2];
                                gmatrix_aux[i][2] <= gmatrix_aux[i][3];
                                gmatrix_aux[i][3] <= 0;
                                shifted[i] <= 1'b1;
                            end
                        end
                    end else begin 
                        if(z1[i]) begin 
                            if(z2[i]) begin
                                //[2,0,0,x] 
                                gmatrix_aux[i][1] <= gmatrix_aux[i][3];
                                gmatrix_aux[i][3] <= 0;
                                if(z3[i]) shifted[i] <= 1'b0;
                                else shifted[i] <= 1'b1;
                            end else begin
                                //[2,0,2,x] 
                                gmatrix_aux[i][1] <= gmatrix_aux[i][2];
                                gmatrix_aux[i][2] <= gmatrix_aux[i][3];
                                gmatrix_aux[i][3] <= 0;
                                shifted[i] <= 1'b1;
                            end
                        end else begin 
                            if(z2[i]) begin
                                //[2,2,0,x] 
                                gmatrix_aux[i][2] <= gmatrix[i][3];
                                gmatrix_aux[i][3] <= 0;
                                if(z3[i]) shifted[i] <= 1'b0;
                                else shifted[i] <= 1'b1;
                            end else begin 
                                //[2,2,2,x]
                                shifted[i] <= 1'b0;
                            end
                        end
                    end 
                end
            end
            MERGE: begin 
                // ejecuta algoritmo de merge
                for(int i=0; i< 4; i = i+1) begin 
                     if (ma[i] == 1'b1) begin //condicion merge 0,1 
                        merged[i] <= 1'b1;
                        gmatrix_aux[i][0] <= gmatrix_aux[i][0] + 1;
                        gmatrix_aux[i][3] <= 0;
                        if (mb[i] == 1'b1) begin //condicion merge 2,3 
                            // [2,2,4,4]
                            row_points[i] <= 2;
                            gmatrix_aux[i][1] <= gmatrix_aux[i][2] + 1;
                            gmatrix_aux[i][2] <= 0;
                        end else begin
                            // [2,2,0,4]
                            // [2,2,8,4]
                            row_points[i] <= 1;
                            if (z2[i]) begin 
                                gmatrix_aux[i][1] <= gmatrix_aux[i][3];
                                gmatrix_aux[i][2] <= 0;
                            end else begin 
                                gmatrix_aux[i][1] <= gmatrix_aux[i][2];
                                gmatrix_aux[i][2] <= gmatrix_aux[i][3];
                            end
                        end
                     end else begin
                        if (mc[i] == 1'b1) begin //condicion merge 1,2 
                            // [4,2,2,4]
                            // [16,2,2,0]
                            merged[i] <= 1'b1;
                            row_points[i] <= 1;
                            gmatrix_aux[i][1] <= gmatrix_aux[i][1] + 1;
                            gmatrix_aux[i][2] <= gmatrix_aux[i][3];
                            gmatrix_aux[i][3] <= 0;
                        end else if (mb[i] == 1'b1) begin //condicion merge 2,3 
                            // [4,8,4,4]
                            merged[i] <= 1'b1;
                            row_points[i] <= 1;
                            gmatrix_aux[i][2] <= gmatrix_aux[i][2]+1;
                            gmatrix_aux[i][3] <= 0;
                        end else 
                            row_points[i] <= 0;
                            merged[i] <= 1'b0;
                     end
                end
            end
            WIN: begin 
                // no hay transición
            end 
            LOSE: begin 
                // no hay transición
            end 
            default: begin 
                // no hay transición
            end 
        endcase
        estado_act <= estado_sig;
    end
end

//logica estado siguiente
always_comb begin
        case(estado_act)
            START: estado_sig = GEN;
            GEN: begin
                if((shifted != 4'b0) || (merged != 4'b0)) begin
                    if(z0[row] || z1[row] || z2[row] || z3[row]) estado_sig = DETRANS;
                    else estado_sig = GEN;
                end else estado_sig = WAIT_INPUT;
            end
            DETRANS: estado_sig = SHOW_M;
            SHOW_M: estado_sig = CHECK_WIN;
            CHECK_WIN: begin 
                if(win_condition == 0) estado_sig = CHECK_LOSE;
                else estado_sig = WIN;
            end
            CHECK_LOSE: begin 
                if(lose_condition == 0) estado_sig = WAIT_INPUT;
                else estado_sig = LOSE;
            end
            WAIT_INPUT: begin 
                case (dir)
                    IZQUIERDA: estado_sig = DEBOUNCE;
                    ARRIBA   : estado_sig = DEBOUNCE;
                    ABAJO    : estado_sig = DEBOUNCE;
                    DERECHA  : estado_sig = DEBOUNCE;
                    default  : estado_sig = WAIT_INPUT;
                endcase
            end
            DEBOUNCE: begin 
                if(dir == 0) estado_sig = SHIFT;
                else estado_sig = DEBOUNCE;
            end 
            SHIFT:estado_sig = MERGE;
            MERGE:estado_sig = GEN;
            WIN:  estado_sig = WIN;
            LOSE: estado_sig = LOSE;
            default: estado_sig = START;
        endcase

end

//logica salida
always_comb begin
    case (estado_act)
        WIN: draw_state = DRAW_WIN;
        LOSE: draw_state = DRAW_LOSE;
        default: draw_state = DRAW_ACTIVE;
    endcase  
end

endmodule 