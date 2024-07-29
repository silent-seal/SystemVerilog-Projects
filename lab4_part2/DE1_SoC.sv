// Top-level module that defines the I/Os for the DE-1 SoC board

module DE1_SoC (HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW);
	output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	output logic [9:0] LEDR;
	input logic [3:0] KEY;
	input logic [9:0] SW;
	

	
	// Lab 3 stuff
	// Sw9 = U; Sw8 = P; Sw7 = C
	// Sw0 = Secrete Mark
	assign LEDR[0] = (SW[8]| SW[9] & SW[7]); //discount
	assign LEDR[1] = (~(SW[0]|SW[8])&(~SW[7] | SW[9]));//Stolen
	
	// Lab 4
	always_comb
		case(SW[9:7])  
		
		3'b000: begin
					HEX5 = 7'b0001100; //P
					HEX4 = 7'b0001001; //H
					HEX3 = 7'b1000000; //O
					HEX2 = 7'b1001000; //N
					HEX1 = 7'b0000110; //E
					HEX0 = 7'b1111111; //Off
		end
					
		3'b001: begin
					HEX5 = 7'b0001100; //P
					HEX4 = 7'b0001000; //A
					HEX3 = 7'b0001100; //P
					HEX2 = 7'b0000110; //E
					HEX1 = 7'b1001110; //r
					HEX0 = 7'b1111111; //Off
		end
		
		3'b010: begin
					HEX5 = 7'b0001001; //H
					HEX4 = 7'b0001000; //A
					HEX3 = 7'b1111000; //T
					HEX2 = 7'b1111110; //T
					HEX1 = 7'b1111111; //off
					HEX0 = 7'b1111111; //Off
		end
					
		3'b011: begin
					HEX5 = 7'b0001100; //P
					HEX4 = 7'b0001000; //A
					HEX3 = 7'b1001000; //N
					HEX2 = 7'b1111000; //T
					HEX1 = 7'b1111110; //T
					HEX0 = 7'b0010010; //s
		end
					
		3'b100: begin
					HEX5 = 7'b1000111; //L
					HEX4 = 7'b0000110; //E
					HEX3 = 7'b0100001; //d
					HEX2 = 7'b1111111; //off
					HEX1 = 7'b1111111; //off
					HEX0 = 7'b1111111; //Off
		end
					
		3'b101: begin
					HEX5 = 7'b0010001; //y
					HEX4 = 7'b1000000; //o
					HEX3 = 7'b0010001; //y
					HEX2 = 7'b1000000; //o
					HEX1 = 7'b1111111; //off
					HEX0 = 7'b1111111; //Off
		end
		
		default: begin
					HEX5 = 7'bx; 
					HEX4 = 7'bx;
					HEX3 = 7'bx; 
					HEX2 = 7'bx; 
					HEX1 = 7'bx;
					HEX0 = 7'bx; 
		end
		endcase

endmodule

module DE1_SoC_testbench();
	logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	logic [9:0] LEDR;
	logic [3:0] KEY;
	logic [9:0] SW;
	
	DE1_SoC dut (.HEX0, .HEX1, .HEX2, .HEX3, .HEX4, .HEX5, .KEY, .LEDR, .SW);

// Try all combinations of inputs.
	integer i;
	initial begin
		SW[1] = 1'b0;
		SW[2] = 1'b0;
		SW[3] = 1'b0;
		SW[4] = 1'b0;
		SW[5] = 1'b0;
		SW[6] = 1'b0;
		
		for(i = 0; i <16;i++) begin
			{SW[9:7], SW[0]} = i; #10;
		end
	end
	endmodule