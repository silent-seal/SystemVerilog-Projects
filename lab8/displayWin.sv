module displayWin(clk, RST, RedPixels, GrnPixels, outputGreen, outputRed, oneWin);
	input logic clk;
	input logic RST;
	input logic [15:0][15:0] RedPixels, GrnPixels;
	output logic [6:0] outputGreen, outputRed;
	output logic oneWin;
	
	//If someone wins there is a reset
	logic [1:0] ps, ns;
	
	
	parameter one = 2'b01, two = 2'b10, none = 2'b00;
	 

	 
	 
	//Left winner is One, right winner is Two. 
	logic [2:0] counterGreen; //1-7 count victory
	logic [2:0] counterRed;
	
	always_comb begin
	   if 			(counterGreen == 3'b000) begin
			outputGreen = 7'b1000000;
		end else if (counterGreen == 3'b001) begin
			outputGreen = 7'b1111001; 
		end else if (counterGreen == 3'b010) begin
			outputGreen = 7'b0100100;
		end else if (counterGreen == 3'b011) begin
			outputGreen = 7'b0110000;
		end else if (counterGreen == 3'b100) begin
			outputGreen = 7'b0011001;
		end else if (counterGreen == 3'b101) begin
		   outputGreen = 7'b0010010;
		end else if (counterGreen == 3'b110) begin
			outputGreen = 7'b0000010;
		end else if (counterGreen == 3'b111) begin
			outputGreen = 7'b1111000;
		end else begin
			outputGreen = 7'b1111111;
		end	
	end
	
	always_comb begin
	   if 			(counterRed == 3'b000) begin
			outputRed = 7'b1000000;
		end else if (counterRed == 3'b001) begin
			outputRed = 7'b1111001; 
		end else if (counterRed == 3'b010) begin
			outputRed = 7'b0100100;
		end else if (counterRed == 3'b011) begin
			outputRed = 7'b0110000;
		end else if (counterRed == 3'b100) begin
			outputRed = 7'b0011001;
		end else if (counterRed == 3'b101) begin
		   outputRed = 7'b0010010;
		end else if (counterRed == 3'b110) begin
			outputRed = 7'b0000010;
		end else if (counterRed == 3'b111) begin
			outputRed = 7'b1111000;
		end else begin
			outputRed = 7'b1111111;
		end
	end



//17 ways in total to win
	always_comb begin
	   case (ps)
//RED	
	//Vertical conditions
		
		   none:    //		   right_1 row (start from bottom)
					if (RedPixels[14][1] == 1 & RedPixels[11][1] == 1 & RedPixels[8][1] == 1 & RedPixels[5][1] == 1) begin
			ns = one;//			right_1 row (start from middle)
		end else if (RedPixels[11][1] == 1 & RedPixels[8][1] == 1 & RedPixels[5][1] == 1 & RedPixels[2][1] == 1) begin
			ns = one;
						//		   right_2 row (	 bottom)
		end else if (RedPixels[14][4] == 1 & RedPixels[11][4] == 1 & RedPixels[8][1] == 1 & RedPixels[5][1] == 1) begin
			ns = one;//		   right_2 row (	 middle)
		end else if (RedPixels[11][4] == 1 & RedPixels[8][4] == 1 & RedPixels[5][4] == 1 & RedPixels[2][4] == 1) begin
			ns = one;
						//		   left_1 row (	 bottom)
		end else if (RedPixels[14][7] == 1 & RedPixels[11][7] == 1 & RedPixels[8][7] == 1 & RedPixels[5][7] == 1) begin
			ns = one;//		   left_1 row (	 middle)
		end else if (RedPixels[11][7] == 1 & RedPixels[8][7] == 1 & RedPixels[5][7] == 1 & RedPixels[2][7] == 1) begin
			ns = one;
						//		   left_2 row (	 bottom)
		end else if (RedPixels[14][10] == 1 & RedPixels[11][10] == 1 & RedPixels[8][10] == 1 & RedPixels[5][10] == 1) begin
			ns = one;//		   left_2 row (	 middle)
		end else if (RedPixels[11][10] == 1 & RedPixels[8][10] == 1 & RedPixels[5][10] == 1 & RedPixels[2][10] == 1) begin
			ns = one;
			
			
	//Crossing conditions
			
		end else if (RedPixels[14][1] == 1 & RedPixels[11][4] == 1 & RedPixels[8][7] == 1 & RedPixels[5][10] == 1) begin
			ns = one;
		end else if (RedPixels[11][1] == 1 & RedPixels[8][4] == 1 & RedPixels[5][7] == 1 & RedPixels[2][10] == 1) begin
			ns = one;
			
		end else if (RedPixels[2][1] == 1 & RedPixels[5][4] == 1 & RedPixels[8][7] == 1 & RedPixels[11][10] == 1) begin
			ns = one;
		end else if (RedPixels[5][1] == 1 & RedPixels[8][4] == 1 & RedPixels[11][7] == 1 & RedPixels[14][10] == 1) begin
			ns = one;


	//Horizontal Conditions
		
		end else if (RedPixels[2][1] == 1 & RedPixels[2][4] == 1 & RedPixels[2][7] == 1 & RedPixels[2][10] == 1) begin
			ns = one;

		end else if (RedPixels[5][1] == 1 & RedPixels[5][4] == 1 & RedPixels[5][7] == 1 & RedPixels[5][10] == 1) begin
			ns = one;
			
		end else if (RedPixels[8][1] == 1 & RedPixels[8][4] == 1 & RedPixels[8][7] == 1 & RedPixels[8][10] == 1) begin
			ns = one;
			
		end else if (RedPixels[11][1] == 1 & RedPixels[11][4] == 1 & RedPixels[11][7] == 1 & RedPixels[11][10] == 1) begin
			ns = one;

		end else if (RedPixels[14][1] == 1 & RedPixels[14][4] == 1 & RedPixels[14][7] == 1 & RedPixels[14][10] == 1) begin
			ns = one;
			
	
			
//GREEN			
		//Vertical
		end else if (GrnPixels[14][1] == 1 & GrnPixels[11][1] == 1 & GrnPixels[8][1] == 1 & GrnPixels[5][1] == 1) begin
			ns = two;
		end else if (GrnPixels[11][1] == 1 & GrnPixels[8][1] == 1 & GrnPixels[5][1] == 1 & GrnPixels[2][1] == 1) begin
			ns = two;
		end else if (GrnPixels[14][4] == 1 & GrnPixels[11][4] == 1 & GrnPixels[8][1] == 1 & GrnPixels[5][1] == 1) begin
			ns = two;
		end else if (GrnPixels[11][4] == 1 & GrnPixels[8][4] == 1 & GrnPixels[5][4] == 1 & GrnPixels[2][4] == 1) begin
			ns = two;
		end else if (GrnPixels[14][7] == 1 & GrnPixels[11][7] == 1 & GrnPixels[8][7] == 1 & GrnPixels[5][7] == 1) begin
			ns = two;
		end else if (GrnPixels[11][7] == 1 & GrnPixels[8][7] == 1 & GrnPixels[5][7] == 1 & GrnPixels[2][7] == 1) begin
			ns = two;
		end else if (GrnPixels[14][10] == 1 & GrnPixels[11][10] == 1 & GrnPixels[8][10] == 1 & GrnPixels[5][10] == 1) begin
			ns = two;
		end else if (GrnPixels[11][10] == 1 & GrnPixels[8][10] == 1 & GrnPixels[5][10] == 1 & GrnPixels[2][10] == 1) begin
			ns = two;
			
		//Crossing	
		end else if (GrnPixels[14][1] == 1 & GrnPixels[11][4] == 1 & GrnPixels[8][7] == 1 & GrnPixels[5][10] == 1) begin
			ns = two;
		end else if (GrnPixels[11][1] == 1 & GrnPixels[8][4] == 1 & GrnPixels[5][7] == 1 & GrnPixels[2][10] == 1) begin
			ns = two;
		end else if (GrnPixels[2][1] == 1 & GrnPixels[5][4] == 1 & GrnPixels[8][7] == 1 & GrnPixels[11][10] == 1) begin
			ns = two;
		end else if (GrnPixels[5][1] == 1 & GrnPixels[8][4] == 1 & GrnPixels[11][7] == 1 & GrnPixels[14][10] == 1) begin
			ns = two;
		
		
		//Horizontal
		end else if (GrnPixels[2][1] == 1 & GrnPixels[2][4] == 1 & GrnPixels[2][7] == 1 & GrnPixels[2][10] == 1) begin
			ns = two;
		end else if (GrnPixels[5][1] == 1 & GrnPixels[5][4] == 1 & GrnPixels[5][7] == 1 & GrnPixels[5][10] == 1) begin
			ns = two;			
		end else if (GrnPixels[8][1] == 1 & GrnPixels[8][4] == 1 & GrnPixels[8][7] == 1 & GrnPixels[8][10] == 1) begin
			ns = two;
		end else if (GrnPixels[11][1] == 1 & GrnPixels[11][4] == 1 & GrnPixels[11][7] == 1 & GrnPixels[11][10] == 1) begin
			ns = two;
		end else if (GrnPixels[14][1] == 1 & GrnPixels[14][4] == 1 & GrnPixels[14][7] == 1 & GrnPixels[14][10] == 1) begin
			ns = two;


		end else begin 
			ns = none;	

		end
			//Now we need to deal with the new reset
			one:   begin
				//It should go back and start again
				ns = none; 
				//oneWin = 1'b1;
			
			end
			//Now we need to deal with the new reset
			two:   begin 
				//It should go back and start again
				ns = none; 
				//oneWin = 1'b1;
			
			end
			default: begin 
				ns = none; 
				//counterOne = 0; 
				//counterTwo = 0;
				//oneWin = 1'b0;
			
			end
			
		endcase
	end
		
	always_ff @(posedge clk) begin
	   if (RST) begin
		   ps <= none;
			counterGreen <= 0;
			counterRed <= 0;
			oneWin <= 0;
			
			//count red win 
		end else if (ns == one) begin
		   ps <= ns;
			counterRed <= counterRed + 1; 
			oneWin <= 1;
			
			//count green win 
			end else if (ns == two) begin
		   ps <= ns;
			counterGreen <= counterGreen + 1;
			oneWin <= 1;

	end else begin
		ps <= ns;
		oneWin <= 0;
	end

	end
			
		
endmodule














module displayWin_testbench();
	logic clk;
	logic RST;
	logic [15:0][15:0] RedPixels, GrnPixels;
	logic [6:0] outputGreen, outputRed;
	logic oneWin;
	
	displayWin dut18 (clk, RST, RedPixels, GrnPixels, outputGreen, outputRed, oneWin);
	
	
	 // Set up a simulated clock.   
 parameter CLOCK_PERIOD=100;  
 initial begin   
  clk <= 0;  
  forever #(CLOCK_PERIOD/2) clk <= ~clk; // Forever toggle the clock 
 end  
 
   
 // Test the design.
integer i; 
 initial begin   
 
  //I go through all the 65536 values (2^16) and assign them to the pixel grids.
	for(i = 0; i <65536; i++) begin
    RST <= 1; @(posedge clk); 
    RST <= 0; RedPixels[0] = i; GrnPixels[0] = i; @(posedge clk);
                     @(posedge clk);   
                      @(posedge clk);
                     @(posedge clk);   
                      @(posedge clk);
							 
			RedPixels[1] = i; GrnPixels[1] = i; @(posedge clk);
                     @(posedge clk);   
                      @(posedge clk);
                     @(posedge clk);   
                      @(posedge clk);
							 
							 
							 RedPixels[2] = i; GrnPixels[2] = i; @(posedge clk);
                     @(posedge clk);   
                      @(posedge clk);
                     @(posedge clk);   
                      @(posedge clk);
							 
							 
							 RedPixels[3] = i; GrnPixels[3] = i; @(posedge clk);
                     @(posedge clk);   
                      @(posedge clk);
                     @(posedge clk);   
                      @(posedge clk);
							 
							 
							 RedPixels[4] = i; GrnPixels[4] = i; @(posedge clk);
                     @(posedge clk);   
                      @(posedge clk);
                     @(posedge clk);   
                      @(posedge clk);
							 
							 
							 RedPixels[5] = i; GrnPixels[5] = i; @(posedge clk);
                     @(posedge clk);   
                      @(posedge clk);
                     @(posedge clk);   
                      @(posedge clk);
							 
							 
							 RedPixels[6] = i; GrnPixels[6] = i; @(posedge clk);
                     @(posedge clk);   
                      @(posedge clk);
                     @(posedge clk);   
                      @(posedge clk);
							 
							 
							 RedPixels[7] = i; GrnPixels[7] = i; @(posedge clk);
                     @(posedge clk);   
                      @(posedge clk);
                     @(posedge clk);   
                      @(posedge clk);
							 
							 
							 RedPixels[8] = i; GrnPixels[8] = i; @(posedge clk);
                     @(posedge clk);   
                      @(posedge clk);
                     @(posedge clk);   
                      @(posedge clk);
							 
							 
							 RedPixels[9] = i; GrnPixels[9] = i; @(posedge clk);
                     @(posedge clk);   
                      @(posedge clk);
                     @(posedge clk);   
                      @(posedge clk);
							 
							 
							 RedPixels[10] = i; GrnPixels[10] = i; @(posedge clk);
                     @(posedge clk);   
                      @(posedge clk);
                     @(posedge clk);   
                      @(posedge clk);
							 
							 
							 RedPixels[11] = i; GrnPixels[11] = i; @(posedge clk);
                     @(posedge clk);   
                      @(posedge clk);
                     @(posedge clk);   
                      @(posedge clk);
							 
							 RedPixels[12] = i; GrnPixels[12] = i; @(posedge clk);
                     @(posedge clk);   
                      @(posedge clk);
                     @(posedge clk);   
                      @(posedge clk);
							 
							 RedPixels[13] = i; GrnPixels[13] = i; @(posedge clk);
                     @(posedge clk);   
                      @(posedge clk);
                     @(posedge clk);   
                      @(posedge clk);
							 
							 RedPixels[14] = i; GrnPixels[14] = i; @(posedge clk);
                     @(posedge clk);   
                      @(posedge clk);
                     @(posedge clk);   
                      @(posedge clk);
							 
							 RedPixels[15] = i; GrnPixels[15] = i; @(posedge clk);
                     @(posedge clk);   
                      @(posedge clk);
                     @(posedge clk);   
                      @(posedge clk);

				
	  end
	  

  
  $stop; // End the simulation.  
 end 
 
 endmodule 