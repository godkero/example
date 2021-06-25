`timescale 10ns/10ps

module control
#(
parameter S0 = 3'b000,  S1 = 3'b001,
	  S2 = 3'b010 , S3 = 3'b011, FINISH = 3'b100 
)
(
	input 		    clk,rst,start,
	input      [2:0]    count,

	output reg [2:0]    state,
	output reg 	    sela,selb,done_flag,
	output reg [1:0]    sel_shifter
);

	reg        [2:0]    n_state;	


	always@*begin
		case({count,start})
			{S0,1'b1}:    n_state = S1;
			{S1,1'b1}:    n_state = S2;
			{S2,1'b1}:    n_state = S3;
			{S3,1'b1}:    n_state = FINISH;
			{FINISH,1'b1}:n_state = FINISH;
			default      :n_state = S0;
		endcase
	end

	//clk
	always@(posedge clk or negedge rst)begin
		if(!rst)state <= S0;
		else state <= n_state;
	end

	//output logic
	always@(state)begin		
		case(state)
			S0:	begin sela = 1'b1;selb = 1'b1;sel_shifter = 2'b10;done_flag = 1'b0;end
			S1:	begin sela = 1'b1;selb = 1'b0;sel_shifter = 2'b01;done_flag = 1'b0;end
			S2:   	begin sela = 1'b0;selb = 1'b1;sel_shifter = 2'b01;done_flag = 1'b0;end
			S3:    	begin sela = 1'b0;selb = 1'b0;sel_shifter = 2'b00;done_flag = 1'b0;end
			FINISH:	begin sela = 1'bx;selb = 1'bx;sel_shifter = 2'bxx;done_flag = 1'b1;end
		endcase
	end


endmodule
	
