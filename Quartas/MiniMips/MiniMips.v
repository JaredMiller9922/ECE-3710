// Top Level Module
module MiniMips #(parameter WIDTH = 8, REGBITS = 3, DATA_WIDTH = 8, ADDR_WIDTH = 8) (
	// CPU inputs and outputs
	input clk,                  // 50MHz clock
   input reset,                // active-low reset
	input [7:0] switches,
	output [7:0] leds
);


wire [7:0] adr;			 			// Memory location to write to
wire [7:0] writedata; 	 			// Data to be written
wire [7:0] data;						// Data the processor takes in
wire [7:0] mem_data;					// The data returned from external memory
wire [7:0] fib_address;				// Register to compute what fibonacci number we want to see 

wire memwrite_en; 					// High if we are writing to memory
wire io_space;							// High if we are in the 'IO space'
wire led_write_en;					// High if we should write to the leds
wire clkbar;							// Inverted clock

// Instantiate CPU 
mipscpu  #(.WIDTH(WIDTH), .REGBITS(REGBITS)) cpu (
	.clk(clk),
	.reset(reset),
	.memdata(data),
	.adr(adr),
	.writedata(writedata),
	.memwrite(memwrite_en)
);

// Instantiate Memory
exmem #(.DATA_WIDTH(DATA_WIDTH), .ADDR_WIDTH(ADDR_WIDTH)) mem (
	.data(writedata),
	.addr(adr),
	.we(memwrite_en),
	.clk(clkbar),
	.q(mem_data)
);

assign clkbar = ~clk;
assign io_space = adr[7] & adr[6];
assign led_write_en = (io_space && memwrite_en);

flopenr flop (clkbar, reset, led_write_en, writedata, leds);
mux2 mux(mem_data, switches, io_space, data);

endmodule