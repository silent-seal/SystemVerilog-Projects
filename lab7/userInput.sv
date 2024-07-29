module userInput (clk, reset, in, out); 
	input logic clk, reset, in;
	output logic out;
 
 
	enum {on, off} ps, ns;
	
	// DFFs 
	always_ff @(posedge clk) begin 
		if (reset) 
			ps <= off; //reset to off
		else 
			ps <= ns; 
	end 

	
	always_comb begin
		case(ps)  // start from off
				on: if (in) ns = on; //out = 0 
					 else ns  = off;  //out = 1
					 
				off: if (in) ns = on;//out = 0
					 else ns  = off;  //out = 0

		endcase
	end
	

	
	assign out = (ps == on & ns == off);  
	
	
endmodule






module userInput_testbench();
	logic clk, reset, in;
	logic out;
	
	userInput dut (.clk, .reset, .in, .out);
	
	parameter CLOCK_PERIOD = 100;
		initial begin
			clk <= 0;
		forever #(CLOCK_PERIOD/2);
			clk <= ~clk;
	end
	
	
	initial begin 
								@(posedge clk);
		reset <= 1; 		@(posedge clk);
								@(posedge clk);
		reset <= 0;       @(posedge clk);
								@(posedge clk);
								@(posedge clk);
		in <= 1;			@(posedge clk);
								@(posedge clk);
								@(posedge clk);
		in <= 0;       @(posedge clk);
								@(posedge clk);
								@(posedge clk);
		in <= 1;			@(posedge clk);
								@(posedge clk);
								@(posedge clk);
		in <= 0;			@(posedge clk);
								@(posedge clk);
								@(posedge clk);
		in <= 1;			@(posedge clk);
								@(posedge clk);
								@(posedge clk);
		in <= 0;       @(posedge clk);
								@(posedge clk);
								@(posedge clk);
		in <= 1;			@(posedge clk);
								@(posedge clk);
								@(posedge clk);
		in <= 0;       @(posedge clk);
								@(posedge clk);
								@(posedge clk);					
		$stop;
	end
	
endmodule
