transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/jared/Desktop/Fall\ 2024/ECE-3710/Quartas/VGA {C:/Users/jared/Desktop/Fall 2024/ECE-3710/Quartas/VGA/vgaControl.v}
vlog -vlog01compat -work work +incdir+C:/Users/jared/Desktop/Fall\ 2024/ECE-3710/Quartas/VGA {C:/Users/jared/Desktop/Fall 2024/ECE-3710/Quartas/VGA/divider.v}
vlog -vlog01compat -work work +incdir+C:/Users/jared/Desktop/Fall\ 2024/ECE-3710/Quartas/VGA {C:/Users/jared/Desktop/Fall 2024/ECE-3710/Quartas/VGA/VGA.v}

