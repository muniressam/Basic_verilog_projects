vlib work
vlog -f sourcfile.txt
vsim -voptargs=+accs work.FIFO_TB
add wave *
run -all

