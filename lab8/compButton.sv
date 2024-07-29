module compButton(clk, reset, Q, SW, out);
	output logic out;
	input logic clk, reset;
	input logic [9:0] Q; //LFSR generated input
	input logic [8:0] SW;
	
	logic [9:0] SW_extend;
	
	assign SW_extend = {1'b0, SW}; 
	
	// Since we seted up the switch.
	// compare the SW value and the Robot input(LFSR)
	comparator computer(.clk, .reset, .A(SW_extend), .B(Q), .value_final(out)); 
	
	
endmodule







module compButton_testbench();
	logic out;
	logic clk, reset;
	logic [9:0] Q;
	logic [8:0] SW;
	logic [9:0] SW_extend;
	
	compButton dut(.clk, .reset, .Q, .SW, .out);
	
	parameter CLOCK_PERIOD = 100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD / 2) 
		clk <= ~clk;
	end
	
	initial begin
		reset <= 1;											@(posedge clk);
																@(posedge clk);
		reset <= 0;											@(posedge clk);
																@(posedge clk);
		Q = 10'b0000000001;	SW = 9'b000000010;	@(posedge clk);
																@(posedge clk);
		Q = 10'b0000000011;								@(posedge clk);
																@(posedge clk);
		$stop;
	end
endmodule