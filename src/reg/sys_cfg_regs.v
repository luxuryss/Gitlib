`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/04/23 15:52:45
// Design Name: 
// Module Name: sys_cfg_regs
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
module sys_cfg_regs #(
    parameter                           ADDR_WIDTH  = 32,
    parameter                           DATA_WIDTH  = 32
)(
    // >>>>>>>>>> clock and reset
    input                               clk             ,
    input                               rstn            ,
    // >>>>>>>>>> axi_bram_controller
    input                               bram_cfg_en     ,
    input       [DATA_WIDTH/4-1:0]      bram_cfg_we     ,
    input       [ADDR_WIDTH-1:0]        bram_cfg_addr   ,
    input       [DATA_WIDTH-1:0]        bram_cfg_data   ,
    output      [DATA_WIDTH-1:0]        bram_cfg_rdbk   ,
    // >>>>>>>>>> sys_regs
    output      [DATA_WIDTH-1:0]        reg_0           ,
    output      [DATA_WIDTH-1:0]        reg_1           ,
    output      [DATA_WIDTH-1:0]        reg_2           ,
    output      [DATA_WIDTH-1:0]        reg_3
    );

// >>>>>>>>>> param
// common
localparam                              REG_NUM             = 4;
// reg_reset_value
localparam                              RST_VAL_REG_0000    = 'h0;
localparam                              RST_VAL_REG_0004    = 'h0;
localparam                              RST_VAL_REG_0008    = 'h0;
localparam                              RST_VAL_REG_000C    = 'h0;
// reg_base_addr
localparam                              BASE_ADDR_REG_0000  = 'h0;
localparam                              BASE_ADDR_REG_0004  = 'h4;
localparam                              BASE_ADDR_REG_0008  = 'h8;
localparam                              BASE_ADDR_REG_000C  = 'hC;
// reg_index
localparam                              REG_BASE_ADDR       = 32'h0001_0000;
localparam                              REG_ADDR_MASK       = 32'h0000_FFFF;
localparam                              REG_0000_INDEX      = 0;
localparam                              REG_0004_INDEX      = 1;
localparam                              REG_0008_INDEX      = 2;
localparam                              REG_000C_INDEX      = 3;

// >>>>>>>>>> cfg_port
reg                                     cfg_en;
reg     [ADDR_WIDTH-1:0]                cfg_addr;
reg     [DATA_WIDTH-1:0]                cfg_data;
reg     [ADDR_WIDTH-1:0]                reg_rdata;
wire    [ADDR_WIDTH-1:0]                bram_base_addr_mask, bram_reg_addr_mask;

// >>>>>>>>>> reg_out
wire    [REG_NUM-1:0][DATA_WIDTH-1:0]   reg_out;

// write_regs
always @(posedge clk or negedge rstn) begin
    if(rstn == 1'd0)
        cfg_en <= 'd0;
    else
        cfg_en <= (bram_cfg_en == 1'd1) && (&bram_cfg_we);
end

always @(posedge clk or negedge rstn) begin
    if(rstn == 1'd0)
        cfg_addr <= 'd0;
    else if(bram_cfg_en == 1'd1 && (&bram_cfg_we))
        cfg_addr <= bram_cfg_addr;
end

always @(posedge clk or negedge rstn) begin
    if(rstn == 1'd0)
        cfg_data <= 'd0;
    else if(bram_cfg_en == 1'd1 && (&bram_cfg_we))
        cfg_data <= bram_cfg_data;
end

// read_regs
assign bram_cfg_rdbk        = reg_rdata;
assign bram_base_addr_mask  = bram_cfg_addr & REG_BASE_ADDR;
assign bram_reg_addr_mask   = bram_cfg_addr & REG_ADDR_MASK;
always @(posedge clk or negedge rstn) begin
    if(rstn == 1'd0)
        reg_rdata <= 'd0;
    else if(bram_cfg_en == 1'd1 && bram_base_addr_mask == REG_BASE_ADDR) begin
        if(bram_reg_addr_mask[ADDR_WIDTH-1:2] < REG_NUM)        // 4byte_num < REG_NUM
            reg_rdata <= reg_out[bram_cfg_addr[ADDR_WIDTH-1:2]];
        else
            reg_rdata <= 'd0;
    end
end

// >>>>>>>>>> regs_out
assign reg_0    = reg_out[REG_0000_INDEX];
assign reg_1    = reg_out[REG_0004_INDEX];
assign reg_2    = reg_out[REG_0008_INDEX];
assign reg_3    = reg_out[REG_000C_INDEX];    

// >>>>>>>>>> regs
cfg_reg #(.RST_VALUE(RST_VAL_REG_0000), .BASE_ADDR(BASE_ADDR_REG_0000), .ADDR_WIDTH(ADDR_WIDTH), .DATA_WIDTH(DATA_WIDTH)) u_reg_0000(.clk(clk), .rstn(rstn), .cfg_en(cfg_en), .cfg_addr(cfg_addr), .cfg_data(cfg_data), .reg_data(reg_out[REG_0000_INDEX]));
cfg_reg #(.RST_VALUE(RST_VAL_REG_0004), .BASE_ADDR(BASE_ADDR_REG_0004), .ADDR_WIDTH(ADDR_WIDTH), .DATA_WIDTH(DATA_WIDTH)) u_reg_0004(.clk(clk), .rstn(rstn), .cfg_en(cfg_en), .cfg_addr(cfg_addr), .cfg_data(cfg_data), .reg_data(reg_out[REG_0004_INDEX]));
cfg_reg #(.RST_VALUE(RST_VAL_REG_0008), .BASE_ADDR(BASE_ADDR_REG_0008), .ADDR_WIDTH(ADDR_WIDTH), .DATA_WIDTH(DATA_WIDTH)) u_reg_0008(.clk(clk), .rstn(rstn), .cfg_en(cfg_en), .cfg_addr(cfg_addr), .cfg_data(cfg_data), .reg_data(reg_out[REG_0008_INDEX]));
cfg_reg #(.RST_VALUE(RST_VAL_REG_000C), .BASE_ADDR(BASE_ADDR_REG_000C), .ADDR_WIDTH(ADDR_WIDTH), .DATA_WIDTH(DATA_WIDTH)) u_reg_000C(.clk(clk), .rstn(rstn), .cfg_en(cfg_en), .cfg_addr(cfg_addr), .cfg_data(cfg_data), .reg_data(reg_out[REG_000C_INDEX]));

endmodule
