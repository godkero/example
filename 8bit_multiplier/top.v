`timescale 10ns/10ps


module top
(
	input 		clk,rst,start,
	input 	[7:0] 	a,b,
	output 	[15:0] 	d_out,
	output 		locked,changed,
	output 		done_flag,
	output  [7:0]   seg_position,
	output  [7:0]   verif_a,verif_b

);	
	wire    [7:0]   a_in,b_in;
	wire        	clk_en;	
	wire    [2:0]   cnt;
	wire 			sela,selb;
	wire        	data_sel;
	wire    [1:0]	sel_shift;
	wire    [7:0]   product;
	wire 	[3:0] 	aout,bout;
	wire    [2:0]   state;
	wire    [15:0]  sum;
	wire  	[15:0]	s_out;
	wire	[15:0] 	data_sel_out;	
	reg_in  dectector(.clk(clk),
				.rst(rst),
				.locked(locked),
				.a(a),
				.b(b),
				.a_out(a_in),
				.b_out(b_in),
				.changed(changed)
			);				

	//mux a,b
	mux4 mux_a(.mux_in_a(a_in[7:4]),
			   .mux_in_b(a_in[3:0]),
			   .mux_sel(sela), 
			   .mux_out(aout)
			   );
	mux4 mux_b(.mux_in_a(b_in[7:4]),
			   .mux_in_b(b_in[3:0]),
			   .mux_sel(selb), 
			   .mux_out(bout)
			   );
	//product
	mult4to4 mul0(.dataa(aout),
				  .datab(bout),
				  .product(product)
				  );
	//shift value
	shifter shifter0(.inp(product),
				     .shift_cntrl(sel_shift),
					 .outp(s_out)
					 );
	data_selector d_sel0(.d_in(d_out),
						 .data_sel(data_sel),
						 .p_out(data_sel_out)
						);

	//add sum
	adder adder0(.sum(sum),
				 .dataa(s_out),
				 .datab(data_sel_out)
				 );	
		
	reg_out data0(.clk(clk),
			.rst(rst),
			.clk_ena(clk_en),
			.d(sum),
			.p(d_out)
			); 
	
	control con0(.clk(clk),
		     	 .rst(rst),
		     	 .start(start),
		     	 .count(cnt),
			 .locked(locked),
			 .data_sel(data_sel),
			 .clk_en(clk_en),
		     	 .state(state),
	  	     	 .sela(sela),
		     	 .selb(selb),
			 .changed(changed),
		     	 .sel_shifter(sel_shift),
		     	 .done_flag(done_flag)
		   );
	counter6 counter(.clk(clk),.changed(changed),
		  			 .rst(rst),
		  			 .start(start),
				 	 .cnt(cnt)
					 );	

	seven_seg_cntrl seven_seg0(.inp(state),.seg_position(seg_position));
	
	assign verif_a = a_in;
	assign verif_b = b_in;

endmodule
