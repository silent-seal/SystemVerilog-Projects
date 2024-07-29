module twoFF (clk, reset, ffInput, out);
	input logic clk, reset, ffInput;
	output logic out;
	

	logic ffout;
	
//	always_ff @(posedge clk) begin
//			if (reset) 
//				ffout = 0;
//				
//			else 
//				ffout <= ffInput;
//	end
//	
//	always_ff @(posedge clk) begin
//			if (reset) 
//				ffout = 0;
//				
//			else 
//				out <= ffout;
//	end
	
	
	always_ff @(posedge clk) begin
			if (reset) begin
				ffout <= 0;
				out <= 0; // Reset out as well if needed
			end
			
			else begin
				ffout <= ffInput;
				out <= ffout;
			end
	end
	
endmodule