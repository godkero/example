`timescale 10ns/10ps

module counter6(
	input		 clk,rst,start,
	output reg [2:0] cnt
);

	//if start signal is not enter, cnt (=0) never change
	//if cnt ==6(101) next cnt is become 0
	always@(posedge clk or negedge rst)begin
		if(!rst)				cnt <= 3'b000;
		else if(start == 1'b1 && cnt == 3'b000) cnt<=cnt +1'b1;
		else if(cnt == 3'b101)			cnt <= 3'b000;
		else if(cnt != 3'b000)			cnt <= cnt + 3'b001;
		else 					cnt <= 3'b000;		
	end

endmodule
