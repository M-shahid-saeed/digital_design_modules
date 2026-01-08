# ---------------------------------------------------------
# SHAHID KING'S MULTIPLIER AUTOMATION SCRIPT
# Usage: do run.tcl <width>
# ---------------------------------------------------------

# 1. Width Set karein (Argument handling)
if { [info exists 1] } {
    set WIDTH $1
} else {
    set WIDTH 8
}

puts "----------------------------------------------------"
puts "SHAHID KING: Running Simulation with N = $WIDTH"
puts "----------------------------------------------------"

# 2. Purani Library delete aur nayi Create karein
if {[file exists work]} {
    vdel -lib work -all
}
vlib work

# 3. Compile Files (Ab direct files ke naam likhein kyunke sab ek hi folder mein hain)
# RTL Files
vlog -sv full_adder.sv
vlog -sv cubic.sv
vlog -sv multiplier_core.sv
vlog -sv top_multiplier.sv

# Testbench Files
vlog -sv multiplier_intf.sv
vlog -sv transaction.sv
vlog -sv generator.sv
vlog -sv driver.sv
vlog -sv monitor.sv
vlog -sv scoreboard.sv
vlog -sv environment.sv
vlog -sv tb_top.sv

# 4. Load Simulation (Parameter Override)
vsim -voptargs=+acc -GN=$WIDTH work.tb_top

# 5. Add Waves
add wave -position insertpoint sim:/tb_top/vif/*

# 6. Run
run -all

# 7. Zoom Full
wave zoom full