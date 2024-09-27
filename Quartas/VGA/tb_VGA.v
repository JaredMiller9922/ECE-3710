module tb_VGA;

reg clk50Mhz;
reg reset; // system clock and clear
wire hSync, vSync; // active low sync signals to the VGA interface
wire bright; // asserted when the pixel is bright active low
wire [12:0] hCount, vCount; // horiz and vertical count // these tell you where you are on the screen

// Instantiate uut
VGA uut (
    .clk50Mhz(clk50Mhz),
    .reset(reset),
    .hSync(hSync),        // Connect hSync to the output of vgaControl
    .vSync(vSync),        // Connect vSync to the output of vgaControl
    .bright(bright),      // Connect bright to the output of vgaControl
    .hCount(hCount),      // Connect hCount to the output of vgaControl
    .vCount(vCount)       // Connect vCount to the output of vgaControl
);

// Create a clock
always begin
	#5 clk50Mhz <= ~clk50Mhz;
end


// Test sequence 
initial begin
	// Initialize variables
	clk50Mhz <= 0;
	reset <= 0; 
	
	// Let go of reset for a few cycles
	#20 reset <= 1;
	
	// Wait for some time so the system can execute
	#10000;
end

endmodule
