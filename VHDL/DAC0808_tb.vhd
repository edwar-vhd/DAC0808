-------------------------------------------------------------------
-- University: Universidad Pedagógica y Tecnológica de Colombia
-- Author: Edwar Javier Patiño Núñez
--
-- Create Date: 13/05/2020
-- Project Name: DAC
-- Description: 
-- 	This Test Bench script simulate an 8-bit DAC.
--		The formar for the voltages is: "sign - integer part - decimal part"
--
--		Example:
--			For represent 2.25V with bits_int = 3 and bits_res = 8
--				"0_010_01000000" => (without the "_" character)
--			
--			For represent -3.25V with bits_int = 3 and bits_res = 8
--				"1_100_11000000"
-------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity DAC0808_tb is 
end entity;

architecture behavior of DAC0808_tb is
	constant bits_int			:natural := 3;
	constant bits_res			:natural := 8;
	constant period_100MHz 	:time := 10 ns;
	
	signal clk_s 				:std_logic := '0';
	
	signal data_in				:std_logic_vector(7 downto 0) := (others=>'0');
	signal v_pos				:std_logic_vector(bits_int + bits_res downto 0);
	signal v_neg				:std_logic_vector(bits_int + bits_res downto 0);
			
	signal v_out				:std_logic_vector(bits_int + bits_res downto 0);
begin

	DUT: entity work.DAC0808
		generic map(
			bits_int => bits_int,
			bits_res	=> bits_res
		)
		port map(
			data_in	=> data_in,
		   v_pos		=> v_pos,
		   v_neg		=> v_neg,
			
		   v_out		=> v_out
		);
	
	process
	begin
		clk_s <= not clk_s;
		wait for period_100MHz/2;
	end process;
	
	process
	begin
		wait until falling_edge(clk_s);
		data_in <= std_logic_vector(unsigned(data_in)+1);
	end process;

	-- Supply voltages
	v_pos <= "010100000000";
	v_neg	<= "000000000000";
end architecture;