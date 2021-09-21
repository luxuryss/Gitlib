`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/09/05 15:26:48
// Design Name: 
// Module Name: sig_sync
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
module sig_sync #(
    parameter                   WIDTH   = 1 ,
    parameter                   DEPTH   = 1
)(
    input                       clk         ,
    input                       rstn        ,
    input                       sig_in_vld  ,
    input   [WIDTH-1 : 0]       sig_in      ,
    output                      sig_out_vld ,
    output  [WIDTH-1 : 0]       sig_out
    );

// >>>>>>>>>> var
genvar                          i;
reg [DEPTH : 0][WIDTH-1 : 0]    sig_reg;
reg [DEPTH : 0]                 sig_reg_vld;

// >>>>>>>>>> sync
assign sig_out      = sig_reg[DEPTH];
assign sig_out_vld  = sig_reg_vld[DEPTH];

always @(*) begin
    sig_reg[0]      = (sig_in_vld == 1'd1) ? sig_in : 'd0;
    sig_reg_vld[0]  = sig_in_vld;
end

generate
    for(i = 1; i <= DEPTH; i = i+1) begin
        always @(posedge clk or negedge rstn) begin
            if(rstn == 1'd0)
                sig_reg_vld[i] <= 1'd0;
            else
                sig_reg_vld[i] <= sig_reg_vld[i-1];
        end
        always @(posedge clk or negedge rstn) begin
            if(rstn == 1'd0)
                sig_reg[i] <= 'd0;
            else if(sig_reg_vld[i-1] == 1'd1)
                sig_reg[i] <= sig_reg[i-1];
        end
    end
endgenerate

endmodule
