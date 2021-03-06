`timescale 10ns/10ps



//this moudle is made to define FSM and to manage control signal.
module control
#(
parameter IDLE=3'b000,S0 = 3'b001,  S1 = 3'b010,
	  S2 = 3'b011 , S3 = 3'b100, FINISH = 3'b101 
	)
(
	input 		    clk,rst,start,changed,
	input      [2:0]    count,

	output		    locked,
	output reg       	data_sel,clk_en,
	output reg [2:0]    state,
	output reg 	    	sela,selb,done_flag,
	output reg [1:0]    sel_shifter
);

	reg        [2:0]    n_state;	


	//next state define
	always@(count,start,state)begin
		case(state)
			IDLE:  	   n_state = (start == 1'b1 && count == 3'b000)? S0:IDLE;
			S0:        n_state = (3'b001 == count )? S1 : IDLE;
			S1:        n_state = (3'b010 == count )? S2 : S1;
			S2:        n_state = (3'b011 == count )? S3 : S2;
			S3:    	   n_state = (3'b100 == count )? FINISH :S3 ;
			FINISH:    n_state = (3'b101 == count )? IDLE : IDLE;
			default:   n_state = IDLE;
		endcase
	end

	//state transfer with clk
	always@(posedge clk or negedge rst)begin
		if(!rst)state <= IDLE;
		else state <= n_state;
	end

	//output logic
	always@(state)begin		
		case(state)
			IDLE:	begin sela = 1'b1;selb = 1'b1;sel_shifter = 2'b10;done_flag = 1'b0;data_sel = 1'b1;clk_en = 1'b1;end
			S0:	begin sela = 1'b1;selb = 1'b1;sel_shifter = 2'b10;done_flag = 1'b0;data_sel = 1'b1;clk_en = 1'b1;end
			S1:	begin sela = 1'b1;selb = 1'b0;sel_shifter = 2'b01;done_flag = 1'b0;data_sel = 1'b0;clk_en = 1'b1;end
			S2:   	begin sela = 1'b0;selb = 1'b1;sel_shifter = 2'b01;done_flag = 1'b0;data_sel = 1'b0;clk_en = 1'b1;end
			S3:    	begin sela = 1'b0;selb = 1'b0;sel_shifter = 2'b00;done_flag = 1'b0;data_sel = 1'b0;clk_en = 1'b1;end
			FINISH:	begin sela = 1'b1;selb = 1'b1;sel_shifter = 2'b10;done_flag = 1'b1;data_sel = 1'b1;clk_en = 1'b0;end
		endcase
	end

	assign locked = (state != IDLE && state != FINISH) ? 1'b1: 1'b0;
	

endmodule
	
