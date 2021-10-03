`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/09/05 13:48:21
// Design Name: 
// Module Name: eth_cfg
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
module eth_cfg #(
    parameter                               S_AXI_ADDR_WIDTH    = 11,
    parameter                               S_AXI_DATA_WIDTH    = 32,
    parameter                               REG_ADDR_WIDTH      = 32,
    parameter                               REG_DATA_WIDTH      = 32,
    parameter                               S_AXI_CFG_GAP       = 7
)(
    // >>>>>>>>>> sys
    input                                   s_axi_aclk              ,
    input                                   s_axi_aresetn           ,
    // >>>>>>>>>> usr_cfg
    output                                  cfg_busy                ,
    output  reg [1 : 0]                     cfg_resp                ,
    input                                   cfg_wr_en               ,
    input       [REG_ADDR_WIDTH-1 : 0]      cfg_wr_addr             ,
    input       [REG_DATA_WIDTH-1 : 0]      cfg_wr_data             ,
    input                                   cfg_rd_en               ,
    input       [REG_ADDR_WIDTH-1 : 0]      cfg_rd_addr             ,
    output  reg                             cfg_rd_vld              ,
    output  reg [REG_DATA_WIDTH-1 : 0]      cfg_rd_data             ,
    // >>>>>>>>>> axi_cfg
    output  reg [S_AXI_ADDR_WIDTH-1 : 0]    s_axi_awaddr            ,
    output  reg                             s_axi_awvalid           ,
    input                                   s_axi_awready           ,
    output  reg [S_AXI_DATA_WIDTH-1 : 0]    s_axi_wdata             ,
    output  reg                             s_axi_wvalid            ,
    input                                   s_axi_wready            ,
    input       [1 : 0]                     s_axi_bresp             ,
    input                                   s_axi_bvalid            ,
    output  reg                             s_axi_bready            ,
    output  reg [S_AXI_ADDR_WIDTH-1 : 0]    s_axi_araddr            ,
    output  reg                             s_axi_arvalid           ,
    input                                   s_axi_arready           ,
    input       [S_AXI_DATA_WIDTH-1 : 0]    s_axi_rdata             ,
    input       [1 : 0]                     s_axi_rresp             ,
    input                                   s_axi_rvalid            ,
    output  reg                             s_axi_rready
    );

// >>>>>>>>>> var
reg                                         axi_cfg_wait;
reg     [$clog2(S_AXI_CFG_GAP)-1 : 0]       axi_cfg_wait_cnt;

// >>>>>>>>>> cfg_ctrl
assign cfg_busy = axi_cfg_wait;

always @(posedge s_axi_aclk or negedge s_axi_aresetn) begin
    if(s_axi_aresetn == 1'd0)
        axi_cfg_wait_cnt <= 'd0;
    else if(axi_cfg_wait == 1'd1) begin
        if(axi_cfg_wait_cnt == (S_AXI_CFG_GAP-1))
            axi_cfg_wait_cnt <= 'd0;
        else
            axi_cfg_wait_cnt <= axi_cfg_wait_cnt + 1'd1;
    end
end

always @(posedge s_axi_aclk or negedge s_axi_aresetn) begin
    if(s_axi_aresetn == 1'd0)
        axi_cfg_wait <= 1'd0;
    else if(s_axi_awready == 1'd1 || s_axi_arready == 1'd1)
        axi_cfg_wait <= 1'd1;
    else if(axi_cfg_wait_cnt == (S_AXI_CFG_GAP-1))
        axi_cfg_wait <= 1'd0;
end

always @(posedge s_axi_aclk or negedge s_axi_aresetn) begin
    if(s_axi_aresetn == 1'd0)
        cfg_resp <= 2'd0;
    else if(s_axi_bvalid == 1'd1)
        cfg_resp <= s_axi_bresp;
    else if(s_axi_rvalid == 1'd1)
        cfg_resp <= s_axi_rresp;
end

// >>>>>>>>>> axi_write
always @(posedge s_axi_aclk or negedge s_axi_aresetn) begin
    if(s_axi_aresetn == 1'd0) begin
        s_axi_awaddr    <= 'd0;
        s_axi_awvalid   <= 1'd0;
    end
    else if(s_axi_awready == 1'd1) begin
        s_axi_awaddr    <= 'd0;
        s_axi_awvalid   <= 1'd0;    
    end
    else if(cfg_wr_en == 1'd1) begin
        s_axi_awaddr    <= cfg_wr_addr;
        s_axi_awvalid   <= 1'd1;
    end
end

always @(posedge s_axi_aclk or negedge s_axi_aresetn) begin
    if(s_axi_aresetn == 1'd0) begin
        s_axi_wdata     <= 'd0;
        s_axi_wvalid    <= 1'd0;
    end
    else if(s_axi_wready == 1'd1) begin
        s_axi_wdata     <= 'd0;
        s_axi_wvalid    <= 1'd0;   
    end
    else if(cfg_wr_en == 1'd1) begin
        s_axi_wdata     <= cfg_wr_data;
        s_axi_wvalid    <= 1'd1;
    end
end

always @(posedge s_axi_aclk or negedge s_axi_aresetn) begin
    if(s_axi_aresetn == 1'd0)
        s_axi_bready <= 1'd0;
    else if(s_axi_bvalid == 1'd1)
        s_axi_bready <= 1'd0;
    else if(cfg_wr_en == 1'd1)
        s_axi_bready <= 1'd1;
end

// >>>>>>>>>> axi_read
always @(posedge s_axi_aclk or negedge s_axi_aresetn) begin
    if(s_axi_aresetn == 1'd0) begin
        s_axi_araddr    <= 'd0;
        s_axi_arvalid   <= 1'd0;
    end
    else if(s_axi_arready == 1'd1) begin
        s_axi_araddr    <= 'd0;
        s_axi_arvalid   <= 1'd0;    
    end
    else if(cfg_rd_en == 1'd1) begin
        s_axi_araddr    <= cfg_rd_addr;
        s_axi_arvalid   <= 1'd1;
    end
end

always @(posedge s_axi_aclk or negedge s_axi_aresetn) begin
    if(s_axi_aresetn == 1'd0)
        s_axi_rready <= 1'd0;
    else if(s_axi_rvalid == 1'd1)
        s_axi_rready <= 1'd0;
    else if(cfg_rd_en == 1'd1)
        s_axi_rready <= 1'd1;
end

always @(posedge s_axi_aclk or negedge s_axi_aresetn) begin
    if(s_axi_aresetn == 1'd0) begin
        cfg_rd_vld      <= 'd0;
        cfg_rd_data     <= 'd0;
    end
    else if(s_axi_rvalid == 1'd1) begin
        cfg_rd_vld      <= 1'd1;
        cfg_rd_data     <= s_axi_rdata;    
    end
    else begin
        cfg_rd_vld      <= 1'd0;
        cfg_rd_data     <= cfg_rd_data;        
    end
end

endmodule
