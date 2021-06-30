`timescale 10ns/10ps

module tb_top;

	reg 	   	clk,rst,start;
	reg 	[7:0] 	a,b;


	wire    [7:0]   a_in,b_in;
	reg     [15:0]  c;	
	wire 	[15:0] 	d_out;
	wire        	done;
	wire 		locked;
	wire    [7:0]  	seg_position;


	top top0(.clk(clk),
	    .rst(rst),
	    .start(start),
	    .a(a),
	    .b(b),
	    .locked(locked),
	    .d_out(d_out),
	    .done_flag(done),
		.seg_position(seg_position)
		);

	initial begin
		//$monitor(" time:%t %d * %d  Calculated=%d Expected = %d,done_flag = %d",$time, a,b,d_out,a*b,done);
		a = 8'b10000001;
		b = 8'b00010011;

		#100
		a = $urandom%256;
		b = $urandom%256;
		#200 
		a = $urandom%256;
		b = $urandom%256;
		#200 
		a = $urandom%256;
		b = $urandom%256;
		#200 
		a = $urandom%256;
		b = $urandom%256;
		#200 
		a = $urandom%256;
		b = $urandom%256;
		#150
		a = $urandom%256;
		b = $urandom%256;
		#150
		a = $urandom%256;
		b = $urandom%256;
		

		
	end

	
	initial begin 
		rst  =  1 ;
		clk  =  0 ;
	  	start=  0;
 	  #10	rst  =  0 ;
	  #5 	rst  =  1 ;
	  #10	start=  1; 
	  #2000 $finish;
	 end
	
	/*
 * 	initial
    	begin
        $dumpfile("tb_top.vcd");
        $dumpvars(0,tb_top);
    	end
*/

	always  #5 clk = ~clk ; 
	

	assign a_in = (locked == 1'b1)?8'bZ:a;
	assign b_in = (locked == 1'b1)?8'bZ:b;

	
	always@(posedge done)begin
			$display(" time:%t %d * %d  Calculated=%d Expected = %d,done_flag = %d",$time, a,b,d_out,c,done);

	end

	always@(posedge clk or negedge rst)begin
		if(!rst) c<=16'b0;
		else c<=a*b;
	end
endmodule
