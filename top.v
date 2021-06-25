`timescale 10ns/10ps



module top
(
	input 		clk,rst,start,
	input 	[7:0] 	a,b,
	output 	[15:0] 	d_out,
	output 		done
);
	

	wire            clk_en;
	wire    [2:0]   cnt;
	wire 		sela,selb;
	wire    [1:0]	sel_shift;
	wire    [7:0]   product;
	wire 	[3:0] 	aout,bout;
	wire    [2:0]   state;
	wire    [15:0]  sum;
	wire  	[15:0]	value;
	wire	[15:0] 	s_out;	
	
	//mux a,b
	mux4 mux_a(a[7:4],a[3:0],sela, aout);
	mux4 mux_b(b[7:4],b[3:0],selb, bout);
	//product
	mult4to4 mul0(aout,bout,product);
	//shift value
	shifter shifter0(product,sel_shift,s_out);
	
	assign sum = (state ==3'b000) ? 0 : d_out;
	assign clk_en = done? 1'b0 : 1'b1;	

	//add sum
	adder adder0(.sum(value),.dataa(s_out),.datab(sum));	
		
	reg_16bit data0(.clk(clk),
			.rst(rst),
			.clk_ena(clk_en),
			.d(value),
			.p(d_out)
			); 
	
	control con0(.clk(clk),
		     .rst(rst),
		     .start(start),
		     .count(cnt),
		     .state(state),
	  	     .sela(sela),
		     .selb(selb),
		     .sel_shifter(sel_shift),
		     .done_flag(done)
		   );
	counter6 counter(.clk(clk),
		  .rst(rst),
		  .start(start),
 		  .cnt(cnt)
		  );	


endmodule