module data_table_ram #(parameter WIDTH=32, LENGTH=256*8)
( 
    input clk, we, 
    input [(WIDTH-1):0] addr,
    input [(WIDTH-1):0] wd,
    output reg [(WIDTH-1):0] rd
);
    reg [(WIDTH-1):0] mem [(LENGTH-1):0];

    always @ (posedge clk) begin
        rd <= mem[addr[WIDTH-1:2]]; 
        if (we) mem[addr[WIDTH-1:2]] <= wd;
    end
endmodule
