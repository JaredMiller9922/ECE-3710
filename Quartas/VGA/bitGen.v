// Todo: This is just the minimum version. You will most likely use more
// there may be other inputs to help define what the pixel color is...
module bitGen (
	input Rs, Gs, Bs,
	input bright, // asserted if the pixel is in the bright region
	input [9:0] hCount, vCount, // the horizontal and vertical counts
	output reg [7:0] R,G,B // the RGB value of the (hCount,vCount) pixel
);

parameter ON = 8'b11111111;
parameter OFF = 8'b00000000;

// paint a white box on a red background
always@(*) 
	begin
		if (~bright) begin // force black if not bright
			R = OFF; G = OFF; B = OFF;
		end
		// Otherwise read the value from the switches
		else begin
			R = (Rs) ? ON : OFF;
			G = (Gs) ? ON : OFF;
			B = (Bs) ? ON : OFF;
		end
	end
endmodule