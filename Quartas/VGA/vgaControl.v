module vgaControl (
    input clk50Mhz, reset, // system clock and reset
    output reg hSync, vSync, // active low sync signals to the VGA interface
    output reg bright, // asserted when the pixel is bright active low
    output reg [12:0] hCount, vCount // horiz and vertical count // these tell you where you are on the screen
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

wire horizontal_en; // Trigger signal to increment horizontal counter
reg vertical_en; // Trigger signal to increment vertical counter

// Clock divider to generate enable signal for horizontal counter
divider divClk (
    .clk(clk50Mhz),
    .reset(reset),
    .en(horizontal_en)
);

// Horizontal and Vertical Counter Logic
always @(posedge clk50Mhz or negedge reset) begin
	if (!reset) begin
		hCount <= 0;
		vCount <= 0;
	end 
	else if (horizontal_en) 
		begin
			if (hCount < h_Ts - 1) begin
				hCount <= hCount + 1;
			end 
			else 
				begin
					hCount <= 0;
					if (vCount < v_Ts - 1)
						vCount <= vCount + 1;
					else
						vCount <= 0; // Reset vertical counter after full frame
				end
    end
end

// Horizontal Timing Logic (hSync and bright signals)
always @(posedge clk50Mhz or negedge reset) begin
    if (!reset) begin
        hSync <= 1;
        bright <= 1; // Active low signal
    end else begin
        if (hCount < h_Tpw) begin
            hSync <= 0; // Assert sync pulse
            bright <= 1; // Not displaying
        end else if (hCount < h_Tpw + h_Tbp) begin
            hSync <= 1; // Deassert sync pulse
            bright <= 1; // Not displaying (back porch)
        end else if (hCount < h_Tpw + h_Tbp + h_Tdisp) begin
            bright <= 0; // Displaying pixels (active low)
        end else if (hCount < h_Ts) begin
            bright <= 1; // Front porch, not displaying
        end
    end
end

// Vertical Timing Logic
always @(posedge clk50Mhz or negedge reset) begin
	if (!reset) begin
		vSync <= 1; // Deassert sync (active low)
	end 
	else 
		begin
			if (vCount < v_Tpw) begin // Pulse width stage assert vSync
            vSync <= 0; // Assert sync pulse (active low)
			end 
			else if (vCount < v_Tpw + v_Tbp) begin // Back porch stage deassert vSync
            vSync <= 1; // Deassert sync
			end 
			// No need to worry about the display stage because horizontal should already handle bright assertion
			else begin end
		end
end

endmodule
