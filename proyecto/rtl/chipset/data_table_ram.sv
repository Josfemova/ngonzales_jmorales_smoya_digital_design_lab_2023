module data_table_ram #(parameter WIDTH=32, LENGTH=256*8)
( 
    output reg [(WIDTH-1):0] rdata,
    input [(WIDTH-1):0] wdata,
    input [(WIDTH-1):0] write_address, read_address,
    input we, clk
);
    reg [(WIDTH-1):0] mem [(LENGTH-1):0];

    always @ (posedge clk) begin
        if (we)
            mem[write_address] <= wdata;
				rdata <= mem[read_address]; 
    end
endmodule