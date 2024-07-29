 module DE1_SoC(LEDR, SW, CLOCK_50, KEY);
	input logic CLOCK_50; // 50MHz clock.
	// Q1. DO I need reset when I have ClOCK_50?
	
	output logic [3:0] LEDR; //descriptive names 
	input logic [1:0] SW;
	input logic [3:0] KEY;
	
	logic reset; 
	assign reset = ~KEY[0];
	logic [31:0] div_clk; 
	
//	enum logic [2:0] { A = 3'b101, B = 3'b010, C= 3'b001, D= 3'b100 } ps, ns;
	enum { A , B, C, D } ps, ns;

	always_comb begin
		case(ps)
			// A = 101
			A:	ns = B;
			
			// B = 010 
			B:	if (~SW[1] & ~SW[0])
					ns = A;
					
				else if (SW[1] & ~SW[0])
					ns = C;
					
				else 
					ns = D;
			
			// C = 001
			C:	if (SW[1] & ~SW[0]) 
			// Can I put just ~SW[0] without the SW[1]
					ns = D;
				else
					ns = B;
			
			// D = 100
			D:	if (~SW[1] & SW[0])
			// or can I just (~SW[1])
					ns = C;
				else 
					ns = B;
		endcase
	end
	// case statement 
	//case(ps)
		//if A: LEDR[2] = 3'b010
	
 
	// Generate clk off of CLOCK_50, whichClock picks rate. 
  
	
	parameter whichClock = 25; // 0.75 Hz clock 
	
	clock_divider cdiv (.clock(CLOCK_50), .reset(reset), .divided_clocks(div_clk)); 
 
 // Clock selection; allows for easy switching between simulation and board clocks 
	logic clkSelect; 
	
	// Uncomment ONE of the following two lines depending on intention 
//	assign clkSelect = CLOCK_50; // for simulation 
   assign clkSelect = div_clk[whichClock]; // for board 
	
	
 
	assign LEDR[0] = (ps==A)|(ps==C);
	assign LEDR[1] = (ps==B);
	assign LEDR[2] = (ps==A)|(ps==D);
	assign LEDR[3] = clkSelect;

	always_ff @(posedge clkSelect) begin // !!!!!!which clk should I use? clock_50?????
		if (reset)
			ps <= A;
		else
			ps <= ns;
	end

endmodule

module DE1_SoC_testbench();
	logic CLOCK_50;
	logic [1:0] SW;
	logic [3:0] LEDR;
	logic [3:0] KEY;
//	logic clkSelect, reset;

	DE1_SoC dut (.LEDR, .SW, .CLOCK_50, .KEY);

	parameter CLOCK_PERIOD = 100;
	initial begin
		CLOCK_50 <= 0;
		forever #(CLOCK_PERIOD/2);
		CLOCK_50 <= ~CLOCK_50;
	end

	initial begin
		@(posedge CLOCK_50);
		KEY[0] <= 0;	 @(posedge CLOCK_50);
		KEY[0] <= 1;	 @(posedge CLOCK_50);// setting the FSM to initial state. 
		
		SW <= 2'b00; @(posedge CLOCK_50);// case 1, input is 00
						 @(posedge CLOCK_50);
						 @(posedge CLOCK_50);
		SW <= 2'b01; @(posedge CLOCK_50);// case 2, input is 01
						 @(posedge CLOCK_50);
						 @(posedge CLOCK_50);
		SW <= 2'b10; @(posedge CLOCK_50);// case 3, input is 10
						 @(posedge CLOCK_50);
						 @(posedge CLOCK_50);
		SW<= 2'b10; @(posedge CLOCK_50);
						@(posedge CLOCK_50);
						 @(posedge CLOCK_50);
		SW<= 2'b01;  @(posedge CLOCK_50);
		SW<= 2'b10;  @(posedge CLOCK_50);
		SW<= 2'b00;  @(posedge CLOCK_50);
						@(posedge CLOCK_50);
						@(posedge CLOCK_50);
		SW<= 2'b00;  @(posedge CLOCK_50);
		 $stop; // End the simulation.
	 end

endmodule