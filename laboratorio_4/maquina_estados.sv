module maquina_estados(
input logic rst,clk, btn_izq,btn_der,btn_up,btn_down,win,lose, start, fin,
output logic [3:0] estado_act,
output logic [2:0] mov,
output logic [11:0] cont);

typedef enum logic [3:0]{
	START, //0
	GEN,//1
	MERGE_MAT_1,//2
	WAIT,//3
	MOV,//4
	MERGE_MAT_2,//5
	UNIR,//6
	MERGE_MAT_3,//7
	FIN,//8
	CLEAN_1,//9
	CLEAN_2,//10
	CLEAN_3//11
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
			cont <= 0;
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
			sig_estado <= CLEAN_1;
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
			cont <= cont +1;
		end
		MERGE_MAT_2: //Copia la matriz de output en la de input
		begin
			sig_estado <= CLEAN_2;
		end
		UNIR: // Estado que suma los numeros iguales
		begin
			sig_estado <= MERGE_MAT_3;
		end
		MERGE_MAT_3: // Copia la matriz de output en la de input despues de unir
		begin
			sig_estado <= CLEAN_3;
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
		CLEAN_1:
		begin
			sig_estado <= WAIT;
		end
		CLEAN_2:
		begin
			sig_estado <= UNIR;
		end
		CLEAN_3:
		begin
			if(win ==1 || lose ==1)
			begin
				sig_estado <=FIN; 
			end
			else
			begin
				sig_estado <= GEN;
			end
		end
	endcase
	
	estado_act <= sig_estado;
end


endmodule