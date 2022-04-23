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
    parameter                               DATA_WIDTH      = 64,
    parameter                               CMD_WIDTH       = 72,
    parameter                               ADDR_WIDTH      = 32,
    parameter                               LEN_WIDTH       = 16,
    parameter                               STS_WIDTH       = 32
)(
    // >>>>>>>>>> sys
    input                                   clk                 ,
    input                                   rstn                ,
    // >>>>>>>>>> usr_cfg
    input                                   start               ,
    output                                  wready              ,
    input       [ADDR_WIDTH-1 : 0]          waddr               ,
    input       [LEN_WIDTH-1 : 0]           wdata_len           ,
    input                                   wdata_vld           ,
    input       [DATA_WIDTH-1 : 0]          wdata               ,
    // >>>>>>>>>> axis_write
    output  reg [CMD_WIDTH-1 : 0]           s2mm_cmd_tdata      ,
    input                                   s2mm_cmd_tready     ,
    output  reg                             s2mm_cmd_tvalid     ,
    output  reg [DATA_WIDTH-1 : 0]          s2mm_tdata          ,
    output      [(DATA_WIDTH/8)-1 : 0]      s2mm_tkeep          ,
    output  reg                             s2mm_tlast          , 
    input                                   s2mm_tready         ,
    output  reg                             s2mm_tvalid         ,
    input       [STS_WIDTH-1 : 0]           s2mm_sts_tdata      ,
    input       [(STS_WIDTH/8)-1 : 0]       s2mm_sts_tkeep      ,
    input                                   s2mm_sts_tlast      ,
    output  reg                             s2mm_sts_tready     ,
    input                                   s2mm_sts_tvalid
    );

// >>>>>>>>>> var
// cmd
wire    [3 : 0]                             cmd_xcache, cmd_xuser, cmd_rsv, cmd_tag;
wire                                        cmd_drr, cmd_eof, cmd_type;
wire    [5 : 0]                             cmd_dsa;
wire    [ADDR_WIDTH-1 : 0]                  cmd_saddr;
wire    [22 : 0]                            cmd_btt;
// data
reg                                         write_en;
reg     [LEN_WIDTH-1 : 0]                   wdata_cnt;

// >>>>>>>>>> cmd
assign cmd_xcache   = 4'd0;
assign cmd_xuser    = 4'd0;
assign cmd_rsv      = 4'd0;
assign cmd_tag      = 4'd0;
assign cmd_drr      = 1'd0;
assign cmd_eof      = 1'd0;
assign cmd_type     = 1'd1;
assign cmd_dsa      = 6'd0;
assign cmd_btt      = wdata_len;
assign cmd_saddr    = waddr;
assign wready       = s2mm_tready;

always @(posedge clk or negedge rstn) begin
    if(rstn == 1'd0)
        s2mm_cmd_tdata <= 'd0;
    else if(start == 1'd1 && s2mm_cmd_tready == 1'd1)
        s2mm_cmd_tdata <= {cmd_rsv, cmd_tag, cmd_saddr, cmd_drr, cmd_eof, cmd_dsa, cmd_type, cmd_btt};
end

always @(posedge clk or negedge rstn) begin
    if(rstn == 1'd0)
        s2mm_cmd_tvalid <= 1'd0;
    else
        s2mm_cmd_tvalid <= (start == 1'd1) && (s2mm_cmd_tready == 1'd1);
end

// >>>>>>>>>> data
always @(posedge clk or negedge rstn) begin
    if(rstn == 1'd0)
        write_en <= 1'd0;
    else if(start == 1'd1 && s2mm_cmd_tready == 1'd1)
        write_en <= 1'd1;
    else if(s2mm_tlast == 1'd1)
        write_en <= 1'd0;
end

always @(posedge clk or negedge rstn) begin
    if(rstn == 1'd0)
        wdata_cnt <= 'd0;
    else if(wdata_vld == 1'd1 && wready == 1'd1) begin
        if(wdata_cnt == (wdata_len[LEN_WIDTH-1 : 3]-1))
            wdata_cnt <= 'd0;
        else
            wdata_cnt <= wdata_cnt + 1;
    end
end

assign s2mm_tkeep   = (s2mm_tvalid == 1'd1) ? {(DATA_WIDTH/8){1'd1}} : 'd0;

always @(posedge clk or negedge rstn) begin
    if(rstn == 1'd0)
        s2mm_tdata <= 'd0;
    else if(write_en == 1'd1 && wdata_vld == 1'd1 && s2mm_tready == 1'd1)
        s2mm_tdata <= wdata;
end

always @(posedge clk or negedge rstn) begin
    if(rstn == 1'd0)
        s2mm_tlast <= 1'd0;
    else if(wdata_cnt == (wdata_len[LEN_WIDTH-1 : 3]-1) && wdata_vld == 1'd1)
        s2mm_tlast <= 1'd1;
    else
        s2mm_tlast <= 1'd0;
end

always @(posedge clk or negedge rstn) begin
    if(rstn == 1'd0)
        s2mm_tvalid <= 1'd0;
    else
        s2mm_tvalid <= (write_en == 1'd1) && (wdata_vld == 1'd1);
end

always @(posedge clk or negedge rstn) begin
    if(rstn == 1'd0)
        s2mm_sts_tready <= 1'd0;
    else
        s2mm_sts_tready <= 1'd1;
end

endmodule
