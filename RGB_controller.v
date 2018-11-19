module RGB_controller (clk, write, counter1, counter2, second, minute, hour, Rout, Gout, Bout);
//this module takes the numeber from the cronometer, and send it to the VGA input
	input clk, write;
	input [9:0] counter1, counter2; //counter1 is the vertical counter, counter2 is the horizontal counter
	input [5:0] second, minute;
	input [7:0] hour;
	output reg Rout, Gout,Bout;
	
	
	
	
	parameter bit_width = 4; //width of each number
	parameter bit_height = 5; //height of each number
	parameter pixel_repeat = 14; //times that each pixel will be repeated
	parameter vertical_write = 206; //first vertical pixel where the cronometer is displayed
	parameter horizontal_write = 97; //first horizontal pixel where the cronometer is displayed
	
	reg only = 1;
	reg [0:19] digits [0:10]; //array where all the decimal characters are saved
	reg [3:0] number_to_write [7:0]; //number to be written [hour,hour,'colon',minute,minute,'colon',second,second]
	reg [10:0] number_counter = 0; //counter that is used to count the horizontal position of a single number
	
	
	always @(posedge clk) begin
		if (only == 1) begin
			only = 0;		
			digits[0] = 20'b11101010101010101110;// number 0
			digits[1] = 20'b00100010001000100010;// number 1
			digits[2] = 20'b11100010111010001110;// number 2																1110
			digits[3] = 20'b11100010111000101110;// number 3				for example, the number 0 is			1010	the 0s from the end are there to leave a space betwee
			digits[4] = 20'b10101010111000100010;// number 4																1010
			digits[5] = 20'b11101000111000101110;// number 5																1010
			digits[6] = 20'b11101000111010101110;// number 6																1110
			digits[7] = 20'b11100010001000100010;// number 7
			digits[8] = 20'b11101010111010101110;// number 8
			digits[9] = 20'b11101010111000100010;// number 9
			digits[10] = 20'b00000100000001000000;// colon
			
			number_to_write [0] = hour/10;
			number_to_write [1] = hour%10;
			number_to_write [2] = 10;
			number_to_write [3] = minute/10;
			number_to_write [4] = minute%10;
			number_to_write [5] = 10;
			number_to_write [6] = second/10;
			number_to_write [7] = second%10;
			
			
		end
		else begin
			if (write == 1) begin //if i am in the write part
				if (number_counter < (pixel_repeat*bit_width)-1)
					number_counter = number_counter+1;
				else
					number_counter = 0;
				if ((counter1-vertical_write) < pixel_repeat) //first vertical part of the number
					Rout = digits[number_to_write[(counter2-horizontal_write)/(bit_width*pixel_repeat)]][((number_counter)/pixel_repeat)];
				else if ((counter1-vertical_write) < pixel_repeat*2) //second vertical part of the number
					Rout = digits[number_to_write[(counter2-horizontal_write)/(bit_width*pixel_repeat)]][((number_counter)/pixel_repeat) + bit_width];
				else if ((counter1-vertical_write) < pixel_repeat*3) //third vertical part of the number
					Rout = digits[number_to_write[(counter2-horizontal_write)/(bit_width*pixel_repeat)]][((number_counter)/pixel_repeat) + 2*bit_width];
				else if ((counter1-vertical_write) < pixel_repeat*4) //fourth vertical part of the number
					Rout = digits[number_to_write[(counter2-horizontal_write)/(bit_width*pixel_repeat)]][((number_counter)/pixel_repeat) + 3*bit_width];
				else if ((counter1-vertical_write) < pixel_repeat*5) //fifth vertical part of the number
					Rout = digits[number_to_write[(counter2-horizontal_write)/(bit_width*pixel_repeat)]][((number_counter)/pixel_repeat) + 4*bit_width];
				Gout=Rout;
				Bout=Rout;
			end
			else begin //if i am not in the write part
				Rout = 0;
				Gout = 0;
				Bout = 0;
				
				number_to_write [0] = hour/10;
				number_to_write [1] = hour%10;

				number_to_write [3] = minute/10;
				number_to_write [4] = minute%10;

				number_to_write [6] = second/10;
				number_to_write [7] = second%10;
			end
			
		end
	end
endmodule
