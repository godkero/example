`timescale 10ns/10ps


//module made to manage data_out 
module reg_out(
	input 		  clk,rst,clk_ena,
	input 	   [15:0] d,
	output reg [15:0] p
);

	always@(posedge clk or negedge rst)begin
		if(rst == 1'b0) p <= 16'h0;
		else if(clk_ena ==1'b1) p <= d;
		else p <= p;
	end

	

endmodule   
