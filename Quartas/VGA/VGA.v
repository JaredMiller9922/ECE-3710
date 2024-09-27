// Simply create an instance of the vgaControl
module VGA (
    input clk50Mhz, reset, // system clock and clear
    output hSync, vSync, // active low sync signals to the VGA interface
    output bright, // asserted when the pixel is bright active low
	 output [7:0] R,G,B,
	 output VGA_SYNC_N
);

assign VGA_SYNC_N = 0;

wire [12:0] hCount, vCount; // horiz and vertical count // these tell you where you are on the screen

// Instantiate the vgaControl
vgaControl vgaController (
    .clk50Mhz(clk50Mhz),
    .reset(reset),
    .hSync(hSync),        // Connect hSync to the output of vgaControl
    .vSync(vSync),        // Connect vSync to the output of vgaControl
    .bright(bright),      // Connect bright to the output of vgaControl
    .hCount(hCount),      // Connect hCount to the output of vgaControl
    .vCount(vCount)       // Connect vCount to the output of vgaControl
);

// Instantiate the bitGen
bitGen bitgen (
	.bright(bright),
	.hCount(hCount),
	.vCount(vCount),
	.R(R),
	.G(G),
	.B(B)
);

endmodule