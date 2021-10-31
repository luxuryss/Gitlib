`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/10/30 09:49:46
// Design Name: 
// Module Name: eth_frame_gen
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
module eth_frame_gen #(
    parameter                               AXIS_DATA_WIDTH = 64
)(
    // >>>>>>>>>> sys
    input                                   clk                 ,
    input                                   rstn                ,
    // >>>>>>>>>> param
    input   [47 : 0]                        local_addr          ,
    input   [47 : 0]                        remote_addr         ,
    input   [15 : 0]                        tx_size             ,
    input   [15 : 0]                        rx_size             ,
    // >>>>>>>>>> orin_data_frame
    input   [AXIS_DATA_WIDTH-1 : 0]         tx_orin_tdata       ,
    input   [AXIS_DATA_WIDTH/8-1 : 0]       tx_orin_tkeep       ,
    input                                   tx_orin_tvalid      ,
    input                                   tx_orin_tlast       ,
    input                                   tx_orin_tuser       ,
    output                                  tx_orin_tready      ,
    output  [AXIS_DATA_WIDTH-1 : 0]         rx_orin_tdata       ,
    output  [AXIS_DATA_WIDTH/8-1 : 0]       rx_orin_tkeep       ,
    output                                  rx_orin_tvalid      ,
    output                                  rx_orin_tlast       ,
    output                                  rx_orin_tuser       ,
    input                                   rx_orin_tready      ,
    // >>>>>>>>>> eth_data_frame
    output  [AXIS_DATA_WIDTH-1 : 0]         tx_frame_tdata      ,
    output  [AXIS_DATA_WIDTH/8-1 : 0]       tx_frame_tkeep      ,
    output                                  tx_frame_tvalid     ,
    output                                  tx_frame_tlast      ,
    output                                  tx_frame_tuser      ,
    input                                   tx_frame_tready     ,
    input   [AXIS_DATA_WIDTH-1 : 0]         rx_frame_tdata      ,
    input   [AXIS_DATA_WIDTH/8-1 : 0]       rx_frame_tkeep      ,
    input                                   rx_frame_tvalid     ,
    input                                   rx_frame_tlast      ,
    input                                   rx_frame_tuser      ,
    output                                  rx_frame_tready
    );

// >>>>>>>>>> tx
eth_tx_gen #(
    .AXIS_DATA_WIDTH            (AXIS_DATA_WIDTH        )
)
u_eth_tx_gen (
    .clk                        (clk                    ),
    .rstn                       (rstn                   ),
    .local_addr                 (local_addr             ),
    .remote_addr                (remote_addr            ),
    .tx_size                    (tx_size                ),
    .tx_orin_tdata              (tx_orin_tdata          ),
    .tx_orin_tkeep              (tx_orin_tkeep          ),
    .tx_orin_tvalid             (tx_orin_tvalid         ),
    .tx_orin_tlast              (tx_orin_tlast          ),
    .tx_orin_tuser              (tx_orin_tuser          ),
    .tx_orin_tready             (tx_orin_tready         ),
    .tx_frame_tdata             (tx_frame_tdata         ),
    .tx_frame_tkeep             (tx_frame_tkeep         ),
    .tx_frame_tvalid            (tx_frame_tvalid        ),
    .tx_frame_tlast             (tx_frame_tlast         ),
    .tx_frame_tuser             (tx_frame_tuser         ),
    .tx_frame_tready            (tx_frame_tready        )
    );

// >>>>>>>>>> rx
eth_rx_gen #(
    .AXIS_DATA_WIDTH            (AXIS_DATA_WIDTH        )
)
u_eth_rx_gen (
    .clk                        (clk                    ),
    .rstn                       (rstn                   ),
    .local_addr                 (local_addr             ),
    .remote_addr                (remote_addr            ),
    .rx_size                    (rx_size                ),
    .rx_orin_tdata              (rx_orin_tdata          ),
    .rx_orin_tkeep              (rx_orin_tkeep          ),
    .rx_orin_tvalid             (rx_orin_tvalid         ),
    .rx_orin_tlast              (rx_orin_tlast          ),
    .rx_orin_tuser              (rx_orin_tuser          ),
    .rx_orin_tready             (rx_orin_tready         ),
    .rx_frame_tdata             (rx_frame_tdata         ),
    .rx_frame_tkeep             (rx_frame_tkeep         ),
    .rx_frame_tvalid            (rx_frame_tvalid        ),
    .rx_frame_tlast             (rx_frame_tlast         ),
    .rx_frame_tuser             (rx_frame_tuser         ),
    .rx_frame_tready            (rx_frame_tready        )
    );

endmodule
