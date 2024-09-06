// Make sure that the counter is only high for one cycle
// 2^5 is waaaaaay to small what were you thinking 

module counter #(parameter width=8)
(
	input clk,
	input reset,
	output reg [width-1 : 0] count
);

	always @(posedge clk)
		begin
			if (!reset)
				count <= 0;
			else 
				count <= count + 1'b1;
		end
		
endmodule