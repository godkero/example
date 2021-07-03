`timescale 10ns/10ps


//to multiply 2^n
module shifter(
	input 		[7:0]   inp,
	input  		[1:0]	shift_cntrl,
	output reg 	[15:0]	outp
);

	always@(*)begin
		if(shift_cntrl == 2'b01)
			outp = {4'h0,inp,4'h0};
		else if(shift_cntrl == 2'b10)
			outp = {inp,8'h00};
		else 
			outp = {8'h00,inp};
	end

endmodule
