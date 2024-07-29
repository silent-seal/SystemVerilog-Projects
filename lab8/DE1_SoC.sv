module DE1_SoC (CLOCK_50, KEY, SW, GPIO_1, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, LEDR);   
	input  logic         CLOCK_50;   // 50MHz clock.  
	input  logic  [3:0]  KEY;                                 
	input  logic  [9:0]  SW;  
   output logic  [35:0] GPIO_1; 		// 36-pin GPIO1	
	output logic  [6:0]  HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;    
	output logic  [9:0]  LEDR;
    
  
	logic [31:0] div_clk;
   logic reset;
	assign reset = SW[9];		//reset at SW9 
	
	assign HEX1 = 7'b1111111;  //Leave HEX0 and HEX5 display score
   assign HEX2 = 7'b1111111; 
   assign HEX3 = 7'b1111111; 
   assign HEX4 = 7'b1111111;
	
	

   logic L, R;
	logic [7:0] inputKey;
	
	
	logic clk;

	logic oneWin;	//place holder for getting one win. 
	


//Divide clocks here 	
	// Generate clk off of CLOCK_50, whichClock picks rate. 
	parameter whichClock = 15; //768 Hz
	
	clock_divider cdiv (.clock(CLOCK_50), .reset(reset), .divided_clocks(div_clk));
	
	// Uncomment ONE of the following two lines depending on intention 
	//assign clk = CLOCK_50; // for simulation 
	
   assign clk = div_clk[whichClock]; // for board 

	 
	 
	 // Set up LED board driver

	 logic [15:0][15:0]RedPixels; // 16 x 16 array representing red LEDs
    logic [15:0][15:0]GrnPixels; // 16 x 16 array representing green LEDs
	 logic RST;                   // reset - toggle this on startup
	 
	 //LED Driver instantiation, just leave it there. 
	     
	 LEDDriver Driver (.CLK(SYSTEM_CLOCK), .RST(reset), .EnableCount(1'b1), .RedPixels, .GrnPixels, .GPIO_1);
	 
	 
							 

	//player red 
	inputHolder i1(.Clock(clk), .reset(reset), .L(SW[8]), .R(SW[7]), .nextL(inputKey[3]), .nextR(inputKey[2])); // left 2 for red player
	inputHolder i2(.Clock(clk), .reset(reset), .L(SW[6]), .R(SW[5]), .nextL(inputKey[1]), .nextR(inputKey[0])); // right 2 for red player
	
	//player green 
	inputHolder i3(.Clock(clk), .reset(reset), .L(SW[3]), .R(SW[2]), .nextL(inputKey[7]), .nextR(inputKey[6])); // left 2 for green player
	inputHolder i4(.Clock(clk), .reset(reset), .L(SW[1]), .R(SW[0]), .nextL(inputKey[5]), .nextR(inputKey[4])); // right 2 for green player
	
	
	LED_test test (.clk(clk), .RST((reset|oneWin)), .RedPixels, .GrnPixels, .inputKey, .SW(SW[1:0]));
	
	
	displayWin winner (.clk(clk), .RST(reset), .RedPixels, .GrnPixels, .outputGreen(HEX0), .outputRed(HEX5), .oneWin);
	 
	

	
endmodule
	 
module DE1_SoC_testbench();  
  logic         CLOCK_50;   
  logic  [6:0]  HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;    
  logic  [9:0]  LEDR;
  logic  [35:0] GPIO_1;  
  logic  [3:0]  KEY; 
  logic  [9:0]  SW;  
  
 DE1_SoC dut (CLOCK_50, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, GPIO_1, SW);  
   
 // Set up a simulated clock.   
	parameter CLOCK_PERIOD=50;   
	initial begin    
	   CLOCK_50 <= 0;    
		forever #(CLOCK_PERIOD/2) CLOCK_50 <= ~CLOCK_50; 
	end 
 
   
 // Test the design.
integer i; 
 initial begin   

	for(i = 0; i <512; i++) begin
	SW[9] <= 1; @(posedge CLOCK_50); 
   SW[9] <= 0; SW[8:0] = i; @(posedge CLOCK_50);
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
					
					//I set the value back to 0 this way it ensures that the next time
					//the button is pressed again so it actually causes a change
					SW[8:0] = 9'b000000000; @(posedge CLOCK_50);   
                      @(posedge CLOCK_50); 

				
				
	  end

  
  $stop; // End the simulation.  
 end 
 
 endmodule 