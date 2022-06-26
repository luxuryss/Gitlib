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
    parameter                           CFG_ADDR_WIDTH  = 32,
    parameter                           CFG_DATA_WIDTH  = 32,
    parameter                           S2MM_DATA_WIDTH = 64,
    parameter                           S2MM_CMD_WIDTH  = 72,
    parameter                           S2MM_ADDR_WIDTH = 32,
    parameter                           S2MM_SIZE_WIDTH = 16,
    parameter                           S2MM_STS_WIDTH  = 32,
    parameter                           MM2S_DATA_WIDTH = 64,
    parameter                           MM2S_CMD_WIDTH  = 72,
    parameter                           MM2S_ADDR_WIDTH = 32,
    parameter                           MM2S_SIZE_WIDTH = 16,
    parameter                           MM2S_STS_WIDTH  = 8
)(
    // >>>>>>>>>> sys
    input                               clk                 ,
    input                               rstn                ,
    input                               test_en             ,
    input       [CFG_ADDR_WIDTH-1:0]    test_addr           ,
    input       [15:0]                  test_size           ,
    output  reg [7:0]                   test_err_cnt        ,
    // >>>>>>>>>> test_write
    input                               wreq_ready          ,
    output  reg                         wreq_valid          ,
    output  reg [S2MM_ADDR_WIDTH-1:0]   wreq_addr           ,
    output  reg [S2MM_SIZE_WIDTH-1:0]   wreq_size           ,
    input                               wdata_ready         ,
    output  reg                         wdata_valid         ,
    output                              wdata_last          ,
    output  reg [S2MM_DATA_WIDTH-1:0]   wdata               ,
    input                               wresp_valid         ,
    input       [1:0]                   wresp               ,
    // >>>>>>>>>> test_read
    input                               rreq_ready          ,
    output  reg                         rreq_valid          ,
    output  reg [MM2S_ADDR_WIDTH-1:0]   rreq_addr           ,
    output  reg [MM2S_SIZE_WIDTH-1:0]   rreq_size           ,
    output                              rdata_ready         ,
    input                               rdata_valid         ,
    input                               rdata_last          ,
    input       [MM2S_DATA_WIDTH-1:0]   rdata               ,
    input                               rresp_valid         ,
    input       [1:0]                   rresp
    );

// >>>>>>>>>> var
wire                                    test_en_rising;
reg                                     gap_en;
reg     [6:0]                           gap_cnt;
reg                                     test_status;
reg     [12:0]                          wdata_cnt;
reg     [MM2S_DATA_WIDTH-1:0]           check_data;

// >>>>>>>>>> test_ctrl
sig_pulse #(
    .RST_VAL                (0                      )
)
u_test_en_pulse (
    .clk                    (clk                    ),
    .rstn                   (rstn                   ),
    .sig                    (test_en                ),
    .sig_rising             (test_en_rising         ),
    .sig_falling            (                       )
    );

always @(posedge clk or negedge rstn) begin
    if(rstn == 1'd0)
        gap_cnt <= 'd0;
    else if(gap_en == 1'd1) begin
        if(&gap_cnt)
            gap_cnt <= 'd0;
        else
            gap_cnt <= gap_cnt + 1'd1;
    end
end

always @(posedge clk or negedge rstn) begin
    if(rstn == 1'd0)
        gap_en <= 'd0;
    else if(wreq_valid == 1'd1 || wdata_last == 1'd1)
        gap_en <= 'd1;
    else if(&gap_cnt)
        gap_en <= 'd0;
end

always @(posedge clk or negedge rstn) begin
    if(rstn == 1'd0)
        test_status <= 'd0;
    else if(wdata_last == 1'd1)
        test_status <= 'd1;
    else if(rdata_last == 1'd1)
        test_status <= 'd0;
end

// >>>>>>>>>> test_write
always @(posedge clk or negedge rstn) begin
    if(rstn == 1'd0) begin
        wreq_addr   <= 'd0;
        wreq_size   <= 'd0;
    end
    else if(test_en_rising == 1'd1 && wreq_ready == 1'd1) begin
        wreq_addr   <= test_addr;
        wreq_size   <= test_size[15:3];
    end
end

always @(posedge clk or negedge rstn) begin
    if(rstn == 1'd0)
        wreq_valid <= 'd0;
    else
        wreq_valid <= (test_en_rising == 1'd1) && (wreq_ready == 1'd1);
end

always @(posedge clk or negedge rstn) begin
    if(rstn == 1'd0)
        wdata <= 'd0;
    else if(wdata_ready == 1'd1 && wdata_valid == 1'd1) begin
        if(wdata == (test_size[15:3]-1))
            wdata <= 'd0;
        else
            wdata <= wdata + 1'd1;
    end
end

always @(posedge clk or negedge rstn) begin
    if(rstn == 1'd0)
        wdata_valid <= 'd0;
    else if(wdata_ready == 1'd1 && (&gap_cnt) == 1'd1 && test_status == 1'd0)
        wdata_valid <= 'd1;
    else if(wdata == (test_size[15:3]-1))
        wdata_valid <= 'd0;
    else
        wdata_valid <= 'd0;
end

assign wdata_last   = (wdata == (test_size[15:3]-1));

// >>>>>>>>>> test_read
assign rdata_ready  = 1'd1;

always @(posedge clk or negedge rstn) begin
    if(rstn == 1'd0) begin
        rreq_addr   <= 'd0;
        rreq_size   <= 'd0;
    end
    else if(rreq_ready == 1'd1 && (&gap_cnt) == 1'd1 && test_status == 1'd1) begin
        rreq_addr   <= test_addr;
        rreq_size   <= test_size[15:3];
    end
end

always @(posedge clk or negedge rstn) begin
    if(rstn == 1'd0)
        rreq_valid <= 'd0;
    else
        rreq_valid <= (rreq_ready == 1'd1) && ((&gap_cnt) == 1'd1) && (test_status == 1'd1);
end

// >>>>>>>>>> check
always @(posedge clk or negedge rstn) begin
    if(rstn == 1'd0)
        check_data <= 'd0;
    else if(rdata_valid == 1'd1) begin
        if(check_data == (test_size[15:3]-1))
            check_data <= 'd0;
        else
            check_data <= check_data + 1'd1;
    end
end

always @(posedge clk or negedge rstn) begin
    if(rstn == 1'd0)
        test_err_cnt <= 'd0;
    else if(rdata_valid == 1'd1 && check_data != rdata)
        test_err_cnt <= (&test_err_cnt) ? test_err_cnt : (test_err_cnt + 1'd1);
end

endmodule
