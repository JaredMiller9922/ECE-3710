// Quartus Prime Verilog Template
// Single port RAM with single read/write address 

module exmem #(parameter DATA_WIDTH=8, parameter ADDR_WIDTH=8)
   (
		input [(DATA_WIDTH-1):0] data,
		input [(ADDR_WIDTH-1):0] addr,
		input                    we, clk,
		output [(DATA_WIDTH-1):0] q
   );

	// Declare the RAM variable
	reg [DATA_WIDTH-1:0] ram[2**ADDR_WIDTH-1:0];

	// Variable to hold the read address
	reg [ADDR_WIDTH-1:0] addr_reg;
	
	// Use an integer to loop through the memory and display the contents
	integer i;

        // The $readmemb function allows you to load the
        // RAM with data on initialization to the FPGA
        // you'll need to update the path to this file
        // for your own location. 
	initial begin
		$display("Loading memory");
		$readmemb("C:/Users/jared/Desktop/Fall 2024/ECE-3710/Quartas/MiniMips/new_fib.dat", ram);
		$display("done loading");
		
		/*
		for (i = 0; i < 32; i = i + 1) begin
			$display("Memory[%0d] = %b", i, ram[i]); // Display memory content in binary
		end
		*/
	end
	


	always @ (posedge clk)
	begin
		// Write
		if (we) ram[addr] <= data;
                // register to hold the read address
		addr_reg <= addr;
	end

	// Continuous assignment implies read returns NEW data.
	// This is the natural behavior of the TriMatrix memory
	// blocks in Single Port mode.  
	assign q = ram[addr_reg];

endmodule // exmem

