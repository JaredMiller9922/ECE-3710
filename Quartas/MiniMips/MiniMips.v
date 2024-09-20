// Top Level Module
module MiniMips #(parameter WIDTH = 8, REGBITS = 3, DATA_WIDTH = 8, ADDR_WIDTH = 8) (
	// CPU inputs and outputs
	input clk,                  // 50MHz clock
   input reset,                // active-low reset
	input [7:0] switches,
	output reg [7:0] leds
);

// Regs are values that need to store values
wire [7:0] adr; // Memory location to write to
wire [7:0] writedata; // Data that needs to be written
wire [(DATA_WIDTH-1):0] q; // Memory output from exmem or switches
wire memwrite; // Signal that tells us when we are doing a write
wire[7:0] mem_q; // The data from external memory
wire[1:0] addr_top_2 = adr[7:6]; // Top two bits of the memory address
wire mem_write_en; // Signal that says if we are writing to memory
wire io_write_en; // Signal that says we are writing to io

// Instantiate CPU 
mipscpu  #(.WIDTH(WIDTH), .REGBITS(REGBITS)) cpu (
	.clk(clk),
	.reset(reset),
	.memdata(q), // This will determined by the MUX it will either be from the switches or from the mem
	.adr(adr),
	.writedata(writedata),
	.memwrite(memwrite)
);

// Instantiate Memory
exmem #(.DATA_WIDTH(DATA_WIDTH), .ADDR_WIDTH(ADDR_WIDTH)) mem (
	.data(writedata),
	.addr(adr),
	.we(mem_write_en),
	.clk(~clk),
	.q(mem_q)
);

assign mem_write_en = memwrite && (addr_top_2 == 2'b00 || addr_top_2 == 2'b01 || addr_top_2 == 2'b10);
assign io_write_en = memwrite && (addr_top_2 == 2'b11);

assign q = (addr_top_2 == 2'b11) ? switches : mem_q; // Mux can be implemented using a simple lambda function

// Check your switches at the posedge of the clock
always @(posedge clk or negedge reset)
	begin
		if (!reset) // If we reset the circuit set led's to 0
			leds = 8'b0;
		else if (io_write_en)
			leds = writedata;
		else 
			leds = leds;
	
	end

endmodule