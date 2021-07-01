`timescale 10ns/10ps

module counter6(
	input		 clk,rst,start,changed,
	output reg [2:0] cnt
);

	
	always@(posedge clk or negedge rst)begin
		if(!rst)				cnt <= 3'b000;
		//else if(changed == 1'b1 && cnt != 3'b000)		cnt <= 3'b111;
		//else if(cnt == 3'b111) 			cnt <= 3'b001; 
		else if(start == 1'b1 && cnt == 3'b000) cnt<=cnt +1'b1;
		else if(cnt == 3'b101)			cnt <= 3'b000;
		else if(cnt != 3'b000)			cnt <= cnt + 3'b001;
		else 					cnt <= 3'b000;		
	end

endmodule
