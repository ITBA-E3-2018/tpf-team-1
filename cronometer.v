module cronometer(start_stop, reset, clk, seconds, minutes, hours); //start_stop = 0 => stop, start_stop = 1 => start
//clock period must be 
	reg [9:0] miliseconds;
	output reg [5:0] seconds;
	output reg [5:0] minutes;
	output reg [7:0] hours;
	
	
	input clk;
	input reset;
	input start_stop;
	
	always @(posedge clk) begin
		if (reset == 1) begin
			miliseconds <= 10'b0;
			seconds <= 6'b0;
			minutes <= 6'b0;
			hours <= 6'b0;
		end
		else if (start_stop == 0) begin
		end
		else begin
		
			if (miliseconds == 999) begin
			
				if (seconds == 59) begin
				
					if (minutes == 59) begin
						miliseconds <= 10'b0;
						seconds <= 6'b0;
						minutes <= 6'b0;
						hours <= hours + 1;
					end
					else begin
						miliseconds <= 10'b0;
						seconds <= 6'b0;
						minutes <= minutes + 1;
					end
				end
				else begin
					miliseconds <= 10'b0;
					seconds <= seconds + 1;
				end
			end
			else 
				miliseconds <= miliseconds + 1;
			
		end
	end
endmodule 
			
