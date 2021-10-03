# PART is xc7k325tffg900-2
########## GENERAL PIN CONSTRAINTS FOR THE KC705 BOARD REV C ##########

set_property PACKAGE_PIN AD11 [get_ports clk_in_n]
set_property IOSTANDARD LVDS [get_ports clk_in_p]
set_property IOSTANDARD LVDS [get_ports clk_in_n]

# DP CLK
set_property PACKAGE_PIN E7 [get_ports refclk_n]
set_property PACKAGE_PIN E8 [get_ports refclk_p]

set_property PACKAGE_PIN AB7 [get_ports reset]
set_property IOSTANDARD LVCMOS15 [get_ports reset]

#### Module LEDs_8Bit constraints

set_property PACKAGE_PIN F16 [get_ports core_ready]
set_property PACKAGE_PIN AB8 [get_ports frame_error]
set_property PACKAGE_PIN AC9 [get_ports gen_active_flash]
set_property PACKAGE_PIN AA8 [get_ports check_active_flash]
set_property PACKAGE_PIN E18 [get_ports qplllock_out]
set_property PACKAGE_PIN G19 [get_ports serialized_stats]
set_property IOSTANDARD LVCMOS15 [get_ports core_ready]
set_property IOSTANDARD LVCMOS15 [get_ports frame_error]
set_property IOSTANDARD LVCMOS15 [get_ports gen_active_flash]
set_property IOSTANDARD LVCMOS15 [get_ports check_active_flash]
set_property IOSTANDARD LVCMOS15 [get_ports qplllock_out]
set_property IOSTANDARD LVCMOS15 [get_ports serialized_stats]

#### Module FMC_J22 constraints

# DP1
set_property PACKAGE_PIN D6 [get_ports rxp]
set_property PACKAGE_PIN D5 [get_ports rxn]
set_property PACKAGE_PIN C4 [get_ports txp]
set_property PACKAGE_PIN C3 [get_ports txn]

#### Module Push_Buttons_4Bit constraints

set_property PACKAGE_PIN AA12 [get_ports reset_error]
set_property PACKAGE_PIN G12  [get_ports insert_error]
set_property PACKAGE_PIN AB12 [get_ports sim_speedup_control]
set_property IOSTANDARD LVCMOS15 [get_ports reset_error]
set_property IOSTANDARD LVCMOS15 [get_ports insert_error]
set_property IOSTANDARD LVCMOS15 [get_ports sim_speedup_control]

#### Module DIP_Switches_4Bit constraints

set_property PACKAGE_PIN Y28 [get_ports pcs_loopback]
set_property PACKAGE_PIN AA28 [get_ports enable_custom_preamble]
set_property PACKAGE_PIN W29 [get_ports enable_pat_gen]
set_property PACKAGE_PIN Y29 [get_ports enable_pat_check]
set_property IOSTANDARD LVCMOS25 [get_ports pcs_loopback]
set_property IOSTANDARD LVCMOS25 [get_ports enable_custom_preamble]
set_property IOSTANDARD LVCMOS25 [get_ports enable_pat_gen]
set_property IOSTANDARD LVCMOS25 [get_ports enable_pat_check]

#######################################################
# Clock/period constraints                            #
#######################################################
# Main transmit clock/period constraints

create_clock -period 5.000 [get_ports clk_in_p]
set_input_jitter clk_in_p 0.050
create_clock -period 6.400 [get_ports refclk_p]

#######################################################
# Synchronizer False paths
#######################################################
set_false_path -to [get_cells -hierarchical -filter {NAME =~ pattern_generator*sync1_r_reg[0]}]
set_false_path -to [get_cells -hierarchical -filter {NAME =~ reset_error_sync_reg*sync1_r_reg[0]}]
set_false_path -to [get_cells -hierarchical -filter {NAME =~ gen_enable_sync/sync1_r_reg[0]}]
set_false_path -to [get_pins -of_objects [get_cells -hierarchical -filter {NAME =~ *shared_clock_reset_block*sync1_r_reg[*]}] -filter {NAME =~ *PRE}]

#######################################################
# FIFO level constraints
#######################################################

set_false_path -from [get_cells fifo_block_i/ethernet_mac_fifo_i/*/wr_store_frame_tog_reg] -to [get_cells fifo_block_i/ethernet_mac_fifo_i/*/*/sync1_r_reg*]
set_max_delay 3.2000 -datapath_only  -from [get_cells {fifo_block_i/ethernet_mac_fifo_i/*/rd_addr_gray_reg_reg[*]}] -to [get_cells fifo_block_i/ethernet_mac_fifo_i/*/*/sync1_r_reg*]
set_false_path -to [get_pins -filter {NAME =~ */PRE} -of_objects [get_cells {fifo_block_i/ethernet_mac_fifo_i/*/*/reset_async*_reg}]]

#######################################################
# I/O constraints                                     #
#######################################################

# These inputs can be connected to dip switches or push buttons on an
# appropriate board.

set_false_path -from [get_ports reset]
set_false_path -from [get_ports reset_error]
set_false_path -from [get_ports insert_error]
set_false_path -from [get_ports pcs_loopback]
set_false_path -from [get_ports enable_pat_gen]
set_false_path -from [get_ports enable_pat_check]
set_false_path -from [get_ports enable_custom_preamble]
set_case_analysis 0  [get_ports sim_speedup_control]

# These outputs can be connected to LED's or headers on an
# appropriate board.

set_false_path -to [get_ports core_ready]
set_false_path -to [get_ports coreclk_out]
set_false_path -to [get_ports qplllock_out]
set_false_path -to [get_ports frame_error]
set_false_path -to [get_ports gen_active_flash]
set_false_path -to [get_ports check_active_flash]
set_false_path -to [get_ports serialized_stats]

