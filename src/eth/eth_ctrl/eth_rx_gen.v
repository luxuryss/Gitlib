`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/10/30 22:12:03
// Design Name: 
// Module Name: eth_rx_gen
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
module eth_rx_gen #(
    parameter                                   AXIS_DATA_WIDTH = 64
)(
    // >>>>>>>>>> sys
    input                                       clk                 ,
    input                                       rstn                ,
    // >>>>>>>>>> param
    input       [47 : 0]                        local_addr          ,
    input       [47 : 0]                        remote_addr         ,
    input       [15 : 0]                        rx_size             ,
    // >>>>>>>>>> orin_data_frame
    output  reg [AXIS_DATA_WIDTH-1 : 0]         rx_orin_tdata       ,
    output  reg [AXIS_DATA_WIDTH/8-1 : 0]       rx_orin_tkeep       ,
    output                                      rx_orin_tvalid      ,
    output                                      rx_orin_tlast       ,
    output                                      rx_orin_tuser       ,
    input                                       rx_orin_tready      ,
    // >>>>>>>>>> eth_data_frame
    input       [AXIS_DATA_WIDTH-1 : 0]         rx_frame_tdata      ,
    input       [AXIS_DATA_WIDTH/8-1 : 0]       rx_frame_tkeep      ,
    input                                       rx_frame_tvalid     ,
    input                                       rx_frame_tlast      ,
    input                                       rx_frame_tuser      ,
    output                                      rx_frame_tready
    );

// >>>>>>>>>> param
localparam                                      NUM_HEAD_BYTES  = 128;
localparam                                      NUM_DLY         = NUM_HEAD_BYTES/AXIS_DATA_WIDTH;

// >>>>>>>>>> var
reg     [1 : 0]                                 rx_head_cnt;
wire    [NUM_DLY : 0][AXIS_DATA_WIDTH-1 : 0]    rx_frame_tdata_dly;
wire    [NUM_DLY : 0]                           rx_frame_tdata_vld_dly;
wire    [NUM_DLY : 0]                           rx_frame_tlast_dly;
wire                                            rx_en;
wire                                            rx_match;
reg                                             rx_addr_match, rx_size_match;

// >>>>>>>>>> eth_rx_frame
assign rx_frame_tready  = rx_orin_tready;
assign rx_orin_tuser    = rx_frame_tuser;
assign rx_en            = rx_frame_tvalid | (|rx_frame_tdata_vld_dly[NUM_DLY : 1]);
assign rx_match         = rx_addr_match & rx_size_match;
assign rx_orin_tvalid   = (rx_en == 1'd1) && (rx_orin_tready == 1'd1);
assign rx_orin_tlast    = rx_frame_tlast_dly[NUM_DLY];

sig_sync #(
    .WIDTH                  (AXIS_DATA_WIDTH        ),
    .DEPTH                  (NUM_DLY                )
)
u_rx_frame_data_dly (
    .clk                    (clk                    ),
    .rstn                   (rstn                   ),
    .sig_in_vld             (rx_frame_tvalid        ),
    .sig_in                 (rx_frame_tdata         ),
    .sig_out_vld            (                       ),
    .sig_out                (                       ),
    .sig_reg_vld            (rx_frame_tdata_vld_dly ),
    .sig_reg                (rx_frame_tdata_dly     )
    );

sig_sync #(
    .WIDTH                  (1                      ),
    .DEPTH                  (NUM_DLY                )
)
u_rx_frame_tlast_dly (
    .clk                    (clk                    ),
    .rstn                   (rstn                   ),
    .sig_in_vld             (1'd1                   ),
    .sig_in                 (rx_frame_tlast         ),
    .sig_out                (                       ),
    .sig_reg_vld            (                       ),
    .sig_reg                (rx_frame_tlast_dly     )
    );

always @(posedge clk or negedge rstn) begin
    if(rstn == 1'd0)
        rx_head_cnt <= 2'd0;
    else if(rx_orin_tlast == 1'd1)
        rx_head_cnt <= 2'd0;
    else if(rx_orin_tvalid == 1'd1) begin
        if(rx_head_cnt == (NUM_DLY-1)) 
            rx_head_cnt <= rx_head_cnt;
        else
            rx_head_cnt <= rx_head_cnt + 1;
    end
end

always @(*) begin
    if(rstn == 1'd0)
        rx_orin_tkeep <= 'd0;
    else if(rx_orin_tvalid == 1'd1) begin
        if(rx_frame_tlast_dly[NUM_DLY] == 1'd1)
            rx_orin_tkeep <= {(AXIS_DATA_WIDTH/8-2){1'd1}};
        else
            rx_orin_tkeep <= {(AXIS_DATA_WIDTH/8){1'd1}};
    end
end

generate
    if(AXIS_DATA_WIDTH == 64) begin : u_rx_64bit
        always @(posedge clk or negedge rstn) begin
            if(rstn == 1'd0)
                rx_addr_match <= 1'd0;
            else if(rx_frame_tvalid == 1'd1) begin
                if(rx_head_cnt == 2'd0 && rx_frame_tdata[47 : 0] == local_addr)
                    rx_addr_match <= 1'd1;
                else if(rx_frame_tlast == 1'd1)
                    rx_addr_match <= 1'd0;
            end
        end

        always @(posedge clk or negedge rstn) begin
            if(rstn == 1'd0)
                rx_size_match <= 1'd0; 
            else if(rx_frame_tvalid == 1'd1) begin
                if(rx_head_cnt == (NUM_DLY-1) && rx_frame_tdata[47 : 32] == rx_size)
                    rx_size_match <= 1'd1;
                else if(rx_frame_tlast == 1'd1)
                    rx_size_match <= 1'd0;
            end
        end

        always @(posedge clk or negedge rstn) begin
            if(rstn == 1'd0)
                rx_orin_tdata <= 'd0;
            else if(rx_orin_tready == 1'd1 && rx_match == 1'd1)
                rx_orin_tdata <= {rx_frame_tdata_dly[1][AXIS_DATA_WIDTH-1 : AXIS_DATA_WIDTH-48], rx_frame_tdata_dly[0][15 : 0]};
        end
    end
    if(AXIS_DATA_WIDTH == 32) begin : u_rx_32bit
        always @(posedge clk or negedge rstn) begin
            if(rstn == 1'd0)
                rx_addr_match <= 1'd0;
            else if(rx_frame_tvalid == 1'd1) begin
                if(rx_head_cnt == 2'd1 && {rx_frame_tdata_dly[1][31 : 0], rx_frame_tdata_dly[0][15 : 0]} == local_addr)
                    rx_addr_match <= 1'd1;
                else if(rx_frame_tlast == 1'd1)
                    rx_addr_match <= 1'd0;
            end
        end

        always @(posedge clk or negedge rstn) begin
            if(rstn == 1'd0)
                rx_size_match <= 1'd0; 
            else if(rx_frame_tvalid == 1'd1) begin
                if(rx_head_cnt == 2'd3 && {rx_frame_tdata_dly[0][15 : 0]} == rx_size)
                    rx_size_match <= 1'd1;
                else if(rx_frame_tlast == 1'd1)
                    rx_size_match <= 1'd0;
            end
        end

        always @(posedge clk or negedge rstn) begin
            if(rstn == 1'd0)
                rx_orin_tdata <= 'd0;
            else if(rx_orin_tready == 1'd1 && rx_match == 1'd1)
                rx_orin_tdata <= {rx_frame_tdata_dly[1][AXIS_DATA_WIDTH-1 : AXIS_DATA_WIDTH-16], rx_frame_tdata_dly[0][15 : 0]};
        end
    end
endgenerate

endmodule
