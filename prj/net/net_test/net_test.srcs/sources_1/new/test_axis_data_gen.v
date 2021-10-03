`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/09/15 14:04:23
// Design Name: 
// Module Name: test_axis_data_gen
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
module test_axis_data_gen #(
    parameter                           AXIS_DATA_WIDTH     = 64
)(
    // >>>>>>>>>> sys
    input                               clk                     ,
    input                               rstn                    ,
    input                               test_en                 ,
    // >>>>>>>>>> axis
    output  [AXIS_DATA_WIDTH-1 : 0]     tx_axis_tdata           ,
    output  [AXIS_DATA_WIDTH/8-1 : 0]   tx_axis_tkeep           ,
    output                              tx_axis_tvalid          ,
    output                              tx_axis_tlast           ,
    input                               tx_axis_tready          ,
    input   [AXIS_DATA_WIDTH-1 : 0]     rx_axis_tdata           ,
    input   [AXIS_DATA_WIDTH/8-1 : 0]   rx_axis_tkeep           ,
    input                               rx_axis_tvalid          ,
    input                               rx_axis_tlast           ,
    output                              rx_axis_tready
    );

// >>>>>>>>>> test_axis_tx
test_axis_tx_gen #(
    .AXIS_DATA_WIDTH        (AXIS_DATA_WIDTH        )
)
u_test_axis_tx_gen (
    .clk                    (clk                    ),
    .rstn                   (rstn                   ),
    .test_en                (test_en                ),
    .tx_axis_tdata          (tx_axis_tdata          ),
    .tx_axis_tkeep          (tx_axis_tkeep          ),
    .tx_axis_tvalid         (tx_axis_tvalid         ),
    .tx_axis_tlast          (tx_axis_tlast          ),
    .tx_axis_tready         (tx_axis_tready         )
    );

// >>>>>>>>>> test_axis_rx
test_axis_rx_gen #(
    .AXIS_DATA_WIDTH        (AXIS_DATA_WIDTH        )
)
u_test_axis_rx_gen (
    .clk                    (clk                    ),
    .rstn                   (rstn                   ),
    .rx_axis_tdata          (rx_axis_tdata          ),
    .rx_axis_tkeep          (rx_axis_tkeep          ),
    .rx_axis_tvalid         (rx_axis_tvalid         ),
    .rx_axis_tlast          (rx_axis_tlast          ),
    .rx_axis_tready         (rx_axis_tready         )
    );

endmodule
