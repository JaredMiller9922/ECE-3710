module vgaControl (
    input clk50Mhz, reset, // system clock and reset
    output reg hSync, vSync, // active low sync signals to the VGA interface
    output reg bright, // asserted when the pixel is bright
    output reg [12:0] hCount, vCount, // horiz and vertical count // these tell you where you are on the screen
	 output clk25Mhz
);

// 1.) Pulse width: How long are we going to hold the sync pulse
// 2.) Back porch: The delay before we are actually on the CRT
// 3.) Display Time: How long we are going to be "bright" for
// 4.) Front porch: How long before we can safely assert the sync pulse

// Horizontal and vertical timing parameters
localparam h_Ts = 800;
localparam h_Tdisp = 640;
localparam h_Tpw = 96;
localparam h_Tfp = 16;
localparam h_Tbp = 48;

localparam v_Ts = 521;
localparam v_Tdisp = 480;
localparam v_Tpw = 2;
localparam v_Tfp = 10;
localparam v_Tbp = 29;

localparam one = 8'b00000001;

reg vertical_en; // Trigger signal to increment vertical counter

// Clock divider to generate enable signal for horizontal counter
clock_divider_25mhz clkDiv (
    .clk50Mhz(clk50Mhz),
    .reset(reset),
    .clk25Mhz(clk25Mhz)
);

// Horizontal and Vertical Counter Logic
always @(posedge clk25Mhz or negedge reset) begin
	if (!reset) begin
		hCount <= 0;
		vCount <= 0;
	end
	
	else begin
	if (hCount < h_Ts - 1) begin
		hCount <= hCount + one;
	end 
	else begin
		hCount <= 0;
		if (vCount < v_Ts - 1)
			vCount <= vCount + one;
		else
			vCount <= 0; // Reset vertical counter after full frame
		end
    end
end

// Horizontal Timing Logic (hSync and bright signals)
always @(posedge clk25Mhz or negedge reset) begin
	if (!reset) begin
		hSync <= 1;
		bright <= 0;
	end 
	else begin
		if (hCount < h_Tpw) begin
			hSync <= 0; // Assert sync pulse
			bright <= 0; // Not displaying
		end 
		else if (hCount < h_Tpw + h_Tbp) begin
			hSync <= 1; // Deassert sync pulse
			bright <= 0; // Not displaying (back porch)
		end 
		else if (hCount < h_Tpw + h_Tbp + h_Tdisp) begin
			bright <= 1; // Displaying pixels
		end 
		else if (hCount < h_Ts) begin
			bright <= 0; // Front porch, not displaying
		end
    end
end

// Vertical Timing Logic
always @(posedge clk25Mhz or negedge reset) begin
	if (!reset) begin
		vSync <= 1; // Deassert sync (active low)
	end 
	else begin
		if (vCount < v_Tpw) begin // Pulse width stage assert vSync
			vSync <= 0; // Assert sync pulse (active low)
		end 
		else if (vCount < v_Tpw + v_Tbp) begin // Back porch stage deassert vSync
			vSync <= 1; // Deassert sync
		end 
		else begin end
	end
end

endmodule
