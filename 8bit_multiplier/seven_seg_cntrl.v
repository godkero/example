`timescale 10ns/10ps

module seven_seg_cntrl(
	input  	       [2:0] inp,
	output	reg    [7:0] seg_position
);

	always@(inp)begin
		case (inp)
			3'b000: seg_position = 8'b00111111; //0
			3'b001: seg_position = 8'b00000110; //1
			3'b010: seg_position = 8'b01011011; //2
			3'b011: seg_position = 8'b01001111; //3
			3'b100: seg_position = 8'b01100110; //4
			3'b101: seg_position = 8'b01101101; //5
			default:seg_position = 8'b01111001; //E  
		endcase
	end
endmodule
