`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/10/30 21:16:23
// Design Name: 
// Module Name: eth_tx_gen
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
module eth_tx_gen #(
    parameter                                   AXIS_DATA_WIDTH = 64
)(
    // >>>>>>>>>> sys
    input                                       clk                 ,
    input                                       rstn                ,
    // >>>>>>>>>> param
    input       [47 : 0]                        local_addr          ,
    input       [47 : 0]                        remote_addr         ,
    input       [15 : 0]                        tx_size             ,
    // >>>>>>>>>> orin_data_frame
    input       [AXIS_DATA_WIDTH-1 : 0]         tx_orin_tdata       ,
    input       [AXIS_DATA_WIDTH/8-1 : 0]       tx_orin_tkeep       ,
    input                                       tx_orin_tvalid      ,
    input                                       tx_orin_tlast       ,
    input                                       tx_orin_tuser       ,
    output                                      tx_orin_tready      ,
    // >>>>>>>>>> eth_data_frame
    output  reg [AXIS_DATA_WIDTH-1 : 0]         tx_frame_tdata      ,
    output  reg [AXIS_DATA_WIDTH/8-1 : 0]       tx_frame_tkeep      ,
    output                                      tx_frame_tvalid     ,
    output                                      tx_frame_tlast      ,
    output                                      tx_frame_tuser      ,
    input                                       tx_frame_tready
    );

// >>>>>>>>>> param
localparam                                      NUM_HEAD_BYTES  = 128;
localparam                                      NUM_DLY         = NUM_HEAD_BYTES/AXIS_DATA_WIDTH;

// >>>>>>>>>> var
reg     [1 : 0]                                 tx_head_cnt;
wire    [NUM_DLY : 0][AXIS_DATA_WIDTH-1 : 0]    tx_orin_tdata_dly;
wire    [NUM_DLY : 0]                           tx_orin_tdata_vld_dly;
wire    [NUM_DLY : 0]                           tx_orin_tlast_dly;
wire                                            tx_en;

// >>>>>>>>>> eth_tx_frame
assign tx_frame_tuser   = tx_frame_tuser;
assign tx_orin_tready   = tx_frame_tready;
assign tx_en            = tx_orin_tvalid | (|tx_orin_tdata_vld_dly[NUM_DLY : 1]);
assign tx_frame_tvalid  = (tx_en == 1'd1) && (tx_frame_tready == 1'd1);
assign tx_frame_tlast   = tx_orin_tlast_dly[NUM_DLY];

sig_sync #(
    .WIDTH                  (AXIS_DATA_WIDTH        ),
    .DEPTH                  (NUM_DLY                )
)
u_tx_orin_data_dly (
    .clk                    (clk                    ),
    .rstn                   (rstn                   ),
    .sig_in_vld             (tx_orin_tvalid         ),
    .sig_in                 (tx_orin_tdata          ),
    .sig_out_vld            (                       ),
    .sig_out                (                       ),
    .sig_reg_vld            (tx_orin_tdata_vld_dly  ),
    .sig_reg                (tx_orin_tdata_dly      )
    );

sig_sync #(
    .WIDTH                  (1                      ),
    .DEPTH                  (NUM_DLY                )
)
u_tx_orin_tlast_dly (
    .clk                    (clk                    ),
    .rstn                   (rstn                   ),
    .sig_in_vld             (1'd1                   ),
    .sig_in                 (tx_orin_tlast          ),
    .sig_out                (                       ),
    .sig_reg_vld            (                       ),
    .sig_reg                (tx_orin_tlast_dly      )
    );

always @(posedge clk or negedge rstn) begin
    if(rstn == 1'd0)
        tx_head_cnt <= 2'd0;
    else if(tx_frame_tlast == 1'd1)
        tx_head_cnt <= 2'd0;
    else if(tx_frame_tvalid == 1'd1) begin
        if(tx_head_cnt == (NUM_DLY-1)) 
            tx_head_cnt <= tx_head_cnt;
        else
            tx_head_cnt <= tx_head_cnt + 1;
    end
end

always @(*) begin
    if(rstn == 1'd0)
        tx_frame_tkeep <= 'd0;
    else if(tx_frame_tvalid == 1'd1) begin
        if(tx_orin_tlast_dly[NUM_DLY] == 1'd1)
            tx_frame_tkeep <= {(AXIS_DATA_WIDTH/8-2){1'd1}};
        else
            tx_frame_tkeep <= {(AXIS_DATA_WIDTH/8){1'd1}};
    end
end

generate
    if(AXIS_DATA_WIDTH == 64) begin : u_tx_64bit
        always @(posedge clk or negedge rstn) begin
            if(rstn == 1'd0)
                tx_frame_tdata <= 'd0;
            else if(tx_frame_tready == 1'd1 && tx_en == 1'd1) begin
                if(tx_head_cnt == 2'd0)
                    tx_frame_tdata <= {local_addr[15 : 0], remote_addr};
                else if(tx_head_cnt == 2'd1)
                    tx_frame_tdata <= {tx_orin_tdata_dly[NUM_DLY-1][15 : 0], tx_size, local_addr[47 : 16]};
                else if(tx_orin_tlast_dly[NUM_DLY-1] == 1'd1)
                    tx_frame_tdata <= {16'd0, tx_orin_tdata_dly[NUM_DLY-1][AXIS_DATA_WIDTH-1 : 16]};
                else
                    tx_frame_tdata <= {tx_orin_tdata_dly[NUM_DLY-1][15 : 0], tx_orin_tdata_dly[NUM_DLY][AXIS_DATA_WIDTH-1 : 16]};
            end
        end
    end
    if(AXIS_DATA_WIDTH == 32) begin : u_tx_32bit
        always @(posedge clk or negedge rstn) begin
            if(rstn == 1'd0)
                tx_frame_tdata <= 'd0;
            else if(tx_frame_tready == 1'd1 && tx_en == 1'd1) begin
                if(tx_head_cnt == 2'd0)
                    tx_frame_tdata <= {remote_addr[31 : 0]};
                else if(tx_head_cnt == 2'd1)
                    tx_frame_tdata <= {local_addr[15 : 0], remote_addr[47 : 32]};
                else if(tx_head_cnt == 2'd2)
                    tx_frame_tdata <= {local_addr[47 : 16]};
                else if(tx_head_cnt == 2'd3)
                    tx_frame_tdata <= {tx_orin_tdata_dly[NUM_DLY-1][15 : 0], tx_size};
                else if(tx_frame_tlast == 1'd1)
                    tx_frame_tdata <= {16'd0, tx_orin_tdata_dly[NUM_DLY-1][AXIS_DATA_WIDTH-1 : 16]};
                else
                    tx_frame_tdata <= {tx_orin_tdata_dly[NUM_DLY-1][15 : 0], tx_orin_tdata_dly[NUM_DLY][AXIS_DATA_WIDTH-1 : 16]};
            end
        end    
    end
endgenerate

endmodule
