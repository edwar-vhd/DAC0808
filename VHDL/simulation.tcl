#!/usr/bin/tclsh
quit -sim

set DAC_ROOT "."

exec vlib work

set dac_vhdls [list \
	"$DAC_ROOT/DAC0808.vhd" \
	"$DAC_ROOT/DAC0808_tb.vhd" \
	]
	
foreach src $dac_vhdls {
	if [expr {[string first # $src] eq 0}] {puts $src} else {
		vcom -2008 -work work $src
	}
}

vsim -voptargs=+acc work.dac0808_tb
do wave.do
run 2550 ns
