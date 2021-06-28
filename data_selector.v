`timescale 10ns/10ps

module data_selector (
    input      [15:0]   d_in,
    input               data_sel,
    output reg [15:0]   p_out 
);

    always @(*) begin
        case(data_sel)
            1'b1    : p_out = 16'h0;
            default : p_out = d_in;
        endcase         
    end
    
endmodule //data_selector