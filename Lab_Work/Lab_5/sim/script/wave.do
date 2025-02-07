onerror {resume}
radix define States {
    "7'b1000000" "0" -color "yellow",
    "7'b1111001" "1" -color "yellow",
    "7'b0100100" "2" -color "yellow",
    "7'b0110000" "3" -color "yellow",
    "7'b0011001" "4" -color "yellow",
    "7'b0010010" "5" -color "yellow",
    "7'b0000010" "6" -color "yellow",
    "7'b1111000" "7" -color "yellow",
    "7'b0000000" "8" -color "yellow",
    "7'b0011000" "9" -color "yellow",
    "7'b1111111" "Blank" -color "yellow",
    -default default
}
quietly WaveActivateNextPane {} 0
add wave -noupdate /add_sub_state_machine_tb/uut/clk
add wave -noupdate /add_sub_state_machine_tb/uut/reset
add wave -noupdate -radix unsigned /add_sub_state_machine_tb/uut/switch
add wave -noupdate /add_sub_state_machine_tb/uut/button
add wave -noupdate -radix States /add_sub_state_machine_tb/uut/hex2
add wave -noupdate -radix States /add_sub_state_machine_tb/uut/hex1
add wave -noupdate -radix States /add_sub_state_machine_tb/uut/hex0
add wave -noupdate /add_sub_state_machine_tb/uut/led
add wave -noupdate /add_sub_state_machine_tb/uut/current_state
add wave -noupdate /add_sub_state_machine_tb/uut/next_state
add wave -noupdate /add_sub_state_machine_tb/uut/a_sync
add wave -noupdate /add_sub_state_machine_tb/uut/b_sync
add wave -noupdate /add_sub_state_machine_tb/uut/switch_sync
add wave -noupdate /add_sub_state_machine_tb/uut/button_sync
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {50 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 177
configure wave -valuecolwidth 40
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ns} {105 ns}
