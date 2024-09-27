module clock_divider_25mhz (
    input clk50Mhz,
    input reset,
    output reg clk25Mhz
);

always @(posedge clk50Mhz or negedge reset) begin
    if (!reset) begin
        clk25Mhz <= 0;
    end else begin
        clk25Mhz <= ~clk25Mhz;  // Toggle every cycle, divides 50MHz by 2
    end
end
endmodule
