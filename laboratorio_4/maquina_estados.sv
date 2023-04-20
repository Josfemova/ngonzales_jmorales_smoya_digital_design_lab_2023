module maquina_estados(
input logic rst,clk, btn_izq,btn_der,btn_up,btn_down,win,loose,check, start, fin,
output logic [3:0] estado_act,
output logic [3:0] i, i_1, j, j_1);

typedef enum logic [3:0]{
	START,
	GEN1,
	GEN2,
	MOV_DER,
	MOV_IZQ,
	MOV_UP,
	MOV_DOWN,
	UNIR,
	FIN
} estado;

estado sig_estado=START;

initial 
begin
estado_act = START;

i =0;
i_1=0;
j=0;
j_1=0;

end


always @(posedge clk)
begin
	if (rst == 1)
		begin 
		 sig_estado <= START;
		end
	case(estado_act)
		START: begin
			if(start ==1)
			begin
				sig_estado <= GEN1;
			end
			else
			begin
				sig_estado <= START;
			end
		end
		GEN1:
		begin
			sig_estado <= GEN2;
		end
		GEN2: //modificar cuando espera una señal
		begin
			i <=0;
			i_1 <=1;
			j <= 3;
			j_1 <=2;
			if(btn_izq == 1)
			begin
				sig_estado <= MOV_IZQ; 
			end
			if(btn_der == 1)
			begin
				sig_estado <= MOV_DER; 
			end
			if(btn_up == 1)
			begin
				sig_estado <= MOV_UP; 
			end
			if(btn_down == 1)
			begin
				sig_estado <= MOV_DOWN; 
			end
		end
		MOV_IZQ:
		begin
			if(check ==0)
			begin
				i <= i+1;
				i_1 <= i_1+1;
				sig_estado <= MOV_IZQ;
			end
			else
			begin
				sig_estado <= UNIR;
			end
		end
		MOV_DER:
		begin
			if(check ==0)
			begin
				j <= j-1;
				j_1 <= j_1-1;
				sig_estado <= MOV_DER;
			end
			else
			begin
				sig_estado <= UNIR;
			end
		end
		MOV_UP:
		begin
			if(check ==0)
			begin
				i <= i+1;
				i_1 <= i_1+1;
				sig_estado <= MOV_UP;
			end
			else
			begin
				sig_estado <= UNIR;
			end
		end
		MOV_DOWN:
		begin
			if(check ==0)
			begin
				j <= j-1;
				j_1 <= j_1-1;
				sig_estado <= MOV_DOWN;
			end
			else
			begin
				sig_estado <= UNIR;
			end
		end
		UNIR:
		begin
			if(win ==1 || loose ==1)
			begin
				sig_estado <= FIN;
			end
			else
			begin
				sig_estado <= GEN2;
			end
		end
		FIN:
		begin
			if(fin ==0)
			begin
				sig_estado <= FIN;
			end
			else
			begin
				sig_estado <= START;
			end
		end
	endcase
	
	estado_act <= sig_estado;
end


endmodule