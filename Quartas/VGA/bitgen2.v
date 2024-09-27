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
	
	// L[2] box
	else if (((hCount >= 160) && (hCount <= 230)) && 
			  ((vCount >= 150) && (vCount <= 250))) 
	begin
		if (state == L3 || state == HAZ) begin
			R = ON; G = ON; B = OFF; // Yellow
		end
		else begin
			R = ON; G = ON; B = ON; // All three ON makes white
		end
	end
	
	// L[1] box
	else if (((hCount >= 250) && (hCount <= 320)) && 
			  ((vCount >= 150) && (vCount <= 250))) 
	begin
		if (state == L3 || state == L2 || state == HAZ) begin
			R = ON; G = ON; B = OFF; // Yellow
		end
		else begin
			R = ON; G = ON; B = ON; // All three ON makes white
		end
	end
	
	// L[0] box
	else if (((hCount >= 340) && (hCount <= 410)) && 
			  ((vCount >= 150) && (vCount <= 250))) 
	begin
		if (state == L3 || state == L2 || state == L1 || state == HAZ) begin
			R = ON; G = ON; B = OFF; // Yellow
		end
		else begin
			R = ON; G = ON; B = ON; // All three ON makes white
		end
	end
	
	// R[0] box
	else if (((hCount >= 510) && (hCount <= 580)) && 
			  ((vCount >= 150) && (vCount <= 250))) 
	begin
		if (state == R1 || state == R2 || state == R3 ||state == HAZ) begin
			R = ON; G = ON; B = OFF; // Yellow
		end
		else begin
			R = ON; G = ON; B = ON; // All three ON makes white
		end
	end
	// R[1] box
	else if (((hCount >= 600) && (hCount <= 670)) && 
			  ((vCount >= 150) && (vCount <= 250))) 
	begin
		if (state == R2 || state == R3 || state == HAZ) begin
			R = ON; G = ON; B = OFF; // Yellow
		end
		else begin
			R = ON; G = ON; B = ON; // All three ON makes white
		end
	end
	// R[2] box
	else if (((hCount >= 690) && (hCount <= 760)) && 
			  ((vCount >= 150) && (vCount <= 250))) 
	begin
		if (state == R3 || state == HAZ) begin
			R = ON; G = ON; B = OFF; // Yellow
		end
		else begin
			R = ON; G = ON; B = ON; // All three ON makes white
		end
	end
	
	
	else begin
		R = OFF; G = OFF; B = ON; // pure blue is the background color
	end
endmodule