module proyecto_cpu_top_tb();


logic clk_vga, clk,reset;
logic [31:0] vga_pixel_addr = 32'd65535;
logic  [7:0] vga_pixel_val;

clock_div #(.DIV(2)) divider2(.clk_in(clk), .clk_out(clk_vga));
// instantiate device to be tested
proyecto_cpu_top dut(
    .clk_vga(clk_vga), 
    .clk(clk), 
    .reset(reset),
    .vga_pixel_addr(vga_pixel_addr), 
    .vga_pixel_val(vga_pixel_val)
);

// initialize test
initial
begin
reset <= 1; #20; reset <= 0;
end
// generate clock to sequence tests
always
begin
clk <= 1; # 5; clk <= 0; # 5;
end

always @(negedge clk)
begin
if(vga_pixel_val == 8'b01000110) begin
        $display("Simulation succeeded");
        $stop;
end
end
endmodule