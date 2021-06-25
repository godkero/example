`timescale 10ns/10ps

module tb_count4;

	reg clk,rst_n;
	wire [1:0] cnt;


	count4 u0(clk,rst_n,cnt);

	always begin
	#5 clk = ~clk;
	end

	initial begin
	clk = 0;
	rst_n = 1;
	#14 rst_n = 0;
	#10 rst_n = 1;
	#10000 $finish;
	end


endmodule
