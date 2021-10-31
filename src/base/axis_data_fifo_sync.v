`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/10/30 10:11:58
// Design Name: 
// Module Name: axis_data_fifo_sync
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
module axis_data_fifo #(
    parameter                       CDC_SYNC_STAGES     = 3                     ,   // Range: 2 - 8. Default value = 2.
    parameter                       CLOCKING_MODE       = "independent_clock"   ,   // Allowed values: common_clock, independent_clock. Default value = common_clock.
    parameter                       ECC_MODE            = "no_ecc"              ,
    parameter                       FIFO_DEPTH          = 2048                  ,   // Range: 16 - 4194304. Default value = 2048.
    parameter                       FIFO_MEMORY_TYPE    = "block"               ,   // Allowed values: auto, block, distributed, ultra. Default value = auto.
    parameter                       PACKET_FIFO         = "false"               ,
    parameter                       PROG_EMPTY_THRESH   = 10                    ,
    parameter                       PROG_FULL_THRESH    = 10                    ,
    parameter                       RD_DATA_COUNT_WIDTH = 1                     ,
    parameter                       RELATED_CLOCKS      = 0                     ,
    parameter                       TDATA_WIDTH         = 64                    ,
    parameter                       TDEST_WIDTH         = 1                     ,
    parameter                       TID_WIDTH           = 1                     ,
    parameter                       TUSER_WIDTH         = 1                     ,
    parameter                       USE_ADV_FEATURES    = "1000"                ,
    parameter                       WR_DATA_COUNT_WIDTH = 1
)(
    // >>>>>>>>>> m_axis(write)
    input                           m_aclk              ,
    input                           m_axis_tready       ,
    output                          m_axis_tvalid       ,
    output  [TDATA_WIDTH-1 : 0]     m_axis_tdata        ,
    output  [TDATA_WIDTH/8-1 : 0]   m_axis_tkeep        ,
    output                          m_axis_tlast        ,
    // >>>>>>>>>> s_axis(read)
    input                           s_aclk              ,
    output                          s_axis_tready       ,
    input                           s_axis_tvalid       ,
    input   [TDATA_WIDTH-1 : 0]     s_axis_tdata        ,
    input   [TDATA_WIDTH/8-1 : 0]   s_axis_tkeep        ,
    input                           s_axis_tlast
    );


// >>>>>>>>>> xpm_fifo
xpm_fifo_axis #(
    .CDC_SYNC_STAGES            (CDC_SYNC_STAGES            ),
    .CLOCKING_MODE              (CLOCKING_MODE              ),
    .ECC_MODE                   (ECC_MODE                   ),
    .FIFO_DEPTH                 (FIFO_DEPTH                 ),
    .FIFO_MEMORY_TYPE           (FIFO_MEMORY_TYPE           ),
    .PACKET_FIFO                (PACKET_FIFO                ),
    .PROG_EMPTY_THRESH          (PROG_EMPTY_THRESH          ),
    .PROG_FULL_THRESH           (PROG_FULL_THRESH           ),
    .RD_DATA_COUNT_WIDTH        (RD_DATA_COUNT_WIDTH        ),
    .RELATED_CLOCKS             (RELATED_CLOCKS             ),
    .TDATA_WIDTH                (TDATA_WIDTH                ),
    .TDEST_WIDTH                (TDEST_WIDTH                ),
    .TID_WIDTH                  (TID_WIDTH                  ),
    .TUSER_WIDTH                (TUSER_WIDTH                ),
    .USE_ADV_FEATURES           (USE_ADV_FEATURES           ),
    .WR_DATA_COUNT_WIDTH        (WR_DATA_COUNT_WIDTH        ) 
)
xpm_fifo_axis_inst (
   .almost_empty_axis           (                           ),
   .almost_full_axis            (                           ),
   .dbiterr_axis                (                           ),
   .m_axis_tdata                (m_axis_tdata               ),
   .m_axis_tdest                (                           ),
   .m_axis_tid                  (                           ),
   .m_axis_tkeep                (m_axis_tkeep               ),
   .m_axis_tlast                (m_axis_tlast               ),
   .m_axis_tstrb                (                           ),
   .m_axis_tuser                (                           ),
   .m_axis_tvalid               (m_axis_tvalid              ),
   .prog_empty_axis             (                           ),
   .prog_full_axis              (                           ),
   .rd_data_count_axis          (                           ),
   .s_axis_tready               (s_axis_tready              ),
   .sbiterr_axis                (                           ),
   .wr_data_count_axis          (                           ),
   .injectdbiterr_axis          (                           ),
   .injectsbiterr_axis          (                           ),
   .m_aclk                      (m_aclk                     ),
   .m_axis_tready               (m_axis_tready              ),
   .s_aclk                      (s_aclk                     ),
   .s_aresetn                   (s_aresetn                  ),
   .s_axis_tdata                (s_axis_tdata               ),
   .s_axis_tdest                (                           ),
   .s_axis_tid                  (                           ),
   .s_axis_tlast                (s_axis_tlast               ),
   .s_axis_tstrb                (                           ),
   .s_axis_tuser                (s_axis_tuser               ),
   .s_axis_tvalid               (s_axis_tvalid              ) 
);

endmodule
