vlib work
vlib riviera

vlib riviera/ten_gig_eth_mac_v15_1_6
vlib riviera/xil_defaultlib
vlib riviera/ten_gig_eth_pcs_pma_v6_0_14
vlib riviera/xlconstant_v1_1_5

vmap ten_gig_eth_mac_v15_1_6 riviera/ten_gig_eth_mac_v15_1_6
vmap xil_defaultlib riviera/xil_defaultlib
vmap ten_gig_eth_pcs_pma_v6_0_14 riviera/ten_gig_eth_pcs_pma_v6_0_14
vmap xlconstant_v1_1_5 riviera/xlconstant_v1_1_5

vlog -work ten_gig_eth_mac_v15_1_6  -v2k5 \
"../../../ipstatic/hdl/ten_gig_eth_mac_v15_1_rfs.v" \

vlog -work xil_defaultlib  -v2k5 \
"../../../ip/axi_10g_ethernet_0/bd_0/ip/ip_0/ten_gig_eth_mac_v15_1_1/hdl/bd_efdb_0_xmac_0_core.v" \
"../../../ip/axi_10g_ethernet_0/bd_0/ip/ip_0/synth/bd_efdb_0_xmac_0_sync_resetn.v" \
"../../../ip/axi_10g_ethernet_0/bd_0/ip/ip_0/synth/bd_efdb_0_xmac_0_block.v" \
"../../../ip/axi_10g_ethernet_0/bd_0/ip/ip_0/synth/bd_efdb_0_xmac_0.v" \

vlog -work ten_gig_eth_pcs_pma_v6_0_14  -v2k5 \
"../../../ipstatic/hdl/ten_gig_eth_pcs_pma_v6_0_rfs.v" \

vlog -work xil_defaultlib  -v2k5 \
"../../../ip/axi_10g_ethernet_0/bd_0/ip/ip_1/synth/bd_efdb_0_xpcs_0_gtwizard_10gbaser_gt.v" \
"../../../ip/axi_10g_ethernet_0/bd_0/ip/ip_1/synth/bd_efdb_0_xpcs_0_gtwizard_10gbaser_multi_gt.v" \
"../../../ip/axi_10g_ethernet_0/bd_0/ip/ip_1/synth/bd_efdb_0_xpcs_0_ff_synchronizer_rst.v" \
"../../../ip/axi_10g_ethernet_0/bd_0/ip/ip_1/synth/bd_efdb_0_xpcs_0_ff_synchronizer.v" \
"../../../ip/axi_10g_ethernet_0/bd_0/ip/ip_1/synth/bd_efdb_0_xpcs_0_local_clock_and_reset.v" \
"../../../ip/axi_10g_ethernet_0/bd_0/ip/ip_1/synth/bd_efdb_0_xpcs_0_sim_speedup_controller.v" \
"../../../ip/axi_10g_ethernet_0/bd_0/ip/ip_1/synth/bd_efdb_0_xpcs_0_cable_pull_logic.v" \
"../../../ip/axi_10g_ethernet_0/bd_0/ip/ip_1/synth/bd_efdb_0_xpcs_0_block.v" \
"../../../ip/axi_10g_ethernet_0/bd_0/ip/ip_1/synth/bd_efdb_0_xpcs_0.v" \

vlog -work xlconstant_v1_1_5  -v2k5 \
"../../../ipstatic/hdl/xlconstant_v1_1_vl_rfs.v" \

vlog -work xil_defaultlib  -v2k5 \
"../../../ip/axi_10g_ethernet_0/bd_0/ip/ip_2/sim/bd_efdb_0_prtad_driver_0.v" \
"../../../ip/axi_10g_ethernet_0/bd_0/ip/ip_3/sim/bd_efdb_0_dcm_locked_driver_0.v" \
"../../../ip/axi_10g_ethernet_0/bd_0/ip/ip_4/sim/bd_efdb_0_pma_pmd_type_driver_0.v" \
"../../../ip/axi_10g_ethernet_0/bd_0/sim/bd_efdb_0.v" \
"../../../ip/axi_10g_ethernet_0/sim/axi_10g_ethernet_0.v" \

vlog -work xil_defaultlib \
"glbl.v"

