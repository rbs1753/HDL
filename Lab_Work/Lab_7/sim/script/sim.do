vlib work
vmap altera_mf ../../src/altera_mf
vcom -93 -work work ../../src/rom/blink_rom.vhd
vcom -93 -work work ../../src/rising_edge_synchronizer.vhd
vcom -93 -work work ../../src/synchronizer.vhd
vcom -93 -work work ../../src/seven_seg.vhd
vcom -93 -work work ../../src/double_dabble.vhd
vcom -93 -work work ../../src/components.vhd
vcom -93 -work work ../../src/alu.vhd
vcom -93 -work work ../../src/memory.vhd
vcom -93 -work work ../../src/lab6.vhd
vcom -93 -work work ../../src/top.vhd
vcom -93 -work work ../src/rom_memory_calc_tb.vhd
vsim -voptargs=+acc rom_memory_calc_tb
do wave.do
run 600 ns
