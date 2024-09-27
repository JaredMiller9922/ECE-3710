// Simply create an instance of the vgaControl
module VGA (
    input clk50Mhz, reset, // system clock and clear
	 input Rs, Gs, Bs, // Enable signals for red green and blue these are tied to the switches
    output hSync, vSync, // active low sync signals to the VGA interface
    output bright, // asserted when the pixel is bright active low
	 output sync_n,
	 output clk25Mhz,
	 output [7:0] R, G, B
);

assign sync_n = 0;

wire [12:0] hCount, vCount; // horiz and vertical count // these tell you where you are on the screen

// Instantiate the vgaControl
vgaControl vgaController (
    .clk50Mhz(clk50Mhz),
    .reset(reset),
    .hSync(hSync),        // Connect hSync to the output of vgaControl
    .vSync(vSync),        // Connect vSync to the output of vgaControl
    .bright(bright),      // Connect bright to the output of vgaControl
    .hCount(hCount),      // Connect hCount to the output of vgaControl
    .vCount(vCount),       // Connect vCount to the output of vgaControl
	 .clk25Mhz(clk25Mhz)
);

// Instantiate the bitGen
bitGen bitgen (
	.Rs(Rs),
	.Gs(Gs),
	.Bs(Bs),
	.bright(bright),
	.hCount(hCount),
	.vCount(vCount),
	.R(R),
	.G(G),
	.B(B)
);

endmodule