// Todo: This is just the minimum version. You will most likely use more
// there may be other inputs to help define what the pixel color is...
module bitGen (
	input bright, // asserted if the pixel is in the bright region
	input [9:0] hCount, vCount, // the horizontal and vertical counts
	output reg [7:0] R,G,B// the RGB value of the (hCount,vCount) pixel
);

localparam OFF = 8'b00000000;
localparam ON = 8'b00000001;

// paint a white box on a red background
always@(*)
	if (bright) // Bright is active low
		begin // force black if not bright
			R = OFF; G = OFF; B = OFF;
	end
	// check to see if you’re in the box
	else if (((hCount >= 100) && (hCount <= 300)) &&
		((vCount >= 150) && (vCount <= 350)))
	begin
		R = ON; G = ON; B = ON; // All three ON makes white
	end
	else begin
		R = ON; G = OFF; B = OFF; // pure red is the background color
	end 

endmodule