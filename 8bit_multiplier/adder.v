`timescale 10ns/10ps

module adder (
	output [15:0] sum,
	input [15:0]  dataa, datab
);
	
	assign sum = dataa+datab;

endmodule
