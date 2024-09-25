module vgaControl (
	input clk50Mhz, reset, // system clock and clear
	output reg hSync, vSync, // active low sync signals to the VGA interface
	output reg bright, // asserted when the pixel is bright active low
	output reg [9:0] hCount, vCount // horiz and vertical count // these tell you where you are on the screen
);

// 1.) Pulse width: How long are we going to hold the sync pulse
// 2.) Back porch: The delay before we are actually on the CRT
// 3.) Display Time: How long we are going to be "bright" for
// 4.) Front porch: How long before we can safely assert the sync pulse

// Horizontal timing defined by the number of clock cycles
localparam h_Ts = 800; 		// | Sync Pulse Time
localparam h_Tdisp = 640;  // | Display Time
localparam h_Tpw = 96; 		// | Pulse Width
localparam h_Tfp = 16;		// | Front Porch
localparam h_Tbp = 48;	   // | Back Porch

// Vertical timing defined by the number of lines
localparam v_Ts = 521; 		// | Sync Pulse Time
localparam v_Tdisp = 480;  // | Display Time
localparam v_Tpw = 2; 		// | Pulse Width
localparam v_Tfp = 10;		// | Front Porch
localparam v_Tbp = 29;	   // | Back Porch

wire horizontal_en; // Signal that says we should increment the horizontal counter
reg vertical_en; // Signal that says we should increment the vertical counter

// Create a enable signal for the horizontal counter that divides the clk by 2 making a 25MHz clk
divider divClk (
	.clk(clk50Mhz),
	.reset(reset),
	.en(horizontal_en)
);

// Horizontal Counter
always @(posedge clk50Mhz or negedge reset)
	begin
		if (!reset)
			begin
				hSync = 1;
				vSync = 1;
				bright = 1; 
				vCount = 0;
				hCount = 0;
			end
		else if (horizontal_en)
				hCount = hCount + 1;
		else 
				hCount = hCount; // Here to prevent latches
	end


// Horizontal Timing Logic
always @(posedge clk50Mhz or negedge reset)	
begin		
	if (hCount < h_Tpw) // Pulse width stage
		begin
			hSync = 0; // Continue holding the signal low
			bright = 1; // No need to display right now
		end
	else if (hCount < h_Tpw + h_Tbp) // Back porch stage
		begin
			hSync = 1; 
			bright = 1; 
		end
	else if (hCount < h_Tpw + h_Tbp + h_Tdisp) // Display stage
		begin
			bright = 0;
		end
	else if (hCount < h_Tpw + h_Tbp + h_Tdisp + h_Tfp) // front porch stage
		begin
			bright = 1;
		end
	else // End of the line stage
		begin
			bright = 0;
			hCount = 0;
			vertical_en = 1;
		end
end

// Vertical Counter
always @(posedge clk50Mhz or negedge reset)
	begin
		if (vertical_en)
			begin
				vCount = vCount + 1;
				vertical_en = 0;
			end
		else 
			vCount = vCount; // Here to prevent latches
	end
	
// Vertical Timing Logic
always @(posedge clk50Mhz or negedge reset)	
begin		
	if (vCount < v_Tpw) // Pulse width stage
		begin
			vSync = 0; // Continue holding the signal low
		end
	else if (vCount < v_Tpw + v_Tbp) // Back porch stage
		begin
			vSync = 1; 
		end
	else if (vCount < v_Tpw + v_Tbp + v_Tdisp) // Display stage
		begin
			vSync = 1;
		end
	else if (vCount < v_Tpw + v_Tbp + v_Tdisp + v_Tfp) // front porch stage
		begin
			vSync = 1; 
		end
	else // End of the display stage
		begin
			vCount = 0;
		end
end
	
endmodule