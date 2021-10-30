`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/09/15 14:08:43
// Design Name: 
// Module Name: test_axis_tx_gen
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
module test_axis_tx_gen #(
    parameter                               AXIS_DATA_WIDTH     = 64    ,
    parameter                               LEN_WIDTH           = 16    ,
    parameter                               TEST_TX_SIZE        = 1024
)(
    // >>>>>>>>>> sys
    input                                   clk                     ,
    input                                   rstn                    ,
    input                                   test_en                 ,
    // >>>>>>>>>> axis
    output      [LEN_WIDTH-1 : 0]           tx_size                 ,
    output  reg [AXIS_DATA_WIDTH-1 : 0]     tx_axis_tdata           ,
    output  reg [AXIS_DATA_WIDTH/8-1 : 0]   tx_axis_tkeep           ,
    output                                  tx_axis_tvalid          ,
    output                                  tx_axis_tlast           ,
    input                                   tx_axis_tready
    );

// >>>>>>>>>> var
localparam                                  ETH_ADDR_WIDTH  = 48;
reg                                         test_tx_en;
reg     [$clog2(TEST_TX_SIZE/8)-1 : 0]      test_tx_cnt;
wire                                        test_en_rising, test_en_falling;
wire    [ETH_ADDR_WIDTH-1 : 0]              src_addr, dst_addr;

// >>>>>>>>>> pulse
sig_pulse #(
    .DEPTH              (1                  )
)
u_test_en_pulse (
    .clk                (clk                ),
    .rstn               (rstn               ),
    .sig                (test_en            ),
    .sig_rising         (test_en_rising     ),
    .sig_falling        (test_en_falling    )
    );

// >>>>>>>>>> ctrl
always @(posedge clk or negedge rstn) begin
    if(rstn == 1'd0)
        test_tx_en <= 1'd0;
    else if(test_en_rising == 1'd1)
        test_tx_en <= 1'd1;
    else if(tx_axis_tlast == 1'd1)
        test_tx_en <= 1'd0;
end

always @(posedge clk or negedge rstn) begin
    if(rstn == 1'd0)
        test_tx_cnt <= 'd0;
    else if(test_tx_en == 1'd1 && tx_axis_tready == 1'd1) begin
        if(test_tx_cnt == (TEST_TX_SIZE/8-1))
            test_tx_cnt <= 'd0;
        else
            test_tx_cnt <= test_tx_cnt + 1'd1;
    end
end

// >>>>>>>>>> axis
assign tx_size          = TEST_TX_SIZE;
assign tx_axis_tlast    = (tx_axis_tvalid == 1'd1) && (test_tx_cnt == (TEST_TX_SIZE/8-1));
assign tx_axis_tvalid   = (test_tx_en == 1'd1) & (tx_axis_tready == 1'd1);
assign src_addr         = 48'ha0a0_a0a0_a0a0;
assign dst_addr         = 48'ha1a1_a1a1_a1a1;

always @(posedge clk or negedge rstn) begin
    if(rstn == 1'd0)
        tx_axis_tdata <= 'd0;
    else if(test_tx_en == 1'd1 && tx_axis_tready == 1'd1)
        tx_axis_tdata <= tx_axis_tdata + 1'd1;
end

always @(*) begin
    if(rstn == 1'd0)
        tx_axis_tkeep = 'd0;
    else if(tx_axis_tvalid == 1'd1) begin
        if(test_tx_cnt == (TEST_TX_SIZE/8-1))
            tx_axis_tkeep = {(AXIS_DATA_WIDTH/8-2){1'd1}};
        else
            tx_axis_tkeep = {(AXIS_DATA_WIDTH/8){1'd1}};
    end
end

endmodule
