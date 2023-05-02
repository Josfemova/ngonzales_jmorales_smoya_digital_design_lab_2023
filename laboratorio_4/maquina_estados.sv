module maquina_estados(
input logic rst,clk, btn_izq,btn_der,btn_up,btn_down,win,lose, start, fin,
output logic [3:0] estado_act,
output logic [2:0] mov);

typedef enum logic [3:0]{
	START, 
	GEN,
	MERGE_MAT_1,
	WAIT,
	MOV,
	MERGE_MAT_2,
	UNIR,
	MERGE_MAT_3,
	FIN
} estado;

estado sig_estado= START;

initial 
begin
estado_act = START;
end


always @(posedge clk)
begin
	if (rst == 1)
		begin 
		 sig_estado <= START;
		end
	case(estado_act)
		START: 
		begin// estado de inicio, espera hasta que haya una señal de comienzo 
			mov <= 3'b000;
			if(start ==1)
			begin
				sig_estado <= GEN;
			end
			else
			begin
				sig_estado <= START;
			end
		end
		GEN: // genera un numero random a la matriz
		begin
			sig_estado <= MERGE_MAT_1;
		end
		MERGE_MAT_1:
		begin
			sig_estado <= WAIT;
		end
		WAIT: // En este estado se espera hasta recibir una señal de movimiento
		begin
			if(btn_izq == 1)
			begin
				sig_estado <= MOV;
				mov <= 3'b001;
			end
			else if(btn_der == 1)
			begin
				sig_estado <= MOV;
				mov <= 3'b010;
			end
			else if(btn_up == 1)
			begin
				sig_estado <= MOV;
				mov <= 3'b011;
			end
			else if(btn_down == 1)
			begin
				sig_estado <= MOV;
				mov <= 3'b100;
			end
			else
			begin
				sig_estado <= WAIT;
			end
		end
		MOV:
		begin
			sig_estado <= MERGE_MAT_2;
		end
		MERGE_MAT_2: //Copia la matriz de output en la de input
		begin
			sig_estado <= UNIR;
		end
		UNIR: // Estado que suma los numeros iguales
		begin
			sig_estado <= MERGE_MAT_3;
		end
		MERGE_MAT_3: // Copia la matriz de output en la de input despues de unir
		begin
			if(win ==0 || lose ==0)
			begin
				sig_estado <=FIN; 
			end
			else
			begin
				sig_estado <= GEN;
			end
		end
		FIN: // Estado de fin, no pasa al siguiente a menos de una señal
		begin
			if(fin ==0)
			begin
				sig_estado <= FIN;
			end
			else
			begin
				sig_estado <= START;
				mov = 3'b000;
			end
		end
	endcase
	
	estado_act <= sig_estado;
end


endmodule