module arm_top(
    input logic clk, reset,
    output logic [31:0] WriteData, DataAdr,
    output logic MemWrite);

logic [31:0] PCNext, Instr, ReadData;
// instantiate processor and memories
logic [31:0] wdata, data_addr;

logic cpu_clk;
clock_div #(.DIV(4)) divider2(.clk_in(clk), .clk_out(cpu_clk));

arm arm(cpu_clk, reset, PCNext, Instr, MemWrite, data_addr,
wdata, ReadData);

wire [31:0] instr_addr; 

assign instr_addr = (reset)? 1'b0: PCNext;

instr_rom imem(
    .clk(clk),
    .r_addr_a(instr_addr),
    .r_addr_b(32'b0),
    .rd_a(Instr)
);
//dmem dmem(clk, MemWrite, data_addr, wdata, ReadData);

data_table_ram dmem(
    .clk(clk), 
    .we(MemWrite), 
    .addr(data_addr), 
    .wd(wdata), 
    .rd(ReadData)
);

assign DataAdr = data_addr;
assign WriteData = wdata;
endmodule