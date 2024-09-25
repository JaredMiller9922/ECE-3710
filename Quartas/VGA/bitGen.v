// Todo: This is just the minimum version. You will most likely use more
// there may be other inputs to help define what the pixel color is...
module bitGen (
	input bright, // asserted if the pixel is in the bright region
	input [9:0] hCount, vCount, // the horizontal and vertical counts
	output [2:0] rgb // the RGB value of the (hCount,vCount) pixel
);

endmodule