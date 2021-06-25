`timescale 10ns/10ps

module counter6(
	input		 clk,rst,start,
	output reg [2:0] cnt
);

	always@(posedge clk or negedge rst)begin
		if(!rst)cnt <= 3'b000;
		else if(start == 1'b1)begin
			if(cnt== 3'b101) cnt<=cnt;
			else cnt<=cnt +1'b1;
		end
		else cnt <= 3'b000;
	end

endmodule
