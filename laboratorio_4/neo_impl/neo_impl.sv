module neo_impl(
	input clk_50MHz,      
	input reset,    
	input [3:0] botones, 
	input [3:0] meta,
	
	//señales VGA
	output hsync, 
	output vsync,
	output [7:0] rgb_r,
	output [7:0] rgb_g,
	output [7:0] rgb_b,	
	output clk_vga,
	output sync,
	output blank,
	
	// 7 segmentos
	output logic [27:0] catodos
);

wire clk_25MHz, clk_juego;

pll_2048 pll(
		.refclk(clk_50MHz),   //  refclk.clk
		.rst(reset),      //   reset.reset
		.outclk_0(clk_25MHz), // outclk0.clk
		.outclk_1(0)  // outclk1.clk
	);
assign clk_juego = clk_25MHz;

//clock_div #(.DIV(2)) divider2(.clk_in(clk_50MHz), .clk_out(clk_25MHz));
//clock_div #(.DIV(2048)) dividerj(.clk_in(clk_50MHz), .clk_out(clk_juego));
assign clk_vga = clk_25MHz;

logic [3:0] gmatrix[0:3][0:3] = '{default:0}; // valor por casilla es potencia de 2
logic [11:0] score;
logic [1:0] draw_state;
logic [15:0] bcd;
logic [27:0] catodo_aux;
assign catodos = ~catodo_aux;
Bin2Bcd bcd_(.bin(score),.bcd(bcd));
catodo_control cat_(bcd[3:0], bcd[7:4], bcd[11:8],bcd[15:12],catodo_aux);

logic [3:0] btn_dir;

gen_pulse btn0(.clk(clk_juego), .reset(reset), .btn(~botones[0]), .pulse(btn_dir[0]));
gen_pulse btn1(.clk(clk_juego), .reset(reset), .btn(~botones[1]), .pulse(btn_dir[1]));
gen_pulse btn2(.clk(clk_juego), .reset(reset), .btn(~botones[2]), .pulse(btn_dir[2]));
gen_pulse btn3(.clk(clk_juego), .reset(reset), .btn(~botones[3]), .pulse(btn_dir[3]));

juego_neo jg(
    .clk(clk_juego), 
	.reset(reset), 
    .goal(meta),
    .dir(btn_dir),
    .gmatrix(gmatrix),
    .score(score),
	.draw_state(draw_state)
);

	wire video_on;
	wire [23:0] rgb_w;    
	reg [9:0] current_x = 0;
	reg [9:0] current_y = 0;
	reg [9:0] next_x, next_y;

    vga_driver vga_inst(
			.clk(clk_25MHz), 
			.reset(reset), 
			.hsync(hsync), 
			.vsync(vsync),
			.video_on(video_on), 
			.x(next_x), 
			.y(next_y), 
			.sync(sync), 
			.blank(blank));
	 
	 screen_drawer sd(
		 .x(current_x),
		 .y(current_y),
		 .gmatrix(gmatrix),
		 .draw_state(draw_state),
		 .rgb_color(rgb_w)
	 );
    
    always @(posedge clk_25MHz or posedge reset) begin
		if (reset) begin
			current_x <= 0;
			current_y <= 0;
		end else begin
			current_x <= next_x;
			current_y <= next_y;
		end
	 end
	 
    assign rgb_r = (video_on) ? rgb_w[23:16] : 8'b0; 
	 assign rgb_g = (video_on) ? rgb_w[15:8] : 8'b0; 
	 assign rgb_b = (video_on) ? rgb_w[7:0] : 8'b0; 


endmodule
