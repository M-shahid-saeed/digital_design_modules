# ---------------------------------------------------------
# SHAHID KING: PC SAFETY & TIMEOUT SCRIPT
# ---------------------------------------------------------

# 1. Parameter Handling
if { [info exists 1] } {
    set WIDTH $1
} else {
    set WIDTH 8
}

echo "----------------------------------------------------"
echo "SHAHID KING: Loading N = $WIDTH"
echo "Safety Timeout: 5000ns"
echo "----------------------------------------------------"

# 2. Cleanup and Library
if {[file exists work]} { vdel -lib work -all }
vlib work

# 3. Compilation
vlog -sv counter.sv
vlog -sv counter_intf.sv
vlog -sv tb_top.sv

# 4. Simulation Load
vsim -voptargs="+acc" -GN=N=$WIDTH work.tb_top

# 5. Add Waves
add wave -position insertpoint sim:/tb_top/vif/*

# 6. Safety Run (PC crash se bachne ke liye)
# 'run -all' ki jagah hum 'run 5000ns' use kar rahe hain
# Agar aapka counter zyada lamba hai toh is time ko barha sakte hain (e.g. 10000ns)
run 5000ns

# 7. Final View
wave zoom full
echo "----------------------------------------------------"
echo "SIMULATION STOPPED AT 5000ns TO SAVE RAM"
echo "----------------------------------------------------"