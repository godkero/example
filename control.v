`timescale 10ns/10ps

module control
#(
parameter IDLE=3'b000,S0 = 3'b001,  S1 = 3'b010,
	  S2 = 3'b011 , S3 = 3'b100, FINISH = 3'b101,
	  ERROR = 3'b111 
	)
(
	input 		    clk,rst,start,changed,
	input      [2:0]    count,

	output reg       	data_sel,clk_en,
	output reg [2:0]    state,
	output reg 	    	sela,selb,done_flag,
	output reg [1:0]    sel_shifter
);

	reg        [2:0]    n_state;	

	
	always@*begin
		case({state,changed})
			{IDLE,1'b1}:      n_state = (start == 1'b1)? S0 : IDLE;
			{IDLE,1'b0}:      n_state = (start == 1'b1)? S0 : IDLE;
			{S0,1'b0}:        n_state = (3'b001 == count )? S1 : IDLE;
			{S1,1'b0}:        n_state = (3'b010 == count )? S2 : S1;
			{S2,1'b0}:        n_state = (3'b011 == count )? S3 : S2;
			{S3,1'b0}:    	  n_state = (3'b100 == count )? FINISH :S3 ;
			{FINISH,1'b0}:    n_state = (3'b101 == count )? IDLE : IDLE;
			{S0,1'b1}:        n_state = ERROR;
			{S1,1'b1}:        n_state = ERROR;
			{S2,1'b1}:        n_state = ERROR;
			{S3,1'b1}:    	  n_state = ERROR;
			{ERROR,1'b1} :    n_state = ERROR;
			{ERROR,1'b0} :    n_state = S0;
			
			default   :	  n_state = IDLE;
		
		endcase
	end

	//clk
	always@(posedge clk or negedge rst)begin
		if(!rst)state <= IDLE;
		else state <= n_state;
	end

	//output logic
	always@(state)begin		
		case(state)
			IDLE:	begin sela = 1'bx;selb = 1'bx;sel_shifter = 2'bxx;done_flag = 1'b0;data_sel = 1'b1;clk_en = 1'b1;end
			S0:	begin sela = 1'b1;selb = 1'b1;sel_shifter = 2'b10;done_flag = 1'b0;data_sel = 1'b1;clk_en = 1'b1;end
			S1:	begin sela = 1'b1;selb = 1'b0;sel_shifter = 2'b01;done_flag = 1'b0;data_sel = 1'b0;clk_en = 1'b1;end
			S2:   	begin sela = 1'b0;selb = 1'b1;sel_shifter = 2'b01;done_flag = 1'b0;data_sel = 1'b0;clk_en = 1'b1;end
			S3:    	begin sela = 1'b0;selb = 1'b0;sel_shifter = 2'b00;done_flag = 1'b0;data_sel = 1'b0;clk_en = 1'b1;end
			FINISH:	begin sela = 1'bx;selb = 1'bx;sel_shifter = 2'bxx;done_flag = 1'b1;data_sel = 1'b1;clk_en = 1'b0;end
			ERROR:	begin sela = 1'b1;selb = 1'b1;sel_shifter = 2'b10;done_flag = 1'b1;data_sel = 1'b0;clk_en = 1'b0;end
		endcase
	end


endmodule
	
