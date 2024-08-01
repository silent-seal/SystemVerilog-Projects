module victory (winner, clk, reset, LEDR9, LEDR1, L, R);
		input logic clk, reset;
		input logic LEDR9, LEDR1, L, R;
		output logic [6:0] winner; 
		
		enum{off, pR, pL} ps, ns; 
		
		always_comb begin 	
			case(ps) 
					
				off: if (LEDR9 & L & ~R) ns = pL;
				
							else if (LEDR1 & R & ~L) ns = pR;
							
							else ns = off;
							
				pR : ns = pR;
				
				pL : ns = pL;
				
			endcase 
		
			if (ps == pL) winner = 7'b0100100;//2 pL

			else if (ps == pR ) winner = 7'b1001111; //1 pR
			
			else winner = 7'b1111111;
		end 
		
//		always_comb begin 	
//			case(ps) 
//					
//				off: winner = 7'b1111111;
//							
//				pR : winner = 7'b1001111;
//				
//				pL : winner = 7'b0100100;
//				
//			endcase 
//
//		end

		// DFFs 
		always_ff @(posedge clk) begin 
			if (reset) 
				ps <= off; 
			else 
				ps <= ns; 
		end 

endmodule


module victory_testbench ();
		logic clk, reset;
		logic LEDR9, LEDR1, L, R;
		logic [6:0] winner; 
		
		victory dut (.winner, .clk, .reset, .LEDR9, .LEDR1, .L, .R);
		

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
		

				