module VGA_clock (clk_50, clk_25);
	input clk_50;
	output reg clk_25 = 0;
	
	reg counter = 0;
	
	always @(posedge clk_50) begin
	
		if (counter < 2) begin
			clk_25 = !clk_25;
			counter = 0;
		end
		else
			counter = counter + 1;
	end
	
endmodule
