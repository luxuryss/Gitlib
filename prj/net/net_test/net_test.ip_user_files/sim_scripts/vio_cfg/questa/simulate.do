onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib vio_cfg_opt

do {wave.do}

view wave
view structure
view signals

do {vio_cfg.udo}

run -all

quit -force
