`timescale 10ns/10ps

//module made to  manage input data 
module reg_in(
	input 		 clk,rst,locked,
	input 	   [7:0] a,b,
	output reg [7:0] a_out,b_out
);

	always@(posedge clk or negedge rst)begin
		if(!rst) begin a_out <= 8'b0;
			       b_out <= 8'b0;
			 end
		else if(locked == 1'b1)
			begin
				a_out<=a_out;
				b_out<=b_out;
			end
		else  	begin 
			       a_out<=a;
			       b_out<=b;
		end
	end



endmodule 
