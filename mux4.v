`timescale 10ns/10ps

module mux4(
	input  [3:0] 	mux_in_a,mux_in_b,
	input 	  	mux_sel,
	output [3:0]	mux_out
);

	assign mux_out = (mux_sel==1'b1) ? mux_in_a[3:0] : mux_in_b[3:0];

endmodule
