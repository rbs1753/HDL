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
add wave -noupdate /memory_calc_tb/uut/addr
add wave -noupdate -radix unsigned /memory_calc_tb/uut/memory_grab
add wave -noupdate -radix unsigned /memory_calc_tb/uut/alu_out
add wave -noupdate -radix unsigned /memory_calc_tb/uut/input_sync
add wave -noupdate -radix unsigned /memory_calc_tb/uut/mux_out
add wave -noupdate -radix unsigned /memory_calc_tb/uut/result_padded
add wave -noupdate /memory_calc_tb/uut/we
add wave -noupdate /memory_calc_tb/uut/mr_sync
add wave -noupdate /memory_calc_tb/uut/ms_sync
add wave -noupdate /memory_calc_tb/uut/execute_sync
add wave -noupdate /memory_calc_tb/uut/op_sync
add wave -noupdate /memory_calc_tb/uut/hundreds
add wave -noupdate /memory_calc_tb/uut/current_state
add wave -noupdate /memory_calc_tb/uut/next_state
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {937 ns} 0}
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
WaveRestoreZoom {1041 ns} {1146 ns}
