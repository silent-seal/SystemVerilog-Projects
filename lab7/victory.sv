module victory (anotherRound, HEX0, HEX5, clk, reset, LEDR9, LEDR1, L, R);
		input logic clk, reset;
		input logic LEDR9, LEDR1, L, R;// L means left key; R means right key
		output logic [6:0] HEX0, HEX5 ; 
		output logic anotherRound; // start the game for another round. 
		
		logic [2:0] Lcounter;
		logic [2:0] Rcounter;
		
		enum{off, p1, p2} ps, ns; // p1 is right; p2 is left
		
		always_comb begin 	
			case(ps) 
					
				off: if (LEDR9 & L & ~R) ns = p2;
				
							else if (LEDR1 & R & ~L) ns = p1;
							
							else ns = off;
							
				p1 : ns = p1;
				
				p2 : ns = p2;
				
			endcase 
		end
		
		
		always_comb begin 
		
					// Display on the right(player 1)
		
				 if 		(Rcounter == 3'b000)  //0
							HEX0 = 7'b1000000;
							
				 else if (Rcounter == 3'b001)//1
							HEX0 = 7'b1001111;
							
				 else if (Rcounter == 3'b010)//2
							HEX0 = 7'b0100100;
							
				 else	if (Rcounter == 3'b011)//3
							HEX0 = 7'b0110000;
							
				 else if (Rcounter == 3'b100)//4
							HEX0 = 7'b0011001;
							
				 else if (Rcounter == 3'b101)//5
							HEX0 = 7'b0010010;
							
				 else if (Rcounter == 3'b110)//6
							HEX0 = 7'b0000010;

				 else if (Rcounter == 3'b111)//7
							HEX0 = 7'b1111000;
				 else 
							HEX0 = 7'b1111111;		
							
		end
		
		always_comb begin 
							
					// Display on the right(player 2 COMPUTER)
		
				 if 		(Lcounter == 3'b000)  //0
							HEX5 = 7'b1000000;
							
				 else if (Lcounter == 3'b001)//1
							HEX5 = 7'b1001111;
							
				 else if (Lcounter == 3'b010)//2
							HEX5	= 7'b0100100;
							
				 else	if (Lcounter == 3'b011)//3
							HEX5	= 7'b0110000;
							
				 else if (Lcounter == 3'b100)//4
							HEX5	= 7'b0011001;
							
				 else if (Lcounter == 3'b101)//5
							HEX5  = 7'b0010010;
							
				 else if (Lcounter == 3'b110)//6
							HEX5  = 7'b0000010;

				 else if (Lcounter == 3'b111)//7
							HEX5	= 7'b1111000;
				 else 
							HEX5 = 7'b1111111;

		end 
		
		always_ff @(posedge clk) begin					// Game win logic for counter, keeps track of number of wins.
					
					if(ps == off & ns == p1)begin			// p1 wins this round 
							Rcounter <= Rcounter + 1'b1;
					end
					
					
					else if (ps == off & ns == p2)begin // p2 wins this round 
							Lcounter <= Lcounter + 1'b1;
					end 
					

					
					else begin									// defult case, don't change utill conditions are met
							Rcounter <= Rcounter;
							Lcounter <= Lcounter;
					end 
					
					
					if(reset) begin							// reset bottom logic 
							Lcounter <= 3'b000;
							Rcounter <= 3'b000;
							ps <= off;
							anotherRound <= 0;
					end 

					
					
					else if (anotherRound) begin			// only reset the playfield. 
							ps <= off;
							anotherRound <= 0;
					end 
										
										
					else 
							ps <= ns;
							
							
					if(ps == p1 || ps ==p2)					// If anyone wins, Play another Round
							anotherRound <= 1;				// (reset only the playfield)
					else 
							anotherRound <= 0;
			
					
		end 
		



endmodule


module victory_testbench ();
		logic clk, reset;
		logic LEDR9, LEDR1, L, R;// L means left key; R means right key
		logic [6:0] HEX0, HEX5 ; 
		logic anotherRound; // start the game for another round. 

		victory dut (.anotherRound, .HEX0(HEX0), .HEX5(HEX5), .clk, .reset, .LEDR9, .LEDR1, .L, .R);
		

		parameter CLOCK_PERIOD = 100;
		
		initial begin
			clk <= 0;
			forever #(CLOCK_PERIOD/2) clk <= ~clk;
		end
		
		
	initial begin 
											@(posedge clk); 
		reset <= 1; 					@(posedge clk); // Always reset FSMs at start 
											@(posedge clk);
		reset <= 0; 					@(posedge clk); 
											@(posedge clk);
											@(posedge clk);
		L<=0;  R<=0; LEDR9 <=0;	LEDR1 <=0;	@(posedge clk);
												@(posedge clk);
												@(posedge clk);
		L<=0;  R<=1; LEDR9 <=0; LEDR1 <=0; 	@(posedge clk);
												@(posedge clk);
												@(posedge clk);
		L<=1;  R<=0; LEDR9 <=0; LEDR1 <=0; 	@(posedge clk);
												@(posedge clk);
												@(posedge clk);
		L<=1;  R<=1; LEDR9 <=0; LEDR1 <=0; 	@(posedge clk);
												@(posedge clk);
												@(posedge clk);
		reset <= 0;							@(posedge clk);
												@(posedge clk);
												@(posedge clk);
		L<=0;  R<=0; LEDR9 <=0; LEDR1 <=0; 	@(posedge clk);
												@(posedge clk);
												@(posedge clk);
		L<=0;  R<=0; LEDR9 <=0; LEDR1 <=1;	@(posedge clk);
												@(posedge clk);
												@(posedge clk);
		L<=0;  R<=0; LEDR9 <=1; LEDR1 <=0; 	@(posedge clk);
												@(posedge clk);
												@(posedge clk);
												
												
		L<=0;  R<=1; LEDR9 <=0; LEDR1 <=0; 	@(posedge clk);
												@(posedge clk);
												@(posedge clk);
		L<=0;  R<=1; LEDR9 <=0; LEDR1 <=1; 	@(posedge clk);
												@(posedge clk);
												@(posedge clk);
		L<=0;  R<=1; LEDR9 <=1; LEDR1 <=0;	@(posedge clk);
												@(posedge clk);
												@(posedge clk);
												
											@(posedge clk); 
		reset <= 1; 					@(posedge clk); // Always reset FSMs at start 
											@(posedge clk);
		reset <= 0; 					@(posedge clk); 
											@(posedge clk);
											@(posedge clk);
												
		L<=1;  R<=0; LEDR9 <=0; LEDR1 <=0; 	@(posedge clk);
												@(posedge clk);
												@(posedge clk);
		L<=1;  R<=0; LEDR9 <=0; LEDR1 <=1;	@(posedge clk);
												@(posedge clk);
												@(posedge clk);
		L<=1;  R<=0; LEDR9 <=1; LEDR1 <=0; 	@(posedge clk);
												@(posedge clk);
												@(posedge clk);
												
												
		L<=1;  R<=1; LEDR9 <=0; LEDR1 <=0;	@(posedge clk);
												@(posedge clk);
												@(posedge clk);
		L<=1;  R<=1; LEDR9 <=0; LEDR1 <=1;	@(posedge clk);
												@(posedge clk);
												@(posedge clk);
		L<=1;  R<=1; LEDR9 <=1; LEDR1 <=0; 	@(posedge clk);
												@(posedge clk);
												@(posedge clk);	
		$stop;
	end 
		
endmodule
		

				