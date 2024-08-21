//
// The testbench (module named "stimulus") drives the 
// Device Under Test (DUT), and looks at signals from the DUT.
//
// This is a self-checking testbench that will print an ERROR
// message if the simulation results in unexpected results
// 
module stimulus; // no external signals

   // internal signals for communicating from the testbench to the DUT
   reg [3:0] DUTinput;    // output from TB is input to DUT.
   wire [6:0] DUToutput;  // output from DUT is input to the TB

   // instantiate the hex to 7seg circuit as an instance named DUT
   // Connect DUTinput to the SW inputs of the DUT
   // Connect the Hex outputs of the DUT to DUToutput
   hexTo7Seg DUT (
		.SW(DUTinput), 
		.Hex(DUToutput) 
	);
		
   initial begin
      // Sequence inputs to the DUT, display/check outputs from the DUT
          DUTinput=0; #1 $display("SW = %h, Hex = %b", DUTinput, ~DUToutput);	
        if (DUToutput != ~7'b0111111) $display("ERROR: ~DUToutput should be ~7'b0111111");  

      #20 DUTinput=1; #1 $display("SW = %h, Hex = %b", DUTinput, ~DUToutput);	 
        if (DUToutput != ~7'b0000110) $display("ERROR: ~DUToutput should be ~7'b0000110"); 

      #20 DUTinput=2; #1 $display("SW = %h, Hex = %b", DUTinput, ~DUToutput);	
        if (DUToutput != ~7'b1011011) $display("ERROR: ~DUToutput should be ~7'b1011011"); 

      #20 DUTinput=3; #1 $display("SW = %h, Hex = %b", DUTinput, ~DUToutput);	
        if (DUToutput != ~7'b1001111) $display("ERROR: ~DUToutput should be ~7'b1001111"); 
		  
		#20 DUTinput=4; #1 $display("SW = %h, Hex = %b", DUTinput, ~DUToutput);	 
        if (DUToutput != ~7'b1100110) $display("ERROR: ~DUToutput should be ~7'b1100110"); 

      #20 DUTinput=5; #1 $display("SW = %h, Hex = %b", DUTinput, ~DUToutput);	
        if (DUToutput != ~7'b1101101) $display("ERROR: ~DUToutput should be ~7'b1101101"); 

      #20 DUTinput=6; #1 $display("SW = %h, Hex = %b", DUTinput, ~DUToutput);	
        if (DUToutput != ~7'b1111101) $display("ERROR: ~DUToutput should be ~7'b1111101");  
		  
		#20 DUTinput=7; #1 $display("SW = %h, Hex = %b", DUTinput, ~DUToutput);	 
        if (DUToutput != ~7'b0000111) $display("ERROR: ~DUToutput should be ~7'b0000111"); 

      #20 DUTinput=8; #1 $display("SW = %h, Hex = %b", DUTinput, ~DUToutput);	
        if (DUToutput != ~7'b1111111) $display("ERROR: ~DUToutput should be ~7'b1111111"); 

      #20 DUTinput=9; #1 $display("SW = %h, Hex = %b", DUTinput, ~DUToutput);	
        if (DUToutput != ~7'b1100111) $display("ERROR: ~DUToutput should be ~7'b1100111"); 
		  
		#20 DUTinput=10; #1 $display("SW = %h, Hex = %b", DUTinput, ~DUToutput);	 
        if (DUToutput != ~7'b1110111) $display("ERROR: ~DUToutput should be ~7'b1110111"); 

      #20 DUTinput=11; #1 $display("SW = %h, Hex = %b", DUTinput, ~DUToutput);	
        if (DUToutput != ~7'b1111100) $display("ERROR: ~DUToutput should be ~7'b1111100"); 

      #20 DUTinput=12; #1 $display("SW = %h, Hex = %b", DUTinput, ~DUToutput);	
        if (DUToutput != ~7'b1011000) $display("ERROR: ~DUToutput should be ~7'b1011000"); 
		  
		#20 DUTinput=13; #1 $display("SW = %h, Hex = %b", DUTinput, ~DUToutput);	 
        if (DUToutput != ~7'b1011110) $display("ERROR: ~DUToutput should be ~7'b1011110"); 

      #20 DUTinput=14; #1 $display("SW = %h, Hex = %b", DUTinput, ~DUToutput);	
        if (DUToutput != ~7'b1111001) $display("ERROR: ~DUToutput should be ~7'b1111001"); 

      #20 DUTinput=15; #1 $display("SW = %h, Hex = %b", DUTinput, ~DUToutput);	
        if (DUToutput != ~7'b1110001) $display("ERROR: ~DUToutput should be ~7'b1110001");   
		  
   end // initial begin

endmodule // stimulus