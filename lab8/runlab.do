# Create work library
vlib work

# Compile Verilog
#     All Verilog files that are part of this design should have
#     their own "vlog" line below.

vlog "./DE1_SoC.sv"
vlog "./two_ff.sv"
vlog "./LEDDriver.sv"
vlog "./LED_test.sv"
vlog "./displayWin.sv"
vlog "./key.sv"
vlog "./inputProcess.sv"
vlog "./clock_divider.sv"


# Call vsim to invoke simulator
#     Make sure the last item on the line is the name of the
#     testbench module you want to execute.
vsim -voptargs="+acc" -t 1ps -lib work DE1_SoC_testbench
#vsim -voptargs="+acc" -t 1ps -lib work LFSR_testbench

# Source the wave do file
#     This should be the file that sets up the signal window for
#     the module you are testing.
do DE1_SoC.do
#do LED_test.do

# Set the window types
view wave
view structure
view signals

# Run the simulation
run -all

# End
