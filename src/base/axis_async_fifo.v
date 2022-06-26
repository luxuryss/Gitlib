`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/06/26 14:29:19
// Design Name: 
// Module Name: axis_async_fifo
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
module axis_async_fifo #(
    parameter                       DATA_WIDTH  = 32    ,
    parameter                       FIFO_DEPTH  = 256
)(
    // >>>>>>>>>> system
    input                           rstn                ,
    // >>>>>>>>>> s_axis
    input                           s_aclk              ,
    output                          s_axis_tready       ,
    input                           s_axis_tvalid       ,
    input   [DATA_WIDTH-1:0]        s_axis_tdata        ,
    input   [DATA_WIDTH/8-1:0]      s_axis_tkeep        ,
    input                           s_axis_tlast        ,
    // >>>>>>>>>> m_axis
    input                           m_aclk              ,
    input                           m_axis_tready       ,
    output                          m_axis_tvalid       ,
    output  [DATA_WIDTH-1:0]        m_axis_tdata        ,
    output  [DATA_WIDTH/8-1:0]      m_axis_tkeep        ,
    output                          m_axis_tlast
    );

// >>>>>>>>>> var
wire                                tmp_m_axis_tlast;

// >>>>>>>>>> afifo
sig_pulse #(
    .RST_VAL                (0                      )
)
u_m_axis_tlast (
    .clk                    (m_aclk                 ),
    .rstn                   (rstn                   ),
    .sig                    (tmp_m_axis_tlast       ),
    .sig_rising             (m_axis_tlast           ),
    .sig_falling            (                       )
    );

xpm_fifo_axis #(
    .CDC_SYNC_STAGES        (2                      ),
    .CLOCKING_MODE          ("independent_clock"    ),
    .ECC_MODE               ("no_ecc"               ),
    .FIFO_DEPTH             (FIFO_DEPTH             ),
    .FIFO_MEMORY_TYPE       ("auto"                 ),
    .PACKET_FIFO            ("true"                 ),
    .PROG_EMPTY_THRESH      (10                     ),
    .PROG_FULL_THRESH       (10                     ),
    .RD_DATA_COUNT_WIDTH    (1                      ),
    .RELATED_CLOCKS         (0                      ),
    .TDATA_WIDTH            (DATA_WIDTH             ),
    .TDEST_WIDTH            (1                      ),
    .TID_WIDTH              (1                      ),
    .TUSER_WIDTH            (1                      ),
    .USE_ADV_FEATURES       ("1000"                 ),
    .WR_DATA_COUNT_WIDTH    (1                      )
    )
xpm_fifo_axis_inst (
    .almost_empty_axis      (                       ),
    .almost_full_axis       (                       ),
    .dbiterr_axis           (                       ),
    .m_axis_tdata           (m_axis_tdata           ),
    .m_axis_tdest           (                       ),
    .m_axis_tid             (                       ),
    .m_axis_tkeep           (m_axis_tkeep           ),
    .m_axis_tlast           (tmp_m_axis_tlast       ),
    .m_axis_tstrb           (                       ),
    .m_axis_tuser           (                       ),
    .m_axis_tvalid          (m_axis_tvalid          ),
    .prog_empty_axis        (                       ),
    .prog_full_axis         (                       ),
    .rd_data_count_axis     (                       ),
    .s_axis_tready          (s_axis_tready          ),
    .sbiterr_axis           (                       ),
    .wr_data_count_axis     (                       ),
    .injectdbiterr_axis     ('d0                    ),
    .injectsbiterr_axis     ('d0                    ),
    .m_aclk                 (m_aclk                 ),
    .m_axis_tready          (m_axis_tready          ),
    .s_aclk                 (s_aclk                 ),
    .s_aresetn              (rstn                   ),
    .s_axis_tdata           (s_axis_tdata           ),
    .s_axis_tdest           ('d0                    ),
    .s_axis_tid             ('d0                    ),
    .s_axis_tkeep           (s_axis_tkeep           ),
    .s_axis_tlast           (s_axis_tlast           ),
    .s_axis_tstrb           ({(DATA_WIDTH/8){1'd1}} ),
    .s_axis_tuser           ('d0                    ),
    .s_axis_tvalid          (s_axis_tvalid          )
);

endmodule
