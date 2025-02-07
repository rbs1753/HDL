# Dr. Kaputa
# Quartus II compile script for DE1-SoC board

# 1] name your project here
set project_name "add_sub"

file delete -force project
file delete -force output_files
file mkdir project
cd project
load_package flow
project_new $project_name
set_global_assignment -name FAMILY Cyclone
set_global_assignment -name DEVICE 5CSEMA5F31C6 
set_global_assignment -name TOP_LEVEL_ENTITY add_sub
set_global_assignment -name PROJECT_OUTPUT_DIRECTORY ../output_files

# 2] include your relative path files here
set_global_assignment -name VHDL_FILE ../../src/rising_edge_synchronizer.vhd
set_global_assignment -name VHDL_FILE ../../src/seven_seg.vhd
set_global_assignment -name VHDL_FILE ../../src/generic_add_sub.vhd
set_global_assignment -name VHDL_FILE ../../src/synchronizer.vhd
set_global_assignment -name VHDL_FILE ../../src/add_sub.vhd

set_location_assignment PIN_AB12 -to reset
set_location_assignment PIN_AF14 -to clk
set_location_assignment PIN_AC9  -to a[0]
set_location_assignment PIN_AD10 -to a[1]
set_location_assignment PIN_AE12 -to a[2]
set_location_assignment PIN_AD11 -to b[0]
set_location_assignment PIN_AD12 -to b[1]
set_location_assignment PIN_AE11 -to b[2]

set_location_assignment PIN_AA24 -to hex_4[0]
set_location_assignment PIN_Y23  -to hex_4[1]
set_location_assignment PIN_Y24  -to hex_4[2]
set_location_assignment PIN_W22  -to hex_4[3]
set_location_assignment PIN_W24  -to hex_4[4]
set_location_assignment PIN_V23  -to hex_4[5]
set_location_assignment PIN_W25  -to hex_4[6]

set_location_assignment PIN_AB23 -to hex_2[0]
set_location_assignment PIN_AE29 -to hex_2[1]
set_location_assignment PIN_AD29 -to hex_2[2]
set_location_assignment PIN_AC28 -to hex_2[3]
set_location_assignment PIN_AD30 -to hex_2[4]
set_location_assignment PIN_AC29 -to hex_2[5]
set_location_assignment PIN_AC30 -to hex_2[6]

set_location_assignment PIN_AE26 -to hex_0[0]
set_location_assignment PIN_AE27 -to hex_0[1]
set_location_assignment PIN_AE28 -to hex_0[2]
set_location_assignment PIN_AG27 -to hex_0[3]
set_location_assignment PIN_AF28 -to hex_0[4]
set_location_assignment PIN_AG28 -to hex_0[5]
set_location_assignment PIN_AH28 -to hex_0[6]

set_location_assignment PIN_AA15 -to add
set_location_assignment PIN_AA14 -to sub

execute_flow -compile
project_close