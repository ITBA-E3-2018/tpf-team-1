module cronometer (start_stop, reset, clk, seconds, minutes, hours); //start_stop = 0 => stop, start_stop = 1 => start
//clock period must be 1kHz
	reg [9:0] miliseconds = 0;
	output reg [5:0] seconds = 0;
	output reg [5:0] minutes = 0;
	output reg [7:0] hours = 0;
	
	
	input clk;
	input reset;
	input start_stop;
	
	reg res = 0;
	reg start = 0;
	
	
	always @(posedge clk) begin

		if (reset == 1) begin
			miliseconds <= 10'b0;
			seconds <= 6'b0;
			minutes <= 6'b0;
			hours <= 6'b0;
		end
		else if (start == 0) begin
		end
		else begin
		
			if (miliseconds == 999) begin
			
				if (seconds == 59) begin
				
					if (minutes == 59) begin
					
						if (hours == 99) begin
							miliseconds <= 10'b0;
							seconds <= 6'b0;
							minutes <= 6'b0;
							hours <= 8'b0;
						end
						else begin
							miliseconds <= 10'b0;
							seconds <= 6'b0;
							minutes <= 6'b0;
							hours <= hours + 1;
						end
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
	
		always @(posedge start_stop) begin
		start = !start;
	end
	
endmodule 
			
