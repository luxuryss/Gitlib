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
    parameter                   DEPTH   = 1
)(
    input                       clk         ,
    input                       rstn        ,
    input                       sig         ,
    output                      sig_rising  ,
    output                      sig_falling
    );

// >>>>>>>>>> var
genvar                          i;
reg     [DEPTH : 0]             sig_reg;

// >>>>>>>>>> pulse
assign sig_rising   = (sig_reg[DEPTH-1]) & (~sig_reg[DEPTH]);
assign sig_falling  = (~sig_reg[DEPTH-1]) & (sig_reg[DEPTH]);

always @(*) begin
    sig_reg[0] = sig;
end

generate
    for(i = 1; i <= DEPTH; i = i+1) begin
        always @(posedge clk or negedge rstn) begin
            if(rstn == 1'd0)
                sig_reg[i] <= 1'd0;
            else
                sig_reg[i] <= sig_reg[i-1];
        end
    end
endgenerate

endmodule
