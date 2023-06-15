module chipset_4regions
#(parameter REGION1_BASE=32'h00000, REGION2_BASE=32'h10000, REGION3_BASE=32'h20000, REGION4_BASE=32'h30000, REGION5_BASE=32'h40000)
(
    input we, 
    input [31:0] addr, wd,
    input [31:0] rd1, rd2, rd3, rd4, 
    input [31:0] ctrl_val_1,
    input [31:0] ctrl_val_2,
    input [31:0] ctrl_val_3,
    output logic we1, we2, we3, we4,
    output logic [31:0] addr1, addr2, addr3, addr4,
    output logic [31:0] wd1, wd2, wd3, wd4,
    output logic [31:0] rd
);
always @(*) begin 
    if(addr >= REGION1_BASE && addr < REGION2_BASE) begin 
        we1 = we;
        we2 = 1'b0;
        we3 = 1'b0;
        we4 = 1'b0;
        addr1 = (addr - REGION1_BASE);
        addr2 = 1'b0;
        addr3 = 1'b0;
        addr4 = 1'b0;
        wd1 = wd;
        wd2 = 1'b0;
        wd3 = 1'b0;
        wd4 = 1'b0;
        rd = rd1;
    end 
    else 
    if(addr >= REGION2_BASE && addr < REGION3_BASE) begin 
        we1 = 1'b0;
        we2 = we;
        we3 = 1'b0;
        we4 = 1'b0;
        addr1 = 1'b0;
        addr2 = (addr - REGION2_BASE);
        addr3 = 1'b0;
        addr4 = 1'b0;
        wd1 = 1'b0;
        wd2 = wd;
        wd3 = 1'b0;
        wd4 = 1'b0;
        rd = rd2;
    end 
    else 
    if(addr >= REGION3_BASE && addr < REGION4_BASE) begin 
        we1 = 1'b0;
        we2 = 1'b0;
        we3 = we;
        we4 = 1'b0;
        addr1 = 1'b0;
        addr2 = 1'b0;
        addr3 = (addr - REGION3_BASE);
        addr4 = 1'b0;
        wd1 = 1'b0;
        wd2 = 1'b0;
        wd3 = wd;
        wd4 = 1'b0;
        rd = rd3;
    end 
    else 
    if(addr >= REGION4_BASE && addr < REGION5_BASE) begin 
        we1 = 1'b0;
        we2 = 1'b0;
        we3 = 1'b0;
        we4 = we;
        addr1 = 1'b0;
        addr2 = 1'b0;
        addr3 = 1'b0;
        addr4 = (addr - REGION4_BASE);
        wd1 = 1'b0;
        wd2 = 1'b0;
        wd3 = 1'b0;
        wd4 = wd;
        rd = rd4;
    end 
    else begin 
        we1 = 1'b0;
        we2 = 1'b0;
        we3 = 1'b0;
        we4 = 1'b0;
        addr1 = 1'b0;
        addr2 = 1'b0;
        addr3 = 1'b0;
        addr4 = 1'b0;
        wd1 = 1'b0;
        wd2 = 1'b0;
        wd3 = 1'b0;
        wd4 = 1'b0;
        // control signal registers (external control)
        // ctrl_reg 1
        if(addr == (REGION5_BASE + 32'h0)) rd = ctrl_val_1;
        // ctrl_reg 2
        else if(addr == (REGION5_BASE + 32'h4)) rd = ctrl_val_2;
        // ctrl_reg 3
        else if(addr == (REGION5_BASE + 32'h8)) rd = ctrl_val_3;
        else rd = 1'b0;
    end 
end

endmodule