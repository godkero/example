`timescale 10ns/10ps

module shifter(
	input 		[7:0]   inp,
	input  		[1:0]	shift_cntrl,
	output reg 	[15:0]	outp
);

	always@(shift_cntrl)begin
		if(shift_cntrl == 2'b01)
			outp = inp<<4;
		else if(shift_cntrl == 2'b10)
			outp = inp<<8;
		else 
			outp = inp;
	end

endmodule
