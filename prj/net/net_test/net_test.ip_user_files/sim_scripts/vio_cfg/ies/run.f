-makelib ies_lib/xil_defaultlib -sv \
  "D:/Software/Vivado/Vivado/2018.3/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
-endlib
-makelib ies_lib/xpm \
  "D:/Software/Vivado/Vivado/2018.3/data/ip/xpm/xpm_VCOMP.vhd" \
-endlib
-makelib ies_lib/xil_defaultlib \
  "../../../ip/vio_cfg/sim/vio_cfg.v" \
-endlib
-makelib ies_lib/xil_defaultlib \
  glbl.v
-endlib

