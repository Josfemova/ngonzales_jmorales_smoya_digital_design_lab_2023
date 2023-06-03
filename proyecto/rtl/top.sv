module top(input logic clk, reset,
output logic [31:0] WriteData, DataAdr,
output logic MemWrite);
logic [31:0] PC, Instr, ReadData;
// instantiate processor and memories

logic [31:0] wdata, data_addr;
arm arm(clk, reset, PC, Instr, MemWrite, data_addr,
wdata, ReadData);

imem imem(PC, Instr);
dmem dmem(clk, MemWrite, data_addr, wdata, ReadData);

assign DataAdr = data_addr;
assign WriteData = wdata;
endmodule