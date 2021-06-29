`timescale 10ns/10ps

module detect_input(
	input 		 clk,
	input 	   [7:0] a,b,
	output reg [7:0] a_out,b_out,
	output reg 	 changed
);

	always@(posedge clk )begin
		a_out<=a;
		b_out<=b;

	end


	always@(*)begin
		if(a_out == a && b_out == b)begin 
			changed = 1'b0;
		end 
		else begin
			changed = 1'b1;
		end
	end

endmodule 
