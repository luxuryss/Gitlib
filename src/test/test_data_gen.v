`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/10/23 20:37:18
// Design Name: 
// Module Name: test_data_gen
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
module test_data_gen #(
    parameter                           WDATA_WIDTH     = 64,
    parameter                           RDATA_WIDTH     = 64,
    parameter                           ADDR_WIDTH      = 32,
    parameter                           LEN_WIDTH       = 16
)(
    // >>>>>>>>>> sys
    input                               clk                 ,
    input                               rstn                ,
    input                               test_en             ,
    // >>>>>>>>>> usr
    output  reg                         wstart              ,
    input                               wready              ,
    output  reg [ADDR_WIDTH-1 : 0]      waddr               ,
    output  reg [LEN_WIDTH-1 : 0]       wdata_len           ,
    output  reg                         wdata_vld           ,
    output  reg [WDATA_WIDTH-1 : 0]     wdata               ,
    output  reg                         rstart              ,
    input                               rready              ,
    output  reg [ADDR_WIDTH-1 : 0]      raddr               ,
    output  reg [LEN_WIDTH-1 : 0]       rdata_len           ,
    input                               rdata_vld           ,
    input       [RDATA_WIDTH-1 : 0]     rdata
    );

// >>>>>>>>>> var
localparam                              DATA_LEN    = 1024;
reg     [15 : 0]                        test_cnt;

// >>>>>>>>>> cnt
always @(posedge clk or negedge rstn) begin
    if(rstn == 1'd0)
        test_cnt <= 'd0;
    else if(test_en == 1'd1)
        test_cnt <= test_cnt + 1'd1;
end

// >>>>>>>>>> test_write
always @(posedge clk or negedge rstn) begin
    if(rstn == 1'd0) begin
        wstart      <= 1'd0;
        waddr       <= 'h0;
        wdata_len   <= 'd0;
    end
    else if(test_cnt == 16'd100) begin
        wstart      <= 1'd1;
        waddr       <= 'h8000_0200;
        wdata_len   <= DATA_LEN;        
    end
    else begin
        wstart      <= 1'd0;
        waddr       <= waddr;
        wdata_len   <= wdata_len;        
    end
end

always @(posedge clk or negedge rstn) begin
    if(rstn == 1'd0)
        wdata_vld <= 1'd0;
    else if(wready == 1'd0)
        wdata_vld <= 1'd0;
    else if(test_cnt == 16'd120)
        wdata_vld <= 1'd1;
    else if(wdata == (DATA_LEN/8-1))
        wdata_vld <= 1'd0;
end

always @(posedge clk or negedge rstn) begin
    if(rstn == 1'd0)
        wdata <= 'd0;
    else if(wdata_vld == 1'd1)
        wdata <= wdata + 1'd1;
end

// >>>>>>>>>> test_read
always @(posedge clk or negedge rstn) begin
    if(rstn == 1'd0) begin
        rstart      <= 1'd0;
        raddr       <= 'h0;
        rdata_len   <= 'd0;
    end
    else if(test_cnt == 16'd1500) begin
        rstart      <= 1'd1;
        raddr       <= 'h8000_0200;
        rdata_len   <= DATA_LEN;        
    end
    else begin
        rstart      <= 1'd0;
        raddr       <= raddr;
        rdata_len   <= rdata_len;        
    end
end

endmodule
