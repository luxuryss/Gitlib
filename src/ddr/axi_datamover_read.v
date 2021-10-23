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
    parameter                               DATA_WIDTH      = 64,
    parameter                               CMD_WIDTH       = 72,
    parameter                               ADDR_WIDTH      = 32,
    parameter                               LEN_WIDTH       = 16,
    parameter                               STS_WIDTH       = 8
)(
    // >>>>>>>>>> sys
    input                                   clk                 ,
    input                                   rstn                ,
    // >>>>>>>>>> usr
    input                                   start               ,
    output                                  rready              ,
    input       [ADDR_WIDTH-1 : 0]          raddr               ,
    input       [LEN_WIDTH-1 : 0]           rdata_len           ,
    output  reg                             rdata_vld           ,
    output  reg [DATA_WIDTH-1 : 0]          rdata               ,
    // >>>>>>>>>> axis_read
    output  reg [CMD_WIDTH-1 : 0]           mm2s_cmd_tdata      ,
    input                                   mm2s_cmd_tready     ,
    output  reg                             mm2s_cmd_tvalid     ,
    input       [DATA_WIDTH-1 : 0]          mm2s_tdata          ,
    input       [(DATA_WIDTH/8)-1 : 0]      mm2s_tkeep          ,
    input                                   mm2s_tlast          , 
    output  reg                             mm2s_tready         ,
    input                                   mm2s_tvalid         ,
    input       [STS_WIDTH-1 : 0]           mm2s_sts_tdata      ,
    input       [(STS_WIDTH/8)-1 : 0]       mm2s_sts_tkeep      ,
    input                                   mm2s_sts_tlast      ,
    output  reg                             mm2s_sts_tready     ,
    input                                   mm2s_sts_tvalid
    );

// >>>>>>>>>> var
// cmd
wire    [3 : 0]                             cmd_xcache, cmd_xuser, cmd_rsv, cmd_tag;
wire                                        cmd_drr, cmd_eof, cmd_type;
wire    [5 : 0]                             cmd_dsa;
wire    [ADDR_WIDTH-1 : 0]                  cmd_saddr;
wire    [22 : 0]                            cmd_btt;
// data
reg                                         read_en;

// >>>>>>>>>> cmd
assign cmd_xcache   = 4'd0;
assign cmd_xuser    = 4'd0;
assign cmd_rsv      = 4'd0;
assign cmd_tag      = 4'd0;
assign cmd_drr      = 1'd0;
assign cmd_eof      = 1'd0;
assign cmd_type     = 1'd1;
assign cmd_dsa      = 6'd0;
assign cmd_btt      = rdata_len;
assign cmd_saddr    = raddr;
assign rready       = mm2s_tready;

always @(posedge clk or negedge rstn) begin
    if(rstn == 1'd0)
        mm2s_cmd_tdata <= 'd0;
    else if(start == 1'd1 && mm2s_cmd_tready == 1'd1)
        mm2s_cmd_tdata <= {cmd_rsv, cmd_tag, cmd_saddr, cmd_drr, cmd_eof, cmd_dsa, cmd_type, cmd_btt};
end

always @(posedge clk or negedge rstn) begin
    if(rstn == 1'd0)
        mm2s_cmd_tvalid <= 1'd0;
    else
        mm2s_cmd_tvalid <= (start == 1'd1) && (mm2s_cmd_tready == 1'd1);
end

always @(posedge clk or negedge rstn) begin
    if(rstn == 1'd0)
        mm2s_tready <= 1'd0;
    else
        mm2s_tready <= 1'd1;
end

always @(posedge clk or negedge rstn) begin
    if(rstn == 1'd0)
        mm2s_sts_tready <= 1'd0;
    else
        mm2s_sts_tready <= 1'd1;
end

// >>>>>>>>>> data
always @(posedge clk or negedge rstn) begin
    if(rstn == 1'd0)
        read_en <= 1'd0;
    else if(start == 1'd1 && mm2s_cmd_tready == 1'd1)
        read_en <= 1'd1;
    else if(mm2s_tlast == 1'd1)
        read_en <= 1'd0;
end

always @(posedge clk or negedge rstn) begin
    if(rstn == 1'd0)
        rdata <= 'd0;
    else if(read_en == 1'd1 && mm2s_tvalid == 1'd1)
        rdata <= mm2s_tdata;
end

always @(posedge clk or negedge rstn) begin
    if(rstn == 1'd0)
        rdata_vld <= 1'd0;
    else
        rdata_vld <= (read_en == 1'd1) && (mm2s_tvalid == 1'd1);
end

endmodule
