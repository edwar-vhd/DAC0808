onerror {resume}
quietly WaveActivateNextPane {} 0
radix -hexadecimal -showbase


add wave -noupdate -group Test_Bench_Signals /dac0808_tb/*

add wave -noupdate -group in-out-signals -divider Input-data
add wave -noupdate -group in-out-signals -label digital_data_in -color #FFFF00 /dac0808_tb/data_in
add wave -noupdate -group in-out-signals -divider output-wave-voltage
add wave -noupdate -group in-out-signals -format analog-step -height 50 -min 0 -max 1024 -label output_voltage -color #FF0000 -radix hexadecimal /dac0808_tb/v_out