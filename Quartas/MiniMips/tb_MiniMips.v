// tb_MiniMips
module tb_MiniMips;

// We set the clk and reset to reg because they will be used in an always block
reg clk;
reg reset;
wire memwrite;
wire [7:0] memdata, adr, writedata;

// Create an instance of the MiniMips
MiniMips uut(
	.clk(clk),
	.reset(reset),
	.memwrite(memwrite),
	.memdata(memdata),
	.adr(adr),
	.writedata(writedata)
);

// Instantiate your memory module
exmem mem (
	.data(writedata),
   .addr(adr),
   .we(memwrite),
   .clk(clk),
   .q(memdata)
);

// Create a clock
always begin
	#5 clk = ~clk;
end

// Test Sequence
initial begin
	// Initialize variables
	clk <= 1;
	reset <= 0;  // Assert reset (active low)

	// Hold reset for a few clock cycles
	#20 reset <= 1;  // De-assert reset (system comes out of reset)
	
	#1000;
	if (mem.ram[255] != 8'h0D) 
		$display("ERROR: mem.ram[255] should be 0x0D but was 0x%0h", mem.ram[255]);
	else 
		$display("All is well");
	
	$finish;  // End the simulation after the test
end


endmodule