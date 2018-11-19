module one_k_clock (clk_in, clk_out);

	input clk_in;
	
	output reg clk_out = 0;
	
	reg [15:0] kcounter = 0; //counter to make a 1kHz clock
	
	parameter comparator = 25175; //comparador para poder hacer el clock de 1kHz
	always @(posedge clk_in) begin
	
		if (kcounter < comparator/2) begin
			kcounter = kcounter + 1;
		end
		else begin
			clk_out = !clk_out;
			kcounter = 0;
		end

	end
		
endmodule
			