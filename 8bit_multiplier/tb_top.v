`timescale 10ns/10ps

module tb_top;

	reg 	   	clk,rst,start;
	reg 	[7:0] 	tb_a,tb_b;
	reg     [7:0]   tb_a_sync,tb_b_sync;
	reg 		changed;
	reg     [15:0]  c;	
	reg 		sync_start;


	wire    [7:0]   verif_a,verif_b;
	wire    [7:0]   tb_a_in,tb_b_in;
	wire        	done;
	wire 	[15:0] 	d_out;
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
		.verif_a(verif_a),.verif_b(verif_b)//this data use to calulate at testbench
		);


	//simulation data define
	//all data is random , increase change time factor from 1 clock to 20clock 
	// input data random and if start == 1'1b, after twice clk event start = 1'b0
	initial begin
		$display("TopA(inA) * TopB(inB) result   	      Expected         change     time");
		tb_a = 8'b10000001;
		tb_b = 8'b00010011;
		start = 0;
		if(start == 1'b1)begin
						 repeat(2)@(posedge clk); start = ~start;
		end
		#100
		start = $urandom%2;
		tb_a = $urandom%256;
		tb_b = $urandom%256;
		if(start == 1'b1)begin
						 repeat(2)@(posedge clk); start = ~start;
		end
		#10 
		start = $urandom%2;
		tb_a = $urandom%256;
		tb_b = $urandom%256;
		if(start == 1'b1)begin
						 repeat(2)@(posedge clk); start = ~start;
		end
		#20 
		start = $urandom%2;
		tb_a = $urandom%256;
		tb_b = $urandom%256;
		if(start == 1'b1)begin
						 repeat(2)@(posedge clk); start = ~start;
		end
		#30 
		start = $urandom%2;
		tb_a = $urandom%256;
		tb_b = $urandom%256;
		if(start == 1'b1)begin
						 repeat(2)@(posedge clk); start = ~start;
		end
		#43 
		start = $urandom%2;
		tb_a = $urandom%256;
		tb_b = $urandom%256;
		if(start == 1'b1)begin
						 repeat(2)@(posedge clk); start = ~start;
		end
		#57
		start = $urandom%2;
		tb_a = $urandom%256;
		tb_b = $urandom%256;
		if(start == 1'b1)begin
						 repeat(2)@(posedge clk); start = ~start;
		end
		#62
		start = $urandom%2;
		tb_a = $urandom%256;
		tb_b = $urandom%256;
		if(start == 1'b1)begin
						 repeat(2)@(posedge clk); start = ~start;
		end
		#78
		start = $urandom%2;
		tb_a = $urandom%256;
		tb_b = $urandom%256;
		if(start == 1'b1)begin
						 repeat(2)@(posedge clk); start = ~start;
		end
		#80
		start = $urandom%2;
		tb_a = $urandom%256;
		tb_b = $urandom%256;
		if(start == 1'b1)begin
						 repeat(2)@(posedge clk); start = ~start;
		end
		#90
		start = $urandom%2;
		tb_a = $urandom%256;
		tb_b = $urandom%256;
		if(start == 1'b1)begin
						 repeat(2)@(posedge clk); start = ~start;
		end
		#100
		start = $urandom%2;
		tb_a = $urandom%256;
		tb_b = $urandom%256;
		if(start == 1'b1)begin
						 repeat(2)@(posedge clk); start = ~start;
		end
		#110	
		start = $urandom%2;
		tb_a = $urandom%256;
		tb_b = $urandom%256;
		if(start == 1'b1)begin
						 repeat(2)@(posedge clk); start = ~start;
		end
		#120 
		start = $urandom%2;
		tb_a = $urandom%256;
		tb_b = $urandom%256;
		if(start == 1'b1)begin
						 repeat(2)@(posedge clk); start = ~start;
		end
		#130 
		start = $urandom%2;
		tb_a = $urandom%256;
		tb_b = $urandom%256;
		if(start == 1'b1)begin
						 repeat(2)@(posedge clk); start = ~start;
		end
		#140 
		start = $urandom%2;
		tb_a = $urandom%256;
		tb_b = $urandom%256;
		if(start == 1'b1)begin
						 repeat(2)@(posedge clk); start = ~start;
		end
		#150
		start = $urandom%2;
		tb_a = $urandom%256;
		tb_b = $urandom%256;
		if(start == 1'b1)begin
						 repeat(2)@(posedge clk); start = ~start;
		end
		#160
		start = $urandom%2;
		tb_a = $urandom%256;
		tb_b = $urandom%256;
		if(start == 1'b1)begin
						 repeat(2)@(posedge clk); start = ~start;
		end
		#170
		start = $urandom%2;
		tb_a = $urandom%256;
		tb_b = $urandom%256;
		if(start == 1'b1)begin
						 repeat(2)@(posedge clk); start = ~start;
		end
		#180
		start = $urandom%2;
		tb_a = $urandom%256;
		tb_b = $urandom%256;
		if(start == 1'b1)begin
						 repeat(2)@(posedge clk); start = ~start;
		end
		#190
		start = $urandom%2;
		tb_a = $urandom%256;
		tb_b = $urandom%256;
		if(start == 1'b1)begin
						 repeat(2)@(posedge clk); start = ~start;
		end
		#200
		start = $urandom%2;
		tb_a = $urandom%256;
		tb_b = $urandom%256;
		if(start == 1'b1)begin
						 repeat(2)@(posedge clk); start = ~start;
		end	

	end
	
	//clk, rst init 
	initial begin 
		rst  =  1 ;
		clk  =  0 ;
 	  #10	rst  =  0 ;
	  #5 	rst  =  1 ;
	  #5000 $finish;
	 end
	
	
	/* for gtkwave	
  	initial
    	begin
        	$dumpfile("tb_top.vcd");
        	$dumpvars(0,tb_top);
    	end
	*/

	//clk period 100ns
	always  #5 clk = ~clk ; 
	
	// if locked flag is High, input data is varying to Z
	assign tb_a_in = (locked == 1'b1)?8'bZ:tb_a;
	assign tb_b_in = (locked == 1'b1)?8'bZ:tb_b;
	
	//this block use for debug, if a,b is change  while locked 
	always@(tb_a_in,tb_b_in,tb_a,tb_b)begin
		if( tb_a == verif_a&& tb_b == verif_b) changed = 1'b0;
		else 			 	 changed = 1'b1;
	end

	//at done = 1 , check result log	
	always@(posedge done)begin
		$timeformat(-6,5,"us",10);	
		$display(" %d(%d) * %d(%d)  result = %d, Expected = %d changed = %d @ %4.1t",verif_a,tb_a,verif_b,tb_b,d_out,c,changed,$time);

	end

	//input data is on clock synchonization 
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
