`timescale 10ns/10ps

// top module of this design
module top
(
	input 		clk,rst,start,
	input 	[7:0] 	a,b,
	output 	[15:0] 	d_out,
	output 		locked,
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

	//input data register
	/*
	if locked : register dose not change
	else      : when clk is posedge edge , a_out <= a
	 */
	reg_in  dectector(.clk(clk),
				.rst(rst),
				.locked(locked),
				.a(a),
				.b(b),
				.a_out(a_in),
				.b_out(b_in)
			);				
	

	//combination logic
	//mux a,b
	/*
	receive [7:0] vector , divide [7:4] , [3:0]
	send data[3:0] data , data depending on mux_sel
	 */
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

	//input 4bit data a,b
	//output 8bit data a*b
	//product
	mult4to4 mul0(.dataa(aout),
				  .datab(bout),
				  .product(product)
			);

	//input data :8bit data a*b
	//8bit shift, 4bit shift, 0 depending on shift_cntrl
	//shift value
	shifter shifter0(.inp(product),
				     .shift_cntrl(sel_shift),
					 .outp(s_out)
					 );
	data_selector d_sel0(.d_in(d_out),
						 .data_sel(data_sel),
						 .p_out(data_sel_out)
						);
	/*
	input dataa <= shifter data
	input datab <= reg_out data or 0
	excute summation 
	 */
	//add sum
	adder adder0(.sum(sum),
				 .dataa(s_out),
				 .datab(data_sel_out)
				 );	

	//////////////////////////////////////////////////	
	
	reg_out data0(.clk(clk),
			.rst(rst),
			.clk_ena(clk_en),
			.d(sum),
			.p(d_out)
			); 
	

	//FSM output logic change depending state
	counter6 counter(.clk(clk),
			.rst(rst),
			.start(start),
			.cnt(cnt)
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
	////////////////////////////

	//7-seg is change depending on state
	seven_seg_cntrl seven_seg0(.inp(state),.seg_position(seg_position));
	
	//At testbench, to check expected value 
	assign verif_a = a_in;
	assign verif_b = b_in;

endmodule
