module Thunderbird (
	// button signals
	input wire left, right, haz, clk, reset,
	output reg [2:0] L, R,
	output wire [7:0] count
);
	// Internal Logic
	//wire [7:0] count;
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
    else if (count[5])  // Use count[5] as an enable signal
        state <= next_state;  // State transitions
	end

	/* ---------------- State Register ---------------- */
/*
	always @(posedge count[5])
		begin
			if(!reset) 
				state <= START; // Buttons are active low
			else
				state <= next_state;
		end
*/	
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
						// Need an else to prevent the latches
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
						L <= 3'b000;
						R <= 3'b000;
					end
					
				L1 : 
					begin
						L <= 3'b001;
					end
					
				L2 : 
					begin
						L <= 3'b011;
					end
					
				L3 : 
					begin
						L <= 3'b111;
					end
					
				R1 : 
					begin
						R <= 3'b001;
					end
					
				R2 : 
					begin
						R <= 3'b011;
					end
					
				R3 : 
					begin
						R <= 3'b111;
					end
					
				HAZ : 
					begin
						L <= 3'b111;
						R <= 3'b111;
					end
					

				default: // This shouldn't ever happen
					begin
						L <= 3'b100;
						R <= 3'b100;
					end
			endcase
		end
endmodule