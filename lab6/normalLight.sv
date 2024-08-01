module normalLight (clk, reset, L, R, NL, NR, lightOn); 
	input logic clk, reset; 
	input logic L, R, NL, NR;
	output logic lightOn;
 

	enum {on, off} ps, ns;
	
	always_comb begin
		case(ps)
		
			on: if (R ^ L) ns = off;
				 else ns = on;
				 
			off: if (L & NR & ~R | R & NL & ~L) ns = on;
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
		if (reset) 
			ps <= off; 
		else 
			ps <= ns; 
	end 


endmodule

module normalLight_testbench();
	logic clk, reset;
	logic L, R, NL, NR;
	logic lightOn;
	
	normalLight dut(.clk, .reset, .L, .R, .NL, .NR, .lightOn); 
	
	
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
		L<=1;  R<=1; NL <=0; NR <=0; 	@(posedge clk);
												@(posedge clk);
												@(posedge clk);
		reset <= 0;							@(posedge clk);
												@(posedge clk);
												@(posedge clk);
		L<=0;  R<=0; NL <=0; NR <=0; 	@(posedge clk);
												@(posedge clk);
												@(posedge clk);
		L<=0;  R<=0; NL <=0; NR <=1;	@(posedge clk);
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
		L<=0;  R<=1; NL <=1; NR <=0;	@(posedge clk);
												@(posedge clk);
												@(posedge clk);
												
												
		L<=1;  R<=0; NL <=0; NR <=0; 	@(posedge clk);
												@(posedge clk);
												@(posedge clk);
		L<=1;  R<=0; NL <=0; NR <=1;	@(posedge clk);
												@(posedge clk);
												@(posedge clk);
		L<=1;  R<=0; NL <=1; NR <=0; 	@(posedge clk);
												@(posedge clk);
												@(posedge clk);
												
												
		L<=1;  R<=1; NL <=0; NR <=0;	@(posedge clk);
												@(posedge clk);
												@(posedge clk);
		L<=1;  R<=1; NL <=0; NR <=1;	@(posedge clk);
												@(posedge clk);
												@(posedge clk);
		L<=1;  R<=1; NL <=1; NR <=0; 	@(posedge clk);
												@(posedge clk);
												@(posedge clk);	
		$stop;
	end 

endmodule
	
	
	
	
	
	
	
	
	
	
	