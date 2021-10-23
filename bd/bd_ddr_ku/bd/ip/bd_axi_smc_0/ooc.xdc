# aclk {FREQ_HZ 200000000 CLK_DOMAIN bd_sys_clk PHASE 0.000} aclk1 {FREQ_HZ 300000000 CLK_DOMAIN bd_ddr4_0_0_c0_ddr4_ui_clk PHASE 0.00}
# Clock Domain: bd_sys_clk
create_clock -name aclk -period 5.000 [get_ports aclk]
# Clock Domain: bd_ddr4_0_0_c0_ddr4_ui_clk
create_clock -name aclk1 -period 3.333 [get_ports aclk1]
# Generated clocks
