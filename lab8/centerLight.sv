module centerLight (clk, reset , L, R, NL, NR, lightOn, anotherRound);
	input logic clk, reset;
	input logic L, R, NL, NR, anotherRound;
	output logic lightOn;
	

	enum {on, off} ps, ns;
	
	always_comb begin
		case(ps)
			on: if (R ^ L) ns = off;
				 else ns = on;

			off: if (NR & L | NL & R) ns = on;
				  else ns = off;
		endcase
	end

	always_comb begin
				case(ps)
					on: lightOn = 1;
					off: lightOn = 0;
				endcase
				
	end

	// DFFs 
	always_ff @(posedge clk) begin 
		if (reset || anotherRound) 
			ps <= on; 
		else 
			ps <= ns; 
	end
	


	// L is true when left key is pressed, R is true when the right key 
	// is pressed, NL is true when the light on the left is on, and NR 
	// is true when the light on the right is on. 

	// when lightOn is true, the center light should be on. 
 
	// Your code goes here!!	

endmodule

module centerLight_testbench();
		logic L, R, NL, NR, anotherRound;
		logic lightOn;
		logic clk, reset;
		
		centerLight dut(.lightOn, .clk, .reset, .L, .R, .NL, .NR, .anotherRound);
		 
		parameter CLOCK_PERIOD = 100;
		initial begin
			clk <= 0;
			forever #(CLOCK_PERIOD/2);
			clk <= ~clk;
		end
		
	initial begin 
											@(posedge clk); 
		reset <= 1; 					@(posedge clk); // Always reset FSMs at start 
											@(posedge clk);
		reset <= 0; 					@(posedge clk); 
											@(posedge clk);
											@(posedge clk);
		L<=0;  R<=0; NL <=0;	NR <=0;	@(posedge clk);
												@(posedge clk);
												@(posedge clk);
		L<=0;  R<=1; NL <=0; NR <=0; 	@(posedge clk);
												@(posedge clk);
												@(posedge clk);
		L<=1;  R<=0; NL <=0; NR <=0; 	@(posedge clk);
												@(posedge clk);
												@(posedge clk);
		L<=1;  R<=1; NL <=0; NR <=0;	@(posedge clk);
												@(posedge clk);
												@(posedge clk);
		reset <= 0;							@(posedge clk);
												@(posedge clk);
												@(posedge clk);
		L<=0;  R<=0; NL <=0; NR <=0; 	@(posedge clk);
												@(posedge clk);
												@(posedge clk);
		L<=0;  R<=0; NL <=0; NR <=1; 	@(posedge clk);
												@(posedge clk);
												@(posedge clk);
		L<=0;  R<=0; NL <=1; NR <=0; 	@(posedge clk);
												@(posedge clk);
												@(posedge clk);
												
												
		L<=0;  R<=1; NL <=0; NR <=0; 	@(posedge clk);
												@(posedge clk);
												@(posedge clk);
		L<=0;  R<=1; NL <=0; NR <=1; 	@(posedge clk);
												@(posedge clk);
												@(posedge clk);
		L<=0;  R<=1; NL <=1; NR <=0; 	@(posedge clk);
												@(posedge clk);
												@(posedge clk);
												
												
		L<=1;  R<=0; NL <=0; NR <=0; 	@(posedge clk);
												@(posedge clk);
												@(posedge clk);
		L<=1;  R<=0; NL <=0; NR <=1; 	@(posedge clk);
												@(posedge clk);
												@(posedge clk);
		L<=1;  R<=0; NL <=1; NR <=0;	@(posedge clk);
												@(posedge clk);
												@(posedge clk);
												
												
		L<=1;  R<=1; NL <=0; NR <=0; 	@(posedge clk);
												@(posedge clk);
												@(posedge clk);
		L<=1;  R<=1; NL <=0; NR <=1; 	@(posedge clk);
												@(posedge clk);
												@(posedge clk);
		L<=1;  R<=1; NL <=1; NR <=0; 	@(posedge clk);
												@(posedge clk);
												@(posedge clk);
		$stop;
	end
endmodule
