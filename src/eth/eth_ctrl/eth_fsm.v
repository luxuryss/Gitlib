`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/09/08 23:31:14
// Design Name: 
// Module Name: eth_fsm
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
module eth_fsm #(
    parameter                               REG_ADDR_WIDTH      = 32,
    parameter                               REG_DATA_WIDTH      = 32
)(
    // >>>>>>>>>> sys
    input                                   clk                     ,
    input                                   rstn                    ,
    input                                   eth_en                  ,
    output                                  eth_rst_done            ,
    output                                  eth_init_done           ,
    // >>>>>>>>>> usr
    input                                   usr_cfg_type            ,
    input                                   usr_wr_en               ,
    input       [REG_ADDR_WIDTH-1 : 0]      usr_wr_addr             ,
    input       [REG_DATA_WIDTH-1 : 0]      usr_wr_data             ,
    input                                   usr_rd_en               ,
    input       [REG_ADDR_WIDTH-1 : 0]      usr_rd_addr             ,
    output  reg                             usr_rd_vld              ,
    output  reg [REG_DATA_WIDTH-1 : 0]      usr_rd_data             ,
    // >>>>>>>>>> cfg
    input                                   cfg_busy                ,
    input       [1 : 0]                     cfg_resp                ,
    output  reg                             cfg_wr_en               ,
    output  reg [REG_ADDR_WIDTH-1 : 0]      cfg_wr_addr             ,
    output  reg [REG_DATA_WIDTH-1 : 0]      cfg_wr_data             ,
    output  reg                             cfg_rd_en               ,
    output  reg [REG_ADDR_WIDTH-1 : 0]      cfg_rd_addr             ,
    input                                   cfg_rd_vld              ,
    input       [REG_DATA_WIDTH-1 : 0]      cfg_rd_data             ,
    // >>>>>>>>>> status
    output  reg                             sim_speedup_control
    );

// >>>>>>>>>> param
// cfg_num
localparam                          EN_RST_CFG_NUM      = 3;
localparam                          WR_PHY_CFG_NUM      = 6;
localparam                          RD_PHY_CFG_NUM      = 6;
localparam                          MAX_CFG_NUM         = (WR_PHY_CFG_NUM > RD_PHY_CFG_NUM) ? WR_PHY_CFG_NUM : RD_PHY_CFG_NUM;
// wr_cnt
localparam                          W_WR_PHY_ADDR       = 0;
localparam                          W_WR_OP_ADDR        = 1;
localparam                          W_WAIT_ADDR_RDY     = 2;
localparam                          W_WR_PHY_DATA       = 3;
localparam                          W_WR_OP_WRITE       = 4;
localparam                          W_WAIT_WRITE_RDY    = 5;
// rd_cnt
localparam                          R_WR_PHY_ADDR       = 0;
localparam                          R_WR_OP_ADDR        = 1;
localparam                          R_WAIT_ADDR_RDY     = 2;
localparam                          R_RWR_PHY_ADDR      = 3;
localparam                          R_WR_OP_READ        = 4;
localparam                          R_WAIT_READ_RDY     = 5;
// ip_reg_addr
localparam                          MDIO_CFG_WORD_0     = 'h500;
localparam                          MDIO_CFG_WORD_1     = 'h504;
localparam                          MDIO_TX_DATA        = 'h508;
localparam                          MDIO_RX_DATA        = 'h50C;
localparam                          RECV_CFG_WORD_1     = 'h404;
localparam                          TRANS_CFG_WORD      = 'h408;
// mdio
localparam                          MDIO_OP_WR          = 2'd1;
localparam                          MDIO_OP_RD          = 2'd3;
localparam                          MDIO_OP_ADDR        = 2'd0;
// phy_reg_addr
localparam                          PCS_CTRL_1          = 'h0;
localparam                          BASER_10G_STATUS_1  = 'h20;
// >>>>>>>>>> var
// fsm
localparam                          IDLE                = 0;
localparam                          EN_RST              = 1;
localparam                          PCS_INIT            = 2;
localparam                          WAIT_INIT           = 3;
localparam                          WR_PHY_REG          = 4;
localparam                          RD_PHY_REG          = 5;
localparam                          WR_IP_REG           = 6;
localparam                          RD_IP_REG           = 7;
localparam                          FREE_RUN            = 8;
// cfg
reg                                 cfg_en;
wire                                cfg_busy_rising, cfg_busy_falling, cfg_en_rising, cfg_en_falling;
reg     [3 : 0]                     state, next_state;
reg     [$clog2(MAX_CFG_NUM)-1 : 0] cfg_cnt;
reg     [15 : 0]                    rst_cnt;
// mdio_cfg
wire                                mdio_en, mdio_rdy_rising, mdio_rdy_falling, mdio_rd_done, mdio_wr_done;
wire    [5 : 0]                     clk_div;
wire                                recv_rst, recv_en, trans_rst, trans_en;
wire    [4 : 0]                     mdio_port_addr, mdio_dev_addr;
reg     [1 : 0]                     mdio_op;
reg                                 mdio_rdy, pcs_block_lock;

// >>>>>>>>>> rst
assign eth_rst_done = (&rst_cnt[11 : 0]);

always @(posedge clk or negedge rstn) begin
    if(rstn == 1'd0)
        rst_cnt <= 16'd0;
    else if(&rst_cnt[11 : 0])
        rst_cnt <= rst_cnt;
    else
        rst_cnt <= rst_cnt + 1'd1;
end

// >>>>>>>>>> fsm
always @(posedge clk or negedge rstn) begin
    if(rstn == 1'd0)
        state <= IDLE;
    else
        state <= next_state;
end

always @(*) begin
    case(state)
        IDLE: begin
            if(eth_en == 1'd1)
                next_state = EN_RST;
            else
                next_state = IDLE;  
        end
        EN_RST: begin
            if(cfg_busy_falling == 1'd1 && cfg_cnt == (EN_RST_CFG_NUM-1))
                next_state = PCS_INIT;
            else
                next_state = EN_RST;
        end
        PCS_INIT: begin
            if(cfg_busy_falling == 1'd1 && cfg_cnt == (WR_PHY_CFG_NUM-1) && mdio_rdy == 1'd1)
                next_state = WAIT_INIT;
            else
                next_state = PCS_INIT;            
        end
        WAIT_INIT: begin
            if(cfg_busy_falling == 1'd1 && pcs_block_lock == 1'd1)
                next_state = FREE_RUN;
            else
                next_state = WAIT_INIT;
        end
        FREE_RUN: begin
            if(usr_wr_en == 1'd1)
                next_state = (usr_cfg_type == 1'd0) ? WR_PHY_REG : WR_IP_REG;
            else if(usr_rd_en == 1'd1)
                next_state = (usr_cfg_type == 1'd0) ? RD_PHY_REG : RD_IP_REG;
        end
        WR_PHY_REG: begin
            if(cfg_busy_falling == 1'd1 && cfg_cnt == (WR_PHY_CFG_NUM-1) && mdio_rdy == 1'd1)
                next_state = FREE_RUN;
            else
                next_state = WR_PHY_REG;
        end
        RD_PHY_REG: begin
            if(cfg_busy_falling == 1'd1 && cfg_cnt == (RD_PHY_CFG_NUM-1) && mdio_rdy == 1'd1)
                next_state = FREE_RUN;
            else
                next_state = RD_PHY_REG;
        end
        WR_IP_REG: begin
            if(cfg_busy_falling == 1'd1)
                next_state = FREE_RUN;
            else
                next_state = WR_IP_REG;
        end
        RD_IP_REG: begin
            if(cfg_busy_falling == 1'd1)
                next_state = FREE_RUN;
            else
                next_state = RD_IP_REG;
        end
        default: begin
            next_state = WAIT_INIT;
        end
    endcase
end

// mdio_cfg
assign mdio_en          = 1'd1;
assign clk_div          = 5'd5;
assign recv_rst         = 1'd1;
assign recv_en          = 1'd1;
assign trans_rst        = 1'd1;
assign trans_en         = 1'd1;
assign mdio_port_addr   = 5'd0;
assign mdio_dev_addr    = 5'd3;
assign mdio_rd_done     = (state == RD_PHY_REG) && (mdio_rdy_rising == 1'd1) && (cfg_cnt == R_WAIT_READ_RDY);

// mdio
always @(posedge clk or negedge rstn) begin
    if(rstn == 1'd0)
        mdio_op <= 2'd0;
    else if(state == RD_PHY_REG || state == WAIT_INIT) begin
        if(cfg_cnt == R_WR_OP_ADDR)
            mdio_op <= MDIO_OP_ADDR;
        else if(cfg_cnt == R_WR_OP_READ)
            mdio_op <= MDIO_OP_RD;
    end
    else if(state == WR_PHY_REG || state == PCS_INIT) begin
        if(cfg_cnt == W_WR_OP_ADDR)
            mdio_op <= MDIO_OP_ADDR;
        else if(cfg_cnt == W_WR_OP_WRITE)
            mdio_op <= MDIO_OP_WR;        
    end
end

always @(posedge clk or negedge rstn) begin
    if(rstn == 1'd0)
        mdio_rdy <= 1'd0;
    else if(cfg_en_rising == 1'd1)
        mdio_rdy <= 1'd0;
    else if(cfg_rd_vld == 1'd1) begin
        if(state == RD_PHY_REG || state == WAIT_INIT) begin
            if(cfg_cnt == R_WAIT_ADDR_RDY)
                mdio_rdy <= cfg_rd_data[7];
            else if(cfg_cnt == R_WAIT_READ_RDY)
                mdio_rdy <= cfg_rd_data[16];
        end
        else if(state == WR_PHY_REG || state == PCS_INIT) begin
            if(cfg_cnt == W_WAIT_ADDR_RDY || cfg_cnt == W_WAIT_WRITE_RDY)
                mdio_rdy <= cfg_rd_data[7];
        end
    end
end

// >>>>>>>>>> cfg
always @(posedge clk or negedge rstn) begin
    if(rstn == 1'd0)
        cfg_cnt <= 'd0;
    else if(state == EN_RST) begin
        if(cfg_busy_falling == 1'd1) begin
            if(cfg_cnt == (EN_RST_CFG_NUM-1))
                cfg_cnt <= 'd0;
            else
                cfg_cnt <= cfg_cnt + 1'd1;
        end
    end
    else if(state == RD_PHY_REG || state == WAIT_INIT) begin
        if(cfg_busy_falling == 1'd1) begin
            if(cfg_cnt == R_WR_PHY_ADDR || cfg_cnt == R_WR_OP_ADDR || cfg_cnt == R_RWR_PHY_ADDR || cfg_cnt == R_WR_OP_READ)
                cfg_cnt <= cfg_cnt + 1'd1;
            else if(cfg_cnt == R_WAIT_ADDR_RDY) begin
                if(mdio_rdy == 1'd1)
                    cfg_cnt <= cfg_cnt + 1'd1;
            end
            else if(cfg_cnt == R_WAIT_READ_RDY) begin
                if(mdio_rdy == 1'd1) begin
                    if(pcs_block_lock == 1'd0) begin
                        if(cfg_rd_data[0] == 1'd1)
                            cfg_cnt <= R_WR_PHY_ADDR;
                        else
                            cfg_cnt <= R_WR_OP_READ;
                    end
                    else
                        cfg_cnt <= R_WR_PHY_ADDR;
                end
            end
        end
    end
    else if(state == WR_PHY_REG || state == PCS_INIT) begin
        if(cfg_busy_falling == 1'd1) begin
            if(cfg_cnt == W_WR_PHY_ADDR || cfg_cnt == W_WR_OP_ADDR || cfg_cnt == W_WR_PHY_DATA || cfg_cnt == W_WR_OP_WRITE)
                cfg_cnt <= cfg_cnt + 1'd1;
            else if(cfg_cnt == W_WAIT_ADDR_RDY) begin
                if(mdio_rdy == 1'd1)
                    cfg_cnt <= cfg_cnt + 1'd1;
            end
            else if(cfg_cnt == W_WAIT_WRITE_RDY) begin
                if(mdio_rdy == 1'd1)
                    cfg_cnt <= W_WR_PHY_ADDR;
            end
        end
    end
    else
        cfg_cnt <= 'd0;
end

always @(posedge clk or negedge rstn) begin
    if(rstn == 1'd0)
        cfg_en <= 1'd0;
    else if(state != IDLE && state != FREE_RUN) begin
        if(cfg_busy_falling == 1'd1)
            cfg_en <= 1'd0;
        else
            cfg_en <= 1'd1;
    end
end

always @(posedge clk or negedge rstn) begin
    if(rstn == 1'd0) begin
        cfg_wr_en   <= 1'd0;
        cfg_wr_addr <= 'd0;
        cfg_wr_data <= 'd0;
    end
    else if(cfg_en_rising == 1'd1) begin
        if(state == EN_RST) begin
            if(cfg_cnt == 'd0) begin
                cfg_wr_en   <= 1'd1;
                cfg_wr_addr <= MDIO_CFG_WORD_0;
                cfg_wr_data <= {25'd0, mdio_en, clk_div};
            end
            else if(cfg_cnt == 'd1) begin
                cfg_wr_en   <= 1'd1;
                cfg_wr_addr <= RECV_CFG_WORD_1;
                cfg_wr_data <= {recv_rst, 2'd0, recv_en, 28'd0};
            end
            else if(cfg_cnt == 'd2) begin
                cfg_wr_en   <= 1'd1;
                cfg_wr_addr <= TRANS_CFG_WORD;
                cfg_wr_data <= {trans_rst, 2'd0, trans_en, 28'd0};
            end
        end
        else if(state == RD_PHY_REG || state == WAIT_INIT) begin
            if(cfg_cnt == R_WR_PHY_ADDR || cfg_cnt == R_RWR_PHY_ADDR) begin
                cfg_wr_en   <= 1'd1;
                cfg_wr_addr <= MDIO_TX_DATA;
                cfg_wr_data <= (pcs_block_lock == 1'd1) ? usr_rd_addr : BASER_10G_STATUS_1;
            end
            else if(cfg_cnt == R_WR_OP_ADDR || cfg_cnt == R_WR_OP_READ) begin
                cfg_wr_en   <= 1'd1;
                cfg_wr_addr <= MDIO_CFG_WORD_1;
                cfg_wr_data <= {3'd0, mdio_port_addr, 3'd0, mdio_dev_addr, mdio_op, 2'd0, 1'd1, 3'd0, 1'd0, 7'd0};
            end
        end
        else if(state == WR_PHY_REG || state == PCS_INIT) begin
            if(cfg_cnt == W_WR_PHY_ADDR) begin
                cfg_wr_en   <= 1'd1;
                cfg_wr_addr <= MDIO_TX_DATA;
                cfg_wr_data <= (pcs_block_lock == 1'd1) ? usr_wr_addr : PCS_CTRL_1;
            end
            else if(cfg_cnt == W_WR_OP_ADDR || cfg_cnt == W_WR_OP_WRITE) begin
                cfg_wr_en   <= 1'd1;
                cfg_wr_addr <= MDIO_CFG_WORD_1;
                cfg_wr_data <= {3'd0, mdio_port_addr, 3'd0, mdio_dev_addr, mdio_op, 2'd0, 1'd1, 3'd0, 1'd0, 7'd0};
            end
            else if(cfg_cnt == W_WR_PHY_DATA) begin
                cfg_wr_en   <= 1'd1;
                cfg_wr_addr <= MDIO_TX_DATA;
                cfg_wr_data <= (pcs_block_lock == 1'd1) ? usr_wr_data : 'h2000;                
            end
        end
        else if(state == WR_IP_REG) begin
            cfg_wr_en   <= 1'd1;
            cfg_wr_addr <= usr_wr_addr;
            cfg_wr_data <= usr_wr_data;             
        end
    end
    else begin
        cfg_wr_en   <= 1'd0;
        cfg_wr_addr <= cfg_wr_addr;
        cfg_wr_data <= cfg_wr_data;
    end
end

always @(posedge clk or negedge rstn) begin
    if(rstn == 1'd0) begin
        cfg_rd_en   <= 1'd0;
        cfg_rd_addr <= 'd0;
    end
    else if(cfg_en_rising == 1'd1) begin
        if(state == RD_PHY_REG || state == WAIT_INIT) begin
            if(cfg_cnt == R_WAIT_ADDR_RDY) begin
                cfg_rd_en   <= 1'd1;
                cfg_rd_addr <= MDIO_CFG_WORD_1;
            end
            else if(cfg_cnt == R_WAIT_READ_RDY) begin
                cfg_rd_en   <= 1'd1;
                cfg_rd_addr <= MDIO_RX_DATA;
            end
        end
        else if(state == WR_PHY_REG || state == PCS_INIT) begin
            if(cfg_cnt == W_WAIT_ADDR_RDY || cfg_cnt == W_WAIT_WRITE_RDY) begin
                cfg_rd_en   <= 1'd1;
                cfg_rd_addr <= MDIO_CFG_WORD_1;
            end
        end
        else if(state == RD_IP_REG) begin
            cfg_rd_en   <= 1'd1;
            cfg_rd_addr <= usr_rd_addr;            
        end
    end
    else begin
        cfg_rd_en   <= 1'd0;
        cfg_rd_addr <= cfg_rd_addr;
    end
end

always @(posedge clk or negedge rstn) begin
    if(rstn == 1'd0) begin
        usr_rd_vld  <= 1'd0;
        usr_rd_data <= 'd0;
    end
    else if(cfg_rd_vld == 1'd1) begin
        if(state == RD_PHY_REG) begin
            if(cfg_cnt == R_WAIT_READ_RDY && cfg_rd_data[16] == 1'd1) begin
                usr_rd_vld  <= 1'd1;
                usr_rd_data <= cfg_rd_data[15 : 0];
            end
        end
        else if(state == RD_IP_REG) begin
            usr_rd_vld  <= 1'd1;
            usr_rd_data <= cfg_rd_data;
        end        
    end
    else begin
        usr_rd_vld  <= 1'd0;
        usr_rd_data <= usr_rd_data;
    end
end

// >>>>>>>>>> pulse
sig_pulse #(
    .DEPTH              (1                  )
)
u_cfg_busy_pulse (
    .clk                (clk                ),
    .rstn               (rstn               ),
    .sig                (cfg_busy           ),
    .sig_rising         (cfg_busy_rising    ),
    .sig_falling        (cfg_busy_falling   )
    );

sig_pulse #(
    .DEPTH              (1                  )
)
u_cfg_en_pulse (
    .clk                (clk                ),
    .rstn               (rstn               ),
    .sig                (cfg_en             ),
    .sig_rising         (cfg_en_rising      ),
    .sig_falling        (cfg_en_falling     )
    );

sig_pulse #(
    .DEPTH              (1                  )
)
u_mdio_rdy_pulse (
    .clk                (clk                ),
    .rstn               (rstn               ),
    .sig                (mdio_rdy           ),
    .sig_rising         (mdio_rdy_rising    ),
    .sig_falling        (mdio_rdy_falling   )
    );

// >>>>>>>>>> status
always @(posedge clk or negedge rstn) begin
    if(rstn == 1'd0)
        sim_speedup_control <= 1'd0;
    else
        sim_speedup_control <= 1'd1;
end

assign eth_init_done    = pcs_block_lock;

always @(posedge clk or negedge rstn) begin
    if(rstn == 1'd0)
        pcs_block_lock <= 1'd0;
    else if(state == WAIT_INIT && cfg_rd_vld == 1'd1 && cfg_rd_data[0] == 1'd1 && cfg_cnt == R_WAIT_READ_RDY)
        pcs_block_lock <= 1'd1;
end

endmodule
