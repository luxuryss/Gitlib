`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/09/15 15:00:24
// Design Name: 
// Module Name: test_cfg
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
module test_cfg #(
    parameter                               REG_ADDR_WIDTH      = 32,
    parameter                               REG_DATA_WIDTH      = 3
)(
    // >>>>>>>>>> sys
    input                                   clk                     ,
    input                                   rstn                    ,
    output  reg                             eth_en                  ,
    input                                   eth_init_done           ,
    // >>>>>>>>>> test_ctrl
    input                                   test_cfg_type           ,
    input                                   test_cfg_wr_en          ,
    input       [REG_ADDR_WIDTH-1 : 0]      test_cfg_wr_addr        ,
    input       [REG_DATA_WIDTH-1 : 0]      test_cfg_wr_data        ,
    input                                   test_cfg_rd_en          ,
    input       [REG_ADDR_WIDTH-1 : 0]      test_cfg_rd_addr        ,
    output  reg [REG_DATA_WIDTH-1 : 0]      test_cfg_rd_data        ,
    // >>>>>>>>>> usr_cfg
    output                                  usr_cfg_type            ,
    output  reg                             usr_wr_en               ,
    output  reg [REG_ADDR_WIDTH-1 : 0]      usr_wr_addr             ,
    output  reg [REG_DATA_WIDTH-1 : 0]      usr_wr_data             ,
    output  reg                             usr_rd_en               ,
    output  reg [REG_ADDR_WIDTH-1 : 0]      usr_rd_addr             ,
    input                                   usr_rd_vld              ,
    input       [REG_DATA_WIDTH-1 : 0]      usr_rd_data
    );

// >>>>>>>>>> var
wire                    test_cfg_wr_en_rising, test_cfg_wr_en_falling, test_cfg_rd_en_rising, test_cfg_rd_en_falling;

// >>>>>>>>>> pulse
sig_pulse #(
    .DEPTH              (1                      )
)
u_test_cfg_wr_en_pulse (
    .clk                (clk                    ),
    .rstn               (rstn                   ),
    .sig                (test_cfg_wr_en         ),
    .sig_rising         (test_cfg_wr_en_rising  ),
    .sig_falling        (test_cfg_wr_en_falling )
    );

sig_pulse #(
    .DEPTH              (1                      )
)
u_test_cfg_rd_en_pulse (
    .clk                (clk                    ),
    .rstn               (rstn                   ),
    .sig                (test_cfg_rd_en         ),
    .sig_rising         (test_cfg_rd_en_rising  ),
    .sig_falling        (test_cfg_rd_en_falling )
    );

// >>>>>>>>>> test_cfg
assign usr_cfg_type     = (eth_init_done == 1'd1) ? test_cfg_type : 1'd0;

always @(posedge clk or negedge rstn) begin
    if(rstn == 1'd0)
        eth_en <= 1'd0;
    else
        eth_en <= 1'd1;
end

always @(posedge clk or negedge rstn) begin
    if(rstn == 1'd0) begin
        usr_wr_en       <= 1'd0;
        usr_wr_addr     <= 'd0;
        usr_wr_data     <= 'd0;
    end
    else if(eth_init_done == 1'd1 && test_cfg_wr_en_rising == 1'd1) begin
        usr_wr_en       <= 1'd1;
        usr_wr_addr     <= test_cfg_wr_addr;
        usr_wr_data     <= test_cfg_wr_data;
    end
    else begin
        usr_wr_en       <= 1'd0;
        usr_wr_addr     <= usr_wr_addr;
        usr_wr_data     <= usr_wr_data;        
    end
end

always @(posedge clk or negedge rstn) begin
    if(rstn == 1'd0) begin
        usr_rd_en       <= 1'd0;
        usr_rd_addr     <= 'd0;
    end
    else if(eth_init_done == 1'd1 && test_cfg_rd_en_rising == 1'd1) begin
        usr_rd_en       <= 1'd1;
        usr_rd_addr     <= test_cfg_rd_addr;
    end
    else begin
        usr_rd_en       <= 1'd0;
        usr_rd_addr     <= usr_rd_addr;
    end
end

always @(posedge clk or negedge rstn) begin
    if(rstn == 1'd0)
        test_cfg_rd_data <= 1'd0;
    else if(usr_rd_vld == 1'd1)
        test_cfg_rd_data <= usr_rd_data;
end

endmodule
