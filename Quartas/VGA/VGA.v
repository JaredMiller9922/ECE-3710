// Simply create an instance of the vgaControl
module VGA (
	input clk50Mhz, reset, // system clock and clear
	output hSync, vSync, // active low sync signals to the VGA interface
	output bright, // asserted when the pixel is bright active low
	output [9:0] hCount, vCount // horiz and vertical count // these tell you where you are on the screen
);

// Instantiate the vgaControl
vgaControl vgaController (
	.clk50Mhz(clk50Mhz),
	.reset(reset),
	.bright(bright),
	.hCount(hCount),
	.vCount(vCount)
);

endmodule