# >>>>>>>>>> clk
set_property PACKAGE_PIN AD12 [get_ports clk_125m]
set_property PACKAGE_PIN E8 [get_ports clk_156p25m_p]
set_property PACKAGE_PIN E7 [get_ports clk_156p25m_n]

set_property IOSTANDARD LVCMOS18 [get_ports clk_125m]

# >>>>>>>>>> tx/rx
set_property PACKAGE_PIN D6 [get_ports rxp]
set_property PACKAGE_PIN D5 [get_ports rxn]
set_property PACKAGE_PIN C4 [get_ports txp]
set_property PACKAGE_PIN C3 [get_ports txn]