######################################################################
#
# File name : axi_10g_ethernet_0_demo_tb_simulate.do
# Created on: Wed Sep 15 18:37:39 +0800 2021
#
# Auto generated by Vivado for 'behavioral' simulation
#
######################################################################
vsim -voptargs="+acc" -L ten_gig_eth_mac_v15_1_6 -L xil_defaultlib -L ten_gig_eth_pcs_pma_v6_0_14 -L xlconstant_v1_1_5 -L unisims_ver -L unimacro_ver -L secureip -L xpm -lib xil_defaultlib xil_defaultlib.axi_10g_ethernet_0_demo_tb xil_defaultlib.glbl

set NumericStdNoWarnings 1
set StdArithNoWarnings 1

do {axi_10g_ethernet_0_demo_tb_wave.do}

view wave
view structure
view signals

log -r /*

do {axi_10g_ethernet_0_demo_tb.udo}

run 1000ns
