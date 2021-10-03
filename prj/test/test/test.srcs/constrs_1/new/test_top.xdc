# >>>>>>>>>> clk
set_property PACKAGE_PIN AD12 [get_ports clk_in]
set_property IOSTANDARD LVCMOS18 [get_ports clk_in]

# >>>>>>>>>> timing
create_clock -period 10.000 -name clk_in [get_ports clk_in]