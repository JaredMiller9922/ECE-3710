module counter #(parameter width=32)
(
	input clk,
	input reset,
	output reg [width-1 : 0] count
);

	always @(posedge clk)
		begin
			if (!reset)
				count <= 0;
			else if 
				(count[26]) count <= 0;
			else 
				count <= count + 1'b1;
		end
		
endmodule