 module DE1_SoC(LEDR, SW, CLOCK_50, KEY, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5);
	input logic CLOCK_50; // 50MHz clock.	
	input logic [9:0] SW;
	input logic [3:0] KEY;
	output logic [9:1] LEDR; 
	output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5; 

	
	logic reset; 
	assign reset = SW[9];
	
	logic robot;

	assign HEX4 = 7'b1111111;
	assign HEX3 = 7'b1111111;
	assign HEX2 = 7'b1111111;
	assign HEX1 = 7'b1111111;

	
	logic [31:0] div_clk; 
	
	// Generate clk off of CLOCK_50, whichClock picks rate. 
	parameter whichClock = 15; // 0.75 Hz clock 
	
	clock_divider cdiv (.clock(CLOCK_50), .reset(reset), .divided_clocks(div_clk)); 
 
	// Clock selection; allows for easy switching between simulation and board clocks 
	logic clkSelect; 
	
	// Uncomment ONE of the following two lines depending on intention 
	//assign clkSelect = CLOCK_50; // for simulation 
	assign clkSelect = div_clk[whichClock]; // for board 
	

	logic rightHolder, leftHolder;
	logic outHolderR, outHolderL;
	
	twoFF playerOne (.clk(clkSelect), .reset(reset), .ffInput(~KEY[0]), .out(rightHolder));
	twoFF computer (.clk(clkSelect), .reset(reset), .ffInput(robotInput), .out(leftHolder));
	
	
	userInput playerRight  (.clk(clkSelect), .reset(reset), .in(rightHolder), .out(outHolderR));
	userInput robotPlayer (.clk(clkSelect), .reset(reset), .in(leftHolder), .out(outHolderL));


	normalLight one   (.clk(clkSelect), .reset(reset), .L(outHolderL), .R(outHolderR), .NL(LEDR[2]), .NR(0), .lightOn(LEDR[1]), .anotherRound(anotherRound)); 
	normalLight two   (.clk(clkSelect), .reset(reset), .L(outHolderL), .R(outHolderR), .NL(LEDR[3]), .NR(LEDR[1]), .lightOn(LEDR[2]), .anotherRound(anotherRound)); 
	normalLight three (.clk(clkSelect), .reset(reset), .L(outHolderL), .R(outHolderR), .NL(LEDR[4]), .NR(LEDR[2]), .lightOn(LEDR[3]), .anotherRound(anotherRound)); 
	normalLight four  (.clk(clkSelect), .reset(reset), .L(outHolderL), .R(outHolderR), .NL(LEDR[5]), .NR(LEDR[3]), .lightOn(LEDR[4]), .anotherRound(anotherRound)); 
	
	centerLight five  (.clk(clkSelect), .reset(reset), .L(outHolderL), .R(outHolderR), .NL(LEDR[6]), .NR(LEDR[4]), .lightOn(LEDR[5]), .anotherRound(anotherRound));
	
	normalLight six   (.clk(clkSelect), .reset(reset), .L(outHolderL), .R(outHolderR), .NL(LEDR[7]), .NR(LEDR[5]), .lightOn(LEDR[6]), .anotherRound(anotherRound)); 
	normalLight seven (.clk(clkSelect), .reset(reset), .L(outHolderL), .R(outHolderR), .NL(LEDR[8]), .NR(LEDR[6]), .lightOn(LEDR[7]), .anotherRound(anotherRound)); 
	normalLight eight (.clk(clkSelect), .reset(reset), .L(outHolderL), .R(outHolderR), .NL(LEDR[9]), .NR(LEDR[7]), .lightOn(LEDR[8]), .anotherRound(anotherRound)); 
	normalLight nine  (.clk(clkSelect), .reset(reset), .L(outHolderL), .R(outHolderR), .NL(0), .NR(LEDR[8]), .lightOn(LEDR[9]), .anotherRound(anotherRound)); 
	
	logic [9:0] lfsr_out; //Place holder for robot's input (waiting to be compared with SW) 
	
	LFSR random (.clk(clkSelect), .reset(reset), .Q(lfsr_out)); // output LFSR 
	
	//extend the SW and 
	// 	And call compare
	//			And return the output
	compButton extendedSW (.clk(clkSelect), .reset(reset), .Q(lfsr_out), .SW(SW[8:0]), .out(robotInput));
	
	victory gameOver (.anotherRound(anotherRound), .HEX0(HEX0), .HEX5(HEX5), .clk(clkSelect), .reset(SW[9]), .LEDR9(LEDR[9]), .LEDR1(LEDR[1]), .L(outHolderL), .R(outHolderR));
 

endmodule

