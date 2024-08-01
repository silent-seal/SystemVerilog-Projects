module twoFF (clk, reset, ffInput, out);
	input logic clk, reset, ffInput;
	output logic out;
	

	logic ffout;
	
	always_ff @(posedge clk) begin
				if (reset) 
				ffout = 0;
				
				else 
				ffout <= ffInput;
	end
	
	always_ff @(posedge clk) begin
				if (reset) 
				ffout = 0;
				
				else 
				out <= ffout;
	end
	
endmodule