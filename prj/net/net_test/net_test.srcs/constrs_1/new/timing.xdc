# >>>>>>>>>> clk
create_clock -period 8.000 [get_ports clk_125m]
create_clock -period 6.400 [get_ports clk_156p25m_p]

# >>>>>>>>>> async
set_clock_groups -asynchronous -group [get_clocks clk_125m] -group [get_clocks clk_156p25m_p]
# set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets clk_125m_IBUF]