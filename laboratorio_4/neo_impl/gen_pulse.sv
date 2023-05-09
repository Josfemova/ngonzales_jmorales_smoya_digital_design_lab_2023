module gen_pulse(
	 input clk, reset,
    input btn, 
    output reg pulse);
	 //Memoria
    parameter N_BITS=2;
    reg[N_BITS - 1:0] state, next_state;
    parameter ESPERE_UNO = 2'b00, GENERE_PULSO = 2'b01, ESPERE_CERO=2'b10;

    always@(posedge clk) begin
        if(reset) state <= ESPERE_UNO;
        else state <= next_state;
    end 
    //logica siguiente estado
    always@(*) begin
        case(state)
            ESPERE_UNO: begin
                    if(btn == 0) next_state = ESPERE_UNO;  
                    else next_state = GENERE_PULSO;
                end 
            GENERE_PULSO: begin 
                    if(btn == 0) next_state = ESPERE_UNO;  
                    else next_state = ESPERE_CERO;
                end 
            ESPERE_CERO: begin 
                    if(btn == 0) next_state = ESPERE_UNO;  
                    else next_state = ESPERE_CERO;
                end 
        endcase
   end
    
   always@(*) begin
       if(state==GENERE_PULSO) pulse = 1;
       else pulse =0;
   end
endmodule