module DE1_SoC_testbench();
	logic CLOCK_50;
	logic [9:0] SW;
	logic [3:0] KEY;
	logic [9:1] LEDR; 
	logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5; 

	DE1_SoC dut (.LEDR, .SW, .CLOCK_50, .KEY, .HEX0, .HEX1, .HEX2, .HEX3, .HEX4, .HEX5);

	parameter CLOCK_PERIOD = 100;
	initial begin
		CLOCK_50 <= 0;
		forever #(CLOCK_PERIOD/2) CLOCK_50 <= ~CLOCK_50;
	end
	
	

	initial begin
											@(posedge CLOCK_50);
		SW[9] <= 0;	 					@(posedge CLOCK_50);
											@(posedge CLOCK_50);
											@(posedge CLOCK_50);
		SW[9] <= 1;						@(posedge CLOCK_50);// setting the FSM to initial state. 
											@(posedge CLOCK_50);
		SW[9] <= 0; 					@(posedge CLOCK_50);
											@(posedge CLOCK_50);
		KEY[0] <= 0; SW[8:0] =9'b0000000;  @(posedge CLOCK_50);
											@(posedge CLOCK_50);
											@(posedge CLOCK_50);
		KEY[0] <= 1; 					@(posedge CLOCK_50);
											@(posedge CLOCK_50);
											@(posedge CLOCK_50);
		KEY[0] <= 0; 					@(posedge CLOCK_50);
											@(posedge CLOCK_50);
											@(posedge CLOCK_50);
		KEY[0] <= 1; 					@(posedge CLOCK_50);
											@(posedge CLOCK_50);
											@(posedge CLOCK_50);	
      KEY[0] <= 0; 					@(posedge CLOCK_50);
											@(posedge CLOCK_50);
											@(posedge CLOCK_50);
	   KEY[0] <= 1; 					@(posedge CLOCK_50);
											@(posedge CLOCK_50);
											@(posedge CLOCK_50);
		KEY[0] <= 0; 					@(posedge CLOCK_50);
											@(posedge CLOCK_50);
											@(posedge CLOCK_50);
		KEY[0] <= 1; 					@(posedge CLOCK_50);
											@(posedge CLOCK_50);
											@(posedge CLOCK_50);	
      KEY[0] <= 0; 					@(posedge CLOCK_50);
											@(posedge CLOCK_50);
											@(posedge CLOCK_50);
	   KEY[0] <= 1; 					@(posedge CLOCK_50);
											@(posedge CLOCK_50);
											@(posedge CLOCK_50);
		KEY[0] <= 0; 					@(posedge CLOCK_50);
											@(posedge CLOCK_50);
											@(posedge CLOCK_50);
		KEY[0] <= 1; 					@(posedge CLOCK_50);
											@(posedge CLOCK_50);
											@(posedge CLOCK_50);	
      KEY[0] <= 0; 					@(posedge CLOCK_50);
											@(posedge CLOCK_50);
											@(posedge CLOCK_50);
	   KEY[0] <= 1; 					@(posedge CLOCK_50);
											@(posedge CLOCK_50);
											@(posedge CLOCK_50);
		KEY[0] <= 0; 					@(posedge CLOCK_50);
											@(posedge CLOCK_50);
											@(posedge CLOCK_50);
		SW[9] <= 1;						@(posedge CLOCK_50);// setting the FSM to initial state. 
											@(posedge CLOCK_50);
		SW[9] <= 0; 					@(posedge CLOCK_50);
											@(posedge CLOCK_50);
											
		KEY[0] <= 0; SW[8:0] =9'b0111111110;  @(posedge CLOCK_50);
											@(posedge CLOCK_50);
											@(posedge CLOCK_50);
											@(posedge CLOCK_50);
											@(posedge CLOCK_50);
											@(posedge CLOCK_50);
											@(posedge CLOCK_50);		
											@(posedge CLOCK_50);
											@(posedge CLOCK_50);
											@(posedge CLOCK_50);	
											@(posedge CLOCK_50);
											@(posedge CLOCK_50);
											@(posedge CLOCK_50);	
											@(posedge CLOCK_50);
											@(posedge CLOCK_50);
											@(posedge CLOCK_50);
											@(posedge CLOCK_50);
											@(posedge CLOCK_50);
											@(posedge CLOCK_50);	
											@(posedge CLOCK_50);
											@(posedge CLOCK_50);
											@(posedge CLOCK_50);	
											@(posedge CLOCK_50);
											@(posedge CLOCK_50);
											@(posedge CLOCK_50);	
											@(posedge CLOCK_50);
											@(posedge CLOCK_50);	
											@(posedge CLOCK_50);
											@(posedge CLOCK_50);
											@(posedge CLOCK_50);	
											@(posedge CLOCK_50);
											@(posedge CLOCK_50);
											@(posedge CLOCK_50);
											@(posedge CLOCK_50);
											@(posedge CLOCK_50);
											@(posedge CLOCK_50);
											
				
		 $stop; // End the simulation.
	 end

endmodule