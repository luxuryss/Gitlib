`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/09/11 11:22:56
// Design Name: 
// Module Name: sig_pulse
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
module sig_pulse #(
    parameter                   RST_VAL = 0
)(
    input                       clk         ,
    input                       rstn        ,
    input                       sig         ,
    output                      sig_rising  ,
    output                      sig_falling
    );

// >>>>>>>>>> var
reg                             sig_reg;

// >>>>>>>>>> pulse
assign sig_rising   = (sig) & (~sig_reg);
assign sig_falling  = (~sig) & (sig_reg);

always @(posedge clk or negedge rstn) begin
    if(rstn == 1'd0)
        sig_reg <= RST_VAL;
    else
        sig_reg <= sig;
end

endmodule
