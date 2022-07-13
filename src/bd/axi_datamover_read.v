`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/10/23 15:56:12
// Design Name: 
// Module Name: axi_datamover_read
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
module axi_datamover_read #(
    parameter                               AXIS_FIFO_DEPTH = 32,
    parameter                               MM2S_DATA_WIDTH = 64,
    parameter                               MM2S_CMD_WIDTH  = 72,
    parameter                               MM2S_ADDR_WIDTH = 32,
    parameter                               MM2S_SIZE_WIDTH = 16,
    parameter                               MM2S_STS_WIDTH  = 32
)(
    // >>>>>>>>>> sys
    input                                   clk                 ,
    input                                   rstn                ,
    // >>>>>>>>>> ddr_read
    output                                  ddr_rreq_ready      ,
    input                                   ddr_rreq_valid      ,
    input       [MM2S_ADDR_WIDTH-1:0]       ddr_rreq_addr       ,
    input       [MM2S_SIZE_WIDTH-1:0]       ddr_rreq_size       ,
    input                                   ddr_rdata_ready     ,
    output                                  ddr_rdata_valid     ,
    output                                  ddr_rdata_last      ,
    output      [MM2S_DATA_WIDTH-1:0]       ddr_rdata           ,
    output  reg                             ddr_rresp_valid     ,
    output  reg [1:0]                       ddr_rresp           ,
    // >>>>>>>>>> axis_read
    output  reg [MM2S_CMD_WIDTH-1:0]        mm2s_cmd_tdata      ,
    input                                   mm2s_cmd_tready     ,
    output  reg                             mm2s_cmd_tvalid     ,
    input       [MM2S_DATA_WIDTH-1:0]       mm2s_tdata          ,
    input       [MM2S_DATA_WIDTH/8-1:0]     mm2s_tkeep          ,
    input                                   mm2s_tlast          , 
    output                                  mm2s_tready         ,
    input                                   mm2s_tvalid         ,
    input       [MM2S_STS_WIDTH-1:0]        mm2s_sts_tdata      ,
    input       [MM2S_STS_WIDTH/8-1:0]      mm2s_sts_tkeep      ,
    input                                   mm2s_sts_tlast      ,
    output                                  mm2s_sts_tready     ,
    input                                   mm2s_sts_tvalid
    );

// >>>>>>>>>> var
// cmd
wire    [3:0]                               cmd_xcache, cmd_xuser, cmd_rsv, cmd_tag;
wire                                        cmd_drr, cmd_eof, cmd_type;
wire    [5:0]                               cmd_dsa;
wire    [MM2S_ADDR_WIDTH-1:0]               cmd_saddr;
wire    [22:0]                              cmd_btt;

// >>>>>>>>>> cmd
assign cmd_xcache       = 'd0;
assign cmd_xuser        = 'd0;
assign cmd_rsv          = 'd0;
assign cmd_tag          = 'd0;
assign cmd_drr          = 'd0;
assign cmd_eof          = 'd0;
assign cmd_type         = 'd1;
assign cmd_dsa          = 'd0;
assign cmd_btt          = ddr_rreq_size;
assign cmd_saddr        = ddr_rreq_addr;
assign ddr_rreq_ready   = mm2s_cmd_tready;

always @(posedge clk or negedge rstn) begin
    if(rstn == 1'd0)
        mm2s_cmd_tdata <= 'd0;
    else if(ddr_rreq_valid == 1'd1 && ddr_rreq_ready == 1'd1)
        mm2s_cmd_tdata <= {cmd_rsv, cmd_tag, cmd_saddr, cmd_drr, cmd_eof, cmd_dsa, cmd_type, cmd_btt};
end

always @(posedge clk or negedge rstn) begin
    if(rstn == 1'd0)
        mm2s_cmd_tvalid <= 1'd0;
    else
        mm2s_cmd_tvalid <= (ddr_rreq_valid == 1'd1) && (ddr_rreq_ready == 1'd1);
end

// >>>>>>>>>> resp
assign mm2s_sts_tready  = 'd1;

always @(posedge clk or negedge rstn) begin
    if(rstn == 1'd0)
        ddr_rresp <= 'd0;
    else if(mm2s_sts_tready == 1'd1 && mm2s_sts_tvalid == 1'd1 && mm2s_sts_tkeep == {(MM2S_DATA_WIDTH/8){1'd1}}) begin
        ddr_rresp <= (mm2s_sts_tdata[7:0] == 'h80) ? 'd0 : 'd3;
    end
end

always @(posedge clk or negedge rstn) begin
    if(rstn == 1'd0)
        ddr_rresp_valid <= 1'd0;
    else
        ddr_rresp_valid <= (mm2s_sts_tready == 1'd1) && (mm2s_sts_tvalid == 1'd1) && (mm2s_sts_tkeep == {(MM2S_DATA_WIDTH/8){1'd1}});
end

// >>>>>>>>>> data
axis_async_fifo #(
    .DATA_WIDTH             (MM2S_DATA_WIDTH    ),
    .FIFO_DEPTH             (AXIS_FIFO_DEPTH    )
)
u_ddr_rdata_fifo (
    .rstn                   (rstn               ),
    .s_aclk                 (clk                ),
    .s_axis_tready          (mm2s_tready        ),
    .s_axis_tvalid          (mm2s_tvalid        ),
    .s_axis_tdata           (mm2s_tdata         ),
    .s_axis_tkeep           (mm2s_tkeep         ),
    .s_axis_tlast           (mm2s_tlast         ),
    .m_aclk                 (clk                ),
    .m_axis_tready          (ddr_rdata_ready    ),
    .m_axis_tvalid          (ddr_rdata_valid    ),
    .m_axis_tdata           (ddr_rdata          ),
    .m_axis_tkeep           (                   ),
    .m_axis_tlast           (ddr_rdata_last     )
    );

endmodule
