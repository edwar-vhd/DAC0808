-------------------------------------------------------------------
-- University: Universidad Pedagógica y Tecnológica de Colombia
-- Author: Edwar Javier Patiño Núñez
--
-- Create Date: 11/05/2020
-- Project Name: DAC
-- Description: 
-- 	This description emulates the ideal behavior of an 8-bit DAC.
--		The resolution of the voltages is given by the value
--		of the generic signal "bits_res" (in number of bits), and
--		the bits required for integer part are given by "bits_int"
-------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity DAC0808 is
	generic(
		-- Voltages parameters
		bits_int		:natural := 3;		-- Bits of the integer part (no sign bit)
		bits_res		:natural := 8		-- Resolution bits
	);
	port(
		data_in	:in std_logic_vector(7 downto 0);							-- Data input
		v_pos		:in std_logic_vector(bits_int + bits_res downto 0);	-- Positive reference voltage
		v_neg		:in std_logic_vector(bits_int + bits_res downto 0);	-- Negative reference voltage
		
		v_out		:out std_logic_vector(bits_int + bits_res downto 0)	-- Output voltage
	);
end entity;

architecture behavior of DAC0808 is
	-- Signals for DAC
	signal div					:std_logic_vector(7 downto 0);
	signal v_dac_num			:std_logic_vector(8 + bits_res + 3 + bits_int + bits_res downto 0);
	signal v_dac_div			:std_logic_vector(8 + 1 + bits_res downto 0);
	signal v_dac				:std_logic_vector(8 + bits_res + 3 + bits_int + bits_res downto 0);
	signal exp					:std_logic_vector(bits_res downto 0);
begin
	div <= (others => '1');
	exp <= std_logic_vector(to_unsigned(2**bits_res, bits_res + 1));
	v_dac_num <= std_logic_vector(signed('0'&(unsigned(data_in)*unsigned(exp)))*signed(signed(v_pos(bits_int + bits_res)&v_pos) - signed(v_neg(bits_int + bits_res)&v_neg)));
	v_dac_div <= std_logic_vector(signed('0'&(unsigned(div)*unsigned(exp))));
	v_dac <= std_logic_vector(signed(signed(v_dac_num)/signed(v_dac_div))+(signed(v_neg)));
	
	-- Output voltage
	v_out <= v_dac (bits_int + bits_res downto 0);
end architecture;