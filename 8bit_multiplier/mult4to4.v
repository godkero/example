`timescale 10ns/10ps

module mult4to4(
	input [3:0] dataa,datab,
	output [7:0] product
);


	assign product[7:0] = dataa[3:0]*datab[3:0];

endmodule
