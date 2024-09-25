module divider
(
	input clk,
	input reset,
	output reg en
);

always @(posedge clk or negedge reset)
	begin
		if (!reset)
			begin
				en <= 0;
			end
		else 
			en <= ~en;
	end

		
endmodule