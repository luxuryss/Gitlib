`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/09/15 14:09:11
// Design Name: 
// Module Name: test_axis_rx_gen
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
module test_axis_rx_gen #(
    parameter                           AXIS_DATA_WIDTH     = 64    ,
    parameter                           TEST_RX_SIZE        = 1024
)(
    // >>>>>>>>>> sys
    input                               clk                     ,
    input                               rstn                    ,
    // >>>>>>>>>> axis
    input   [AXIS_DATA_WIDTH-1 : 0]     rx_axis_tdata           ,
    input   [AXIS_DATA_WIDTH/8-1 : 0]   rx_axis_tkeep           ,
    input                               rx_axis_tvalid          ,
    input                               rx_axis_tlast           ,
    output                              rx_axis_tready
    );

// >>>>>>>>>> var
reg     [AXIS_DATA_WIDTH-1 : 0]         test_data;
reg     [$clog2(TEST_RX_SIZE/8)-1 : 0]  test_rx_cnt;

// >>>>>>>>>> axis
assign rx_axis_tready   = 1'd1;

always @(posedge clk or negedge rstn) begin
    if(rstn == 1'd0)
        test_data <= 'd0;
    else if(rx_axis_tvalid == 1'd1)
        test_data <= rx_axis_tdata;
end

always @(posedge clk or negedge rstn) begin
    if(rstn == 1'd0)
        test_rx_cnt <= 'd0;
    else if(rx_axis_tlast == 1'd1)
        test_rx_cnt <= 'd0;
    else
        test_rx_cnt <= test_rx_cnt + 1'd1;
end

endmodule
