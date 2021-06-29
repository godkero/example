`timescale 10ns/10ps

module tb_top;

	reg 	   	clk,rst,start;
	reg 	[7:0] 	a,b;
	
	wire 	[15:0] 	d_out;
	wire        	done;
	wire    [7:0]  	seg_position;


	top top0(.clk(clk),
	    .rst(rst),
	    .start(start),
	    .a(a),
	    .b(b),
	    .d_out(d_out),
	    .done_flag(done),
		.seg_position(seg_position)
		);

	initial begin
		$monitor(" time:%t %d * %d  Calculated=%d ,done_flag = %d",$time, a,b,d_out,done);
		a = 8'b10000001;
		b = 8'b00010011;

		#100
		a = 8'hf0;
		b = 8'h35;
		#200 
		a = 8'h0f;
		b = 8'h44;
		#200 
		a = 8'hff;
		b = 8'h00;
		#200 
		a = 8'hff;
		b = 8'hf1;
		#200 
		a = 8'hab;
		b = 8'hcd;
		#200 
		a = 8'h11;
		b = 8'h11;
	end

	
	initial begin 
		rst = 1 ;
		clk = 0 ;
		start = 0;
 	  #10	rst = 0 ;
	  #10 	rst = 1 ;
	  #100	start = 1; 
	  #2000 $finish;
	 end
	
	/*
 * 	initial
    	begin
        $dumpfile("tb_top.vcd");
        $dumpvars(0,tb_top);
    	end
*/

	always #5 clk = ~clk ; 



endmodule
