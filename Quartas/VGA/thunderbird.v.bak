module Thunderbird (
	// button signals
	input wire left, right, haz, clk, reset,
	output reg [2:0] L, R,
	output reg [6:0] HEX
	// output wire [31:0] count
);
	// Internal Logic
	wire [31:0] count;
	reg [2:0] state, next_state;
	
	// Stage Encoding
	localparam START = 3'b000;
	localparam L1 = 3'b001;
	localparam L2 = 3'b010;
	localparam L3 = 3'b011;
	localparam R1 = 3'b100;
	localparam R2 = 3'b101;
	localparam R3 = 3'b110;
	localparam HAZ = 3'b111;
	
	localparam hazi = ~7'b1110110;
	localparam r1i = ~7'b0100000;
	localparam r2i = ~7'b1010000; 

	localparam l1i = ~7'b0001000;
	localparam l2i = ~7'b0011000;
	localparam l3i = ~7'b0111000;
	
	/* ---------------- Counter Clk Divider ---------------- */
	counter ctr (
		.clk(clk),
		.reset(reset),
		.count(count)
	);
	
	/* ---------------- State Register CLK ---------------- */
	always @(posedge clk or negedge reset) begin
    if (!reset)
        state <= START;  // Reset state to START
    else if (count[26])  // Use count[5] as an enable signal
        state <= next_state;  // State transitions
	end

	/* ---------------- State Register (Testing) ---------------- */
/*
	always @(posedge clk)
		begin
			if(!reset) state <= START; // Buttons are active low
			else state <= next_state;
		end
*/	
	/* ---------------- Next state logic ---------------- */
	always @(*)
		begin			
			case(state)
				START : 
					begin
						if (!haz)
							next_state <= HAZ;
						else if (!left)
							next_state <= L1;
						else if (!right) 
							next_state <= R1;
						else // This should never happen
							next_state <= START;
					end
					
				L1 : 
					begin
						if (!haz)
							next_state <= HAZ;
						else 
							next_state <= L2;
					end
					
				L2 : 
					begin
						if (!haz)
							next_state <= HAZ;
						else 
							next_state <= L3;
					end
					
				L3 : 
					begin
						if (!haz)
							next_state <= HAZ;
						else 
							next_state <= START;					
					end
					
				R1 : 
					begin
						if (!haz)
							next_state <= HAZ;
						else 
							next_state <= R2;
					end
					
				R2 : 
					begin
						if (!haz)
							next_state <= HAZ;
						else 
							next_state <= R3;
					end
					
				R3 : 
					begin
						if (!haz)
							next_state <= HAZ;
						else 
							next_state <= START;
					end
					
				HAZ : 
					begin
						next_state <= START;
					end
					

				default : // This shouldn't ever happen
					begin
						next_state <= START;
					end
			endcase
		end
		
		
	/* ---------------- Output logic ---------------- */ 
	always @(*)
		begin
			// First set all values to default to 0
			L <= 3'b000;
			R <= 3'b000;
			
			case(state)
				START : 
					begin
						HEX <= ~7'b0000000;
						L <= 3'b000;
						R <= 3'b000;
					end
					
				L1 : 
					begin
						HEX <= l1i;
						L <= 3'b001;
					end
					
				L2 : 
					begin
						HEX <= l2i;
						L <= 3'b011;
					end
					
				L3 : 
					begin
						HEX <= l3i;
						L <= 3'b111;
					end
					
				R1 : 
					begin
						HEX <= r1i;
						R <= 3'b001;
					end
					
				R2 : 
					begin
						HEX <= r2i;
						R <= 3'b011;
					end
					
				R3 : 
					begin
						HEX <= r2i;
						R <= 3'b111;
					end
					
				HAZ : 
					begin
						HEX <= hazi;
						L <= 3'b111;
						R <= 3'b111;
					end
					

				default: // This shouldn't ever happen
					begin
						HEX <= ~7'b0000000;
						L <= 3'b100;
						R <= 3'b100;
					end
			endcase
		end
endmodule