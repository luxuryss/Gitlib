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
    parameter                               AXIS_DATA_WIDTH     = 64
)(
    // >>>>>>>>>> sys
    input                                   clk                     ,
    input                                   rstn                    ,
    input                                   test_en                 ,
    // >>>>>>>>>> axis
    output  reg [AXIS_DATA_WIDTH-1 : 0]     tx_axis_tdata           ,
    output  reg [AXIS_DATA_WIDTH/8-1 : 0]   tx_axis_tkeep           ,
    output                                  tx_axis_tvalid          ,
    output                                  tx_axis_tlast           ,
    input                                   tx_axis_tready
    );

// >>>>>>>>>> var
localparam                                  TEST_TX_LEN     = 128+2;
localparam                                  ETH_ADDR_WIDTH  = 48;
localparam                                  ETH_SIZE_WIDTH  = 16;
reg                                         test_tx_en;
reg     [$clog2(TEST_TX_LEN)-1 : 0]         test_tx_cnt;
wire                                        test_en_rising, test_en_falling;
reg     [7 : 0]                             tx_axis_tdata_tmp;
wire    [ETH_ADDR_WIDTH-1 : 0]              src_addr, dst_addr;
wire    [ETH_SIZE_WIDTH-1 : 0]              tx_size;

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
        if(test_tx_cnt == (TEST_TX_LEN-1))
            test_tx_cnt <= 'd0;
        else
            test_tx_cnt <= test_tx_cnt + 1'd1;
    end
end

// >>>>>>>>>> axis
assign tx_axis_tlast    = (tx_axis_tvalid == 1'd1) && (test_tx_cnt == (TEST_TX_LEN-1));
assign tx_axis_tvalid   = (test_tx_en == 1'd1) & (tx_axis_tready == 1'd1);
assign src_addr         = 48'ha0a0_a0a0_a0a0;
assign dst_addr         = 48'ha1a1_a1a1_a1a1;
assign tx_size          = (TEST_TX_LEN-2) << 2;

always @(posedge clk or negedge rstn) begin
    if(rstn == 1'd0)
        tx_axis_tdata_tmp <= 8'd0;
    else if(test_tx_en == 1'd1 && tx_axis_tready == 1'd1)
        tx_axis_tdata_tmp <= tx_axis_tdata_tmp + 1'd1;
end

generate
    if(AXIS_DATA_WIDTH == 64) begin
        always @(posedge clk or negedge rstn) begin
            if(rstn == 1'd0)
                tx_axis_tdata <= 'd0;
            else if(test_tx_en == 1'd1 && tx_axis_tready == 1'd1) begin
                if(test_tx_cnt == 'd0)
                    tx_axis_tdata <= {src_addr[15 : 0], dst_addr};
                else if(test_tx_cnt == 'd1)
                    tx_axis_tdata <= {{(2){tx_axis_tdata_tmp}}, tx_size, src_addr[47: 16]};
                else if(test_tx_cnt == (TEST_TX_LEN-1))
                    tx_axis_tdata <= {16'd0, {(6){tx_axis_tdata_tmp}}};
                else
                    tx_axis_tdata <= {(8){tx_axis_tdata_tmp}};
            end
        end
        always @(*) begin
            if(rstn == 1'd0)
                tx_axis_tkeep = 'd0;
            else if(tx_axis_tvalid == 1'd1) begin
                if(test_tx_cnt == (TEST_TX_LEN-1))
                    tx_axis_tkeep = {(6){1'd1}};
                else
                    tx_axis_tkeep = {(8){1'd1}};
            end
        end
    end
    if(AXIS_DATA_WIDTH == 32) begin
        always @(posedge clk or negedge rstn) begin
            if(rstn == 1'd0)
                tx_axis_tdata <= 'd0;
            else if(test_tx_en == 1'd1 && tx_axis_tready == 1'd1) begin
                if(test_tx_cnt == 'd0)
                    tx_axis_tdata <= {dst_addr[31 : 0]};
                else if(test_tx_cnt == 'd1)
                    tx_axis_tdata <= {src_addr[15 : 0], dst_addr[47 : 32]};
                else if(test_tx_cnt == 'd2)
                    tx_axis_tdata <= {src_addr[47 : 16]};
                else if(test_tx_cnt == 'd3)
                    tx_axis_tdata <= {{(2){tx_axis_tdata_tmp}}, tx_size};
                else if(test_tx_cnt == (TEST_TX_LEN-1))
                    tx_axis_tdata <= {16'd0, {(2){tx_axis_tdata_tmp}}};
                else
                    tx_axis_tdata <= {(4){tx_axis_tdata_tmp}};
            end
        end
        always @(*) begin
            if(rstn == 1'd0)
                tx_axis_tkeep = 'd0;
            else if(tx_axis_tvalid == 1'd1) begin
                if(test_tx_cnt == (TEST_TX_LEN-1))
                    tx_axis_tkeep = {(2){1'd1}};
                else
                    tx_axis_tkeep = {(4){1'd1}};
            end
        end
    end
endgenerate

endmodule
