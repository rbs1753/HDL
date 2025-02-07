onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /full_adder_single_bit_struct_tb/uut/a
add wave -noupdate /full_adder_single_bit_struct_tb/uut/b
add wave -noupdate /full_adder_single_bit_struct_tb/uut/cin
add wave -noupdate /full_adder_single_bit_struct_tb/uut/sum
add wave -noupdate /full_adder_single_bit_struct_tb/uut/cout
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {14 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 112
configure wave -valuecolwidth 101
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
