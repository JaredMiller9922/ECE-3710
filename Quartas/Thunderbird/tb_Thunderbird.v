module tb_Thunderbird();

// Define inputs
reg left, right, haz, clk, reset; // These are going to be set in an intial block so use reg

// Define outputs
wire [2:0] L, R;
wire [7:0] count;

// Instantiate the UUT (Unit Under Test)
Thunderbird uut (
	.left(left),
	.right(right),
	.haz(haz),
	.clk(clk),
	.reset(reset),
	.L(L),
	.R(R),
	.count(count)
);

initial begin
	clk = 0;
	forever #5 clk = ~clk;
end

initial begin
	reset = 0;
	left = 1;
	right = 1;
	haz = 1; 
	
	// Deactivate reset
	reset = 1;
	
	/* ---------------- Test 1 Left ---------------- */
	// Apply reset 
	#10 reset = 0;
	#10 reset = 1;
	
	// Set left high
	#20 left = 0;
	#20 left = 1;
	#100; // Let some time pass before starting the next test
	
	/* ---------------- Test 2 Right ---------------- */
	// Apply reset 
	#10 reset = 0;
	#10 reset = 1;
	
	// Set right high
	#20 right = 0;
	#20 right = 1;
	#100; // Let some time pass before starting the next test
	
	/* ---------------- Test 3 Haz ---------------- */
	// Apply reset 
	#10 reset = 0;
	#10 reset = 1;
	
	// Set haz high
	#20 haz = 0;
	#20 haz = 1;
	#100; // Let some time pass before starting the next test
	
	#100 $stop;
end

endmodule

