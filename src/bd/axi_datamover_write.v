`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/10/23 14:27:33
// Design Name: 
// Module Name: axi_datamover_write
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
module axi_datamover_write #(
    parameter                               AXIS_FIFO_DEPTH = 32,
    parameter                               S2MM_DATA_WIDTH = 64,
    parameter                               S2MM_CMD_WIDTH  = 72,
    parameter                               S2MM_ADDR_WIDTH = 32,
    parameter                               S2MM_SIZE_WIDTH = 16,
    parameter                               S2MM_STS_WIDTH  = 32
)(
    // >>>>>>>>>> sys
    input                                   clk                 ,
    input                                   rstn                ,
    // >>>>>>>>>> ddr_write
    output                                  ddr_wreq_ready      ,
    input                                   ddr_wreq_valid      ,
    input       [S2MM_ADDR_WIDTH-1:0]       ddr_wreq_addr       ,
    input       [S2MM_SIZE_WIDTH-1:0]       ddr_wreq_size       ,
    output                                  ddr_wdata_ready     ,
    input                                   ddr_wdata_valid     ,
    input                                   ddr_wdata_last      ,
    input       [S2MM_DATA_WIDTH-1:0]       ddr_wdata           ,
    output  reg                             ddr_wresp_valid     ,
    output  reg [1:0]                       ddr_wresp           ,
    // >>>>>>>>>> axis_write
    output  reg [S2MM_CMD_WIDTH-1:0]        s2mm_cmd_tdata      ,
    input                                   s2mm_cmd_tready     ,
    output  reg                             s2mm_cmd_tvalid     ,
    output      [S2MM_DATA_WIDTH-1:0]       s2mm_tdata          ,
    output      [S2MM_DATA_WIDTH/8-1:0]     s2mm_tkeep          ,
    output                                  s2mm_tlast          , 
    input                                   s2mm_tready         ,
    output                                  s2mm_tvalid         ,
    input       [S2MM_STS_WIDTH-1:0]        s2mm_sts_tdata      ,
    input       [S2MM_STS_WIDTH/8-1:0]      s2mm_sts_tkeep      ,
    input                                   s2mm_sts_tlast      ,
    output                                  s2mm_sts_tready     ,
    input                                   s2mm_sts_tvalid
    );

// >>>>>>>>>> var
// cmd
wire    [3:0]                               cmd_xcache, cmd_xuser, cmd_rsv, cmd_tag;
wire                                        cmd_drr, cmd_eof, cmd_type;
wire    [5:0]                               cmd_dsa;
wire    [S2MM_ADDR_WIDTH-1:0]               cmd_saddr;
wire    [22:0]                              cmd_btt;
// data
wire    [S2MM_DATA_WIDTH/8-1:0]             ddr_wdata_keep;

// >>>>>>>>>> cmd
assign cmd_xcache       = 'd0;
assign cmd_xuser        = 'd0;
assign cmd_rsv          = 'd0;
assign cmd_tag          = 'd0;
assign cmd_drr          = 'd0;
assign cmd_eof          = 'd0;
assign cmd_type         = 'd1;
assign cmd_dsa          = 'd0;
assign cmd_btt          = ddr_wreq_size;
assign cmd_saddr        = ddr_wreq_addr;
assign ddr_wreq_ready   = s2mm_cmd_tready;

always @(posedge clk or negedge rstn) begin
    if(rstn == 1'd0)
        s2mm_cmd_tdata <= 'd0;
    else if(ddr_wreq_valid == 1'd1 && ddr_wreq_ready == 1'd1)
        s2mm_cmd_tdata <= {cmd_rsv, cmd_tag, cmd_saddr, cmd_drr, cmd_eof, cmd_dsa, cmd_type, cmd_btt};
end

always @(posedge clk or negedge rstn) begin
    if(rstn == 1'd0)
        s2mm_cmd_tvalid <= 1'd0;
    else
        s2mm_cmd_tvalid <= (ddr_wreq_valid == 1'd1) && (ddr_wreq_ready == 1'd1);
end

// >>>>>>>>>> resp
assign s2mm_sts_tready  = 'd1;

always @(posedge clk or negedge rstn) begin
    if(rstn == 1'd0)
        ddr_wresp <= 'd0;
    else if(s2mm_sts_tready == 1'd1 && s2mm_sts_tvalid == 1'd1 && s2mm_sts_tkeep == {(S2MM_DATA_WIDTH/8){1'd1}}) begin
        ddr_wresp <= (s2mm_sts_tdata[7:0] == 'h80) ? 'd0 : 'd3;
    end
end

always @(posedge clk or negedge rstn) begin
    if(rstn == 1'd0)
        ddr_wresp_valid <= 1'd0;
    else
        ddr_wresp_valid <= (s2mm_sts_tready == 1'd1) && (s2mm_sts_tvalid == 1'd1) && (s2mm_sts_tkeep == {(S2MM_DATA_WIDTH/8){1'd1}});
end

// >>>>>>>>>> data
assign ddr_wdata_keep   = (ddr_wdata_valid == 1'd1) ? {(S2MM_DATA_WIDTH/8){1'd1}} : 'd0;

axis_async_fifo #(
    .DATA_WIDTH             (S2MM_DATA_WIDTH    ),
    .FIFO_DEPTH             (AXIS_FIFO_DEPTH    )
)
u_ddr_wdata_fifo (
    .rstn                   (rstn               ),
    .s_aclk                 (clk                ),
    .s_axis_tready          (ddr_wdata_ready    ),
    .s_axis_tvalid          (ddr_wdata_valid    ),
    .s_axis_tdata           (ddr_wdata          ),
    .s_axis_tkeep           (ddr_wdata_keep     ),
    .s_axis_tlast           (ddr_wdata_last     ),
    .m_aclk                 (clk                ),
    .m_axis_tready          (s2mm_tready        ),
    .m_axis_tvalid          (s2mm_tvalid        ),
    .m_axis_tdata           (s2mm_tdata         ),
    .m_axis_tkeep           (s2mm_tkeep         ),
    .m_axis_tlast           (s2mm_tlast         )
    );

endmodule
