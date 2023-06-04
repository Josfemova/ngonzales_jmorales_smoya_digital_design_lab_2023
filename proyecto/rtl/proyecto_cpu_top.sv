module proyecto_cpu_top(
    input clk_vga, clk, reset,
    input [31:0] vga_pixel_addr,
    output [7:0] vga_pixel_val
);

logic [31:0] PCNext, Instr, ReadData;
// instantiate processor and memories
logic [31:0] wdata, data_addr;
logic MemWrite;

logic cpu_clk;
clock_div #(.DIV(4)) divider2(.clk_in(clk), .clk_out(cpu_clk));

wire [31:0] instr_addr; 
assign instr_addr = (reset)? 1'b0: PCNext;

arm arm(
    .clk(cpu_clk), 
    .reset(reset), 
    .PCNext(PCNext), 
    .Instr(Instr),
    .MemWrite(MemWrite), 
    .ALUResult(data_addr),
    .WriteData(wdata), 
    .ReadData(ReadData)
);

logic [31:0] rd1, rd2, rd3, rd4;
logic we1, we2, we3, we4;
logic [31:0] addr1, addr2, addr3, addr4;
logic [31:0] wd1, wd2, wd3, wd4;
logic [31:0] rd;

chipset_4regions chipsetx( 
    .we(MemWrite),
    .addr(data_addr),
    .wd(wdata),
    .rd1(rd1), .rd2(rd2), .rd3(rd3), .rd4(rd4),
    .we1(we1), .we2(we2), .we3(we3), .we4(we4),
    .addr1(addr1), .addr2(addr2), .addr3(addr3), .addr4(addr4), 
    .wd1(wd1), .wd2(wd2), .wd3(wd3), .wd4(wd4),
    .rd(ReadData)
);

/*
 * Las memorias de datos tienen que ir a un clock más rápido porque el procesador uniciclo  
 * espera una memoria asincrónica, sin embargo esto impediría aprovechar los bloques de 
 * memoria en la FPGA. La ilusión de que los cambios se vean casi inmediatos desde la perspectiva
 * del cpu se logra solo haciendo que el cpu vaya más lento.  
*/

logic[7:0] image_rom_rd_aux;

instr_rom imem(
    .clk_a(cpu_clk),
    .clk_b(clk),
    .r_addr_a(instr_addr),
    .r_addr_b(addr1),
    .rd_a(Instr),
    .rd_b(rd1)
);

image_rom image_mem(
    .clk(clk),
    .r_addr(addr2),
    .rd(image_rom_rd_aux)
);

assign rd2 = {24'b0, image_rom_rd_aux};

data_table_ram dmem(
    .clk(clk), 
    .we(we3), 
    .addr(addr3), 
    .wd(wd3), 
    .rd(rd3)
);

vga_framebuffer_ram vga_ram(
    .we(we4),
    .r_clk(clk_vga),
    .w_clk(clk),
    .wd(wd4[7:0]),
    .r_addr(vga_pixel_addr),
    .w_addr(addr4),
    .rd(vga_pixel_val)
);

endmodule