module bitGen2 (
	input Rs, Gs, Bs,
	input bright, // asserted if the pixel is in the bright region
	input [2:0] state,
	input [9:0] hCount, vCount, // the horizontal and vertical counts
	output reg [7:0] R,G,B // the RGB value of the (hCount,vCount) pixel
);

// Stage Encoding
localparam START = 3'b000;
localparam L1 = 3'b001;
localparam L2 = 3'b010;
localparam L3 = 3'b011;
localparam R1 = 3'b100;
localparam R2 = 3'b101;
localparam R3 = 3'b110;
localparam HAZ = 3'b111;
	

parameter ON = 8'b11111111;
parameter OFF = 8'b00000000;

// paint a white box on a red background
always@(*)
	if (~bright) begin // force black if not bright
		R = OFF; G = OFF; B = OFF;
	end
	else if (state == START) begin
		R = OFF; G = ON; B = OFF;
	end
	else if (state == HAZ) begin
		R = ON; G = OFF; B = OFF;
	end
// check to see if you’re in the box
	else if (((hCount >= 200) && (hCount <= 250)) && 
			  ((vCount >= 150) && (vCount <= 250))) 
	begin
		R = ON; G = ON; B = ON; // All three ON makes white
	end
	else begin
		R = ON; G = OFF; B = OFF; // pure red is the background color
	end
endmodule