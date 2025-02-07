# Dr. Kaputa
# Quartus II compile script for DE1-SoC board

# 1] name your project here
set project_name "add_sub_state_machine"

file delete -force project
file delete -force output_files
file mkdir project
cd project
load_package flow
project_new $project_name
set_global_assignment -name FAMILY Cyclone
set_global_assignment -name DEVICE 5CSEMA5F31C6 
set_global_assignment -name TOP_LEVEL_ENTITY add_sub_state_machine
set_global_assignment -name PROJECT_OUTPUT_DIRECTORY ../output_files

# 2] include your relative path files here
set_global_assignment -name VHDL_FILE ../../src/rising_edge_synchronizer.vhd
set_global_assignment -name VHDL_FILE ../../src/seven_seg.vhd
set_global_assignment -name VHDL_FILE ../../src/generic_add_sub.vhd
set_global_assignment -name VHDL_FILE ../../src/synchronizer.vhd
set_global_assignment -name VHDL_FILE ../../src/double_dabble.vhd
set_global_assignment -name VHDL_FILE ../../src/add_sub_state_machine.vhd

set_location_assignment PIN_AB12 -to reset
set_location_assignment PIN_AF14 -to clk
#set_location_assignment PIN_D25 -to clk

set_location_assignment PIN_V16  -to led[0]
set_location_assignment PIN_W16  -to led[1]
set_location_assignment PIN_V17  -to led[2]
set_location_assignment PIN_V18  -to led[3]

set_location_assignment PIN_AF9  -to switch[0]
set_location_assignment PIN_AF10 -to switch[1]
set_location_assignment PIN_AD11 -to switch[2]
set_location_assignment PIN_AD12 -to switch[3]
set_location_assignment PIN_AE11 -to switch[4]
set_location_assignment PIN_AC9  -to switch[5]
set_location_assignment PIN_AD10 -to switch[6]
set_location_assignment PIN_AE12 -to switch[7]

set_location_assignment PIN_AE26 -to hex0[0]
set_location_assignment PIN_AE27 -to hex0[1]
set_location_assignment PIN_AE28 -to hex0[2]
set_location_assignment PIN_AG27 -to hex0[3]
set_location_assignment PIN_AF28 -to hex0[4]
set_location_assignment PIN_AG28 -to hex0[5]
set_location_assignment PIN_AH28 -to hex0[6]

set_location_assignment PIN_AJ29 -to hex1[0]
set_location_assignment PIN_AH29 -to hex1[1]
set_location_assignment PIN_AH30 -to hex1[2]
set_location_assignment PIN_AG30 -to hex1[3]
set_location_assignment PIN_AF29 -to hex1[4]
set_location_assignment PIN_AF30 -to hex1[5]
set_location_assignment PIN_AD27 -to hex1[6]

set_location_assignment PIN_AB23 -to hex2[0]
set_location_assignment PIN_AE29 -to hex2[1]
set_location_assignment PIN_AD29 -to hex2[2]
set_location_assignment PIN_AC28 -to hex2[3]
set_location_assignment PIN_AD30 -to hex2[4]
set_location_assignment PIN_AC29 -to hex2[5]
set_location_assignment PIN_AC30 -to hex2[6]

# set_location_assignment PIN_AD26 -to hex3[0]
# set_location_assignment PIN_AC27 -to hex3[1]
# set_location_assignment PIN_AD25 -to hex3[2]
# set_location_assignment PIN_AC25 -to hex3[3]
# set_location_assignment PIN_AB28 -to hex3[4]
# set_location_assignment PIN_AB25 -to hex3[5]
# set_location_assignment PIN_AB22 -to hex3[6]

# set_location_assignment PIN_AA24 -to hex4[0]
# set_location_assignment PIN_Y23  -to hex4[1]
# set_location_assignment PIN_Y24  -to hex4[2]
# set_location_assignment PIN_W22  -to hex4[3]
# set_location_assignment PIN_W24  -to hex4[4]
# set_location_assignment PIN_V23  -to hex4[5]
# set_location_assignment PIN_W25  -to hex4[6]

# set_location_assignment PIN_V25  -to hex5[0]
# set_location_assignment PIN_AA28 -to hex5[1]
# set_location_assignment PIN_Y27  -to hex5[2]
# set_location_assignment PIN_AB27 -to hex5[3]
# set_location_assignment PIN_AB26 -to hex5[4]
# set_location_assignment PIN_AA26 -to hex5[5]
# set_location_assignment PIN_AA25 -to hex5[6]

set_location_assignment PIN_AA14 -to button

execute_flow -compile
project_close