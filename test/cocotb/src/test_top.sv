`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/09/21 11:35:11
// Design Name: 
// Module Name: test_top
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
module test_top (
    // >>>>>>>>>> sys
    input                       clk         ,
    input                       rstn_in     ,
    // >>>>>>>>>> din
    input                       din_vld     ,
    input       [7 : 0]         din_a       ,
    input       [7 : 0]         din_b       ,
    // >>>>>>>>>> dout
    output  reg                 dout_vld    ,
    output  reg [8 : 0]         dout
    );

// >>>>>>>>>> var
reg                             rstn_r, rstn;

// >>>>>>>>>> logic
always @(posedge clk or negedge rstn_in) begin
    if(rstn_in == 1'd0) begin
        rstn_r <= 1'd0;
        rstn   <= 1'd0;
    end
    else begin
        rstn_r <= 1'd1;
        rstn   <= rstn_r;
    end
end

always @(posedge clk or negedge rstn) begin
    if(rstn == 1'd0) begin
        dout        <= 9'd0;
        dout_vld    <= 1'd0;
    end
    else if(din_vld == 1'd1) begin
        dout        <= din_a + din_b;
        dout_vld    <= 1'd1;
    end
    else begin
        dout        <= dout;
        dout_vld    <= 1'd0;
    end
end

endmodule
