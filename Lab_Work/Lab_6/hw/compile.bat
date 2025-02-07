quartus_sh -t compile.tcl
pause
quartus_pgm --mode=JTAG -o P;output_files\Lab_6.sof@2
pause