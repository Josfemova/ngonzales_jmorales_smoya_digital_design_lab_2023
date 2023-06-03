module controller(
    input logic clk, reset,
    input logic [31:12] Instr,
    input logic [3:0] ALUFlags,
    output logic [1:0] RegSrc,
    output logic RegWrite,
    output logic [1:0] ImmSrc,
    output logic ALUSrc,
    output logic [2:0] ALUControl,
    output logic MemWrite, MemtoReg,
    output logic PCSrc
);

logic [1:0] FlagW;
logic PCS, RegW, NoWrite, MemW;

decoder dec(
    .Op(Instr[27:26]), 
    .Funct(Instr[25:20]), 
    .Rd(Instr[15:12]),
    .FlagW(FlagW), 
    .PCS(PCS),
    .RegW(RegW),
    .NoWrite(NoWrite), 
    .MemW(MemW),
    .MemtoReg(MemtoReg), 
    .ALUSrc(ALUSrc), 
    .ImmSrc(ImmSrc), 
    .RegSrc(RegSrc), 
    .ALUControl(ALUControl)
);

condlogic cl(
    .clk(clk), 
    .reset(reset), 
    .Cond(Instr[31:28]), 
    .ALUFlags(ALUFlags),
    .FlagW(FlagW), 
    .PCS(PCS), 
    .RegW(RegW), 
    .NoWrite(NoWrite), 
    .MemW(MemW),
    .PCSrc(PCSrc), 
    .RegWrite(RegWrite), 
    .MemWrite(MemWrite)
);

endmodule