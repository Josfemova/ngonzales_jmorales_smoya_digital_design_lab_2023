module maquina_estados(
input logic rst,clk, btn_izq,btn_der,btn_up,btn_down,win,loose,check, start, fin,
output logic [3:0] estado_act);

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
logic [3:0] mov_save =0;
logic uni = 0;

initial estado_act = START;

/*always @(rst)
begin
	if (rst == 1)
		begin 
		 sig_estado <= START;
		end
end*/

always @(posedge clk)
begin
	if (rst == 1)
		begin 
		 sig_estado <= START;
		 uni <=0;
		 mov_save <=0;
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
		GEN2:
		begin
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
			mov_save <=MOV_IZQ;
			if(check ==0)
			begin
				sig_estado <= MOV_IZQ;
			end
			if(check ==1 && uni ==1)
			begin
				sig_estado <= GEN2;
			end
			else
			begin
				sig_estado <= UNIR;
			end
		end
		MOV_DER:
		begin
		mov_save <=MOV_DER;
			if(check ==0)
			begin
				sig_estado <= MOV_DER;
			end
			if(check ==1 && uni ==1)
			begin
				sig_estado <= GEN2;
			end
			else
			begin
				sig_estado <= UNIR;
			end
		end
		MOV_UP:
		begin
		mov_save <=MOV_UP;
			if(check ==0)
			begin
				sig_estado <= MOV_UP;
			end
			if(check ==1 && uni ==1)
			begin
				sig_estado <= GEN2;
			end
			else
			begin
				sig_estado <= UNIR;
			end
		end
		MOV_DOWN:
		begin
		mov_save <=MOV_DOWN;
			if(check ==0)
			begin
				sig_estado <= MOV_DOWN;
			end
			if(check ==1 && uni ==1)
			begin
				sig_estado <= GEN2;
			end
			else
			begin
				sig_estado <= UNIR;
			end
		end
		UNIR:
		begin
			uni <= 1;
			if(win ==1 || loose ==1)
			begin
				sig_estado <= FIN;
			end
			if(win ==0 && mov_save == MOV_IZQ)
			begin
				sig_estado <= MOV_IZQ;
			end
			if(win ==0 && mov_save == MOV_DER)
			begin
				sig_estado <= MOV_DER;
			end
			if(win ==0 && mov_save == MOV_UP)
			begin
				sig_estado <= MOV_UP;
			end
			if(win ==0 && mov_save == MOV_DOWN)
			begin
				sig_estado <= MOV_DOWN;
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
				mov_save <=0;
				uni <= 0;
			end
		end
	endcase
	
	estado_act <= sig_estado;
end


endmodule