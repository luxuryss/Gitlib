`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/09/05 14:30:29
// Design Name: 
// Module Name: cfg_reg
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
module cfg_reg #(
    parameter           INIT_VALUE      = 32'h0     ,
    parameter           REG_ADDR_WIDTH  = 32        ,
    parameter           REG_DATA_WIDTH  = 32
)(
    input                               clk         ,
    input                               rstn        ,
    input                               cfg_vld     ,
    input       [REG_DATA_WIDTH-1 : 0]  cfg_data    ,
    output  reg [REG_DATA_WIDTH-1 : 0]  reg_data
    );

always @(posedge clk or negedge rstn) begin
    if(rstn == 1'd0)
        reg_data <= INIT_VALUE;
    else if(cfg_vld == 1'd1)
        reg_data <= cfg_data;
end

endmodule