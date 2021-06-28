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
		.seg_position
		);

	initial begin
		a = 8'b10000001;
		b = 8'b00010011;


		#750 
		a = 8'hf0;
		b = 8'h35;
	end


	initial begin 
		rst = 1 ;
		clk = 0 ;
 	  #10	rst = 0 ;
	  #10 	rst = 1 ;
	  #100	start = 1;
	  #600  start = 0;
 	  #400  start = 1; 
	  #1000 $finish;
	 end

	initial
    begin
        $dumpfile("tb_top.vcd");
        $dumpvars(0,tb_top);
    end

	always #5 clk = ~clk ; 



endmodule
