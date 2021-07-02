`timescale 10ns/10ps

module tb_top;

	reg 	   	clk,rst,start;
	reg 	[7:0] 	tb_a,tb_b;
//	reg 		changed;
	wire 		changed;
	wire    [7:0]   verif_a,verif_b;
	wire    [7:0]   tb_a_in,tb_b_in;
	reg     [15:0]  c;	
	reg 		sync_start;
	wire 	[15:0] 	d_out;
	reg    [7:0]   tb_a_sync,tb_b_sync;
	wire        	done;
	wire 		locked;
	wire    [7:0]  	seg_position;


	top top0(.clk(clk),
	    .rst(rst),
	    .start(sync_start),
	    .a(tb_a_sync),
	    .b(tb_b_sync),
	    .locked(locked),
	    .d_out(d_out),
	    .done_flag(done),
		.seg_position(seg_position),
		.verif_a(verif_a),.verif_b(verif_b)
		);

	initial begin
		//$monitor(" time:%t %d * %d  Calculated=%d Expected = %d,done_flag = %d, changed = %d",$time, a,b,d_out,a*b,done);
		$display("TopA(inA) * TopB(inB) result   	      Expected         change     time");
		tb_a = 8'b10000001;
		tb_b = 8'b00010011;
		start = 0;
		#100
		start = $urandom%2;
		tb_a = $urandom%256;
		tb_b = $urandom%256;
		if(start == 1'b1)@(posedge clk) start = ~start;
		#10 
		start = $urandom%2;
		tb_a = $urandom%256;
		tb_b = $urandom%256;
		if(start == 1'b1)@(posedge clk) start = ~start;
		#20 
		start = $urandom%2;
		tb_a = $urandom%256;
		tb_b = $urandom%256;
		if(start == 1'b1)@(posedge clk) start = ~start;
		#30 
		start = $urandom%2;
		tb_a = $urandom%256;
		tb_b = $urandom%256;
		if(start == 1'b1)@(posedge clk) start = ~start;
		#43 
		start = $urandom%2;
		tb_a = $urandom%256;
		tb_b = $urandom%256;
		if(start == 1'b1)@(posedge clk) start = ~start;
		#57
		start = $urandom%2;
		tb_a = $urandom%256;
		tb_b = $urandom%256;
		if(start == 1'b1)@(posedge clk) start = ~start;
		#62
		start = $urandom%2;
		tb_a = $urandom%256;
		tb_b = $urandom%256;
		if(start == 1'b1)@(posedge clk) start = ~start;
		#78
		start = $urandom%2;
		tb_a = $urandom%256;
		tb_b = $urandom%256;
		if(start == 1'b1)@(posedge clk) start = ~start;
		#80
		start = $urandom%2;
		tb_a = $urandom%256;
		tb_b = $urandom%256;
		if(start == 1'b1)@(posedge clk) start = ~start;
		#90
		start = $urandom%2;
		tb_a = $urandom%256;
		tb_b = $urandom%256;
		if(start == 1'b1)@(posedge clk) start = ~start;
		#100
		start = $urandom%2;
		tb_a = $urandom%256;
		tb_b = $urandom%256;
		if(start == 1'b1)@(posedge clk) start = ~start;
		#110	
		start = $urandom%2;
		tb_a = $urandom%256;
		tb_b = $urandom%256;
		if(start == 1'b1)@(posedge clk) start = ~start;
		#120 
		start = $urandom%2;
		tb_a = $urandom%256;
		tb_b = $urandom%256;
		if(start == 1'b1)@(posedge clk) start = ~start;
		#130 
		start = $urandom%2;
		tb_a = $urandom%256;
		tb_b = $urandom%256;
		if(start == 1'b1)@(posedge clk) start = ~start;
		#140 
		start = $urandom%2;
		tb_a = $urandom%256;
		tb_b = $urandom%256;
		if(start == 1'b1)@(posedge clk) start = ~start;
		#150
		start = $urandom%2;
		tb_a = $urandom%256;
		tb_b = $urandom%256;
		if(start == 1'b1)@(posedge clk) start = ~start;
		#160
		start = $urandom%2;
		tb_a = $urandom%256;
		tb_b = $urandom%256;
		if(start == 1'b1)@(posedge clk) start = ~start;
		#170
		start = $urandom%2;
		tb_a = $urandom%256;
		tb_b = $urandom%256;
		if(start == 1'b1)@(posedge clk) start = ~start;
		#180
		start = $urandom%2;
		tb_a = $urandom%256;
		tb_b = $urandom%256;
		if(start == 1'b1)@(posedge clk) start = ~start;
		#190
		start = $urandom%2;
		tb_a = $urandom%256;
		tb_b = $urandom%256;
		if(start == 1'b1)@(posedge clk) start = ~start;
		#200
		start = $urandom%2;
		tb_a = $urandom%256;
		tb_b = $urandom%256;		
		if(start == 1'b1)@(posedge clk) start = ~start;

	end
	
	initial begin 
		rst  =  1 ;
		clk  =  0 ;
 	  #10	rst  =  0 ;
	  #5 	rst  =  1 ;
	  #5000 $finish;
	 end
	
	
	/*
  	initial
    	begin
        //$dumpfile("tb_top.vcd");
        //$dumpvars(0,tb_top);
    	end
	*/

	always  #5 clk = ~clk ; 
	

	assign tb_a_in = (locked == 1'b1)?8'bZ:tb_a;
	assign tb_b_in = (locked == 1'b1)?8'bZ:tb_b;
/*	
	always@(tb_a_in,tb_b_in,tb_a,tb_b)begin
		if( tb_a == verif_a&& tb_b == verif_b) changed = 1'b0;
		else 			 	 changed = 1'b1;
	end
*/
	
	always@(posedge done)begin
		$timeformat(-6,5,"us",10);	
		$display(" %d(%d) * %d(%d)  result = %d, Expected = %d changed = %d @ %4.1t",verif_a,tb_a,verif_b,tb_b,d_out,c,changed,$time);

	end

	always@(posedge clk or negedge rst)begin
		if(!rst)begin	
			c<=16'b0;
			tb_a_sync <= 0;
			tb_b_sync <= 0;
			sync_start <= 0;
			end
		else begin
			c<=verif_a*verif_b;
			tb_a_sync <= tb_a_in;
			tb_b_sync <= tb_b_in;
			sync_start <= start;
			end
		end
endmodule
