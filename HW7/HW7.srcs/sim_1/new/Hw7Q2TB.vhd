library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity HW7Q2TB is
end entity HW7Q2TB;

architecture tb of HW7Q2TB is
	signal clk, rst  : STD_LOGIC := '0';
	signal w         : STD_LOGIC_VECTOR (1 downto 0) := (others => '0');
	signal z, InIdle : STD_LOGIC;
	constant clk_period : time := 10 ns;
	signal state_cnt : integer := 0; 
begin
	dut : entity work.HW7Prob2
		port map (
			clk    => clk,
			rst    => rst,
			w      => w,
			z      => z,
			InIdle => InIdle
		);

		clk <= not clk after clk_period/2;

		stimuli : process is begin
		rst   <=  '1';
		wait for clk_period;
		wait until clk = '0';
		rst <= '0';

		w  <=  "11";
		wait for clk_period;
		assert z = '0' report "w same 1 time, z should be 0";
		w  <=  "11";
		wait for clk_period;
		assert z = '0' report "w same 2 times, z should be 0";
		w  <=  "11";
		wait for clk_period;
		assert z = '0' report "w same 3 times, z should be 0";

		w  <=  "10";
		wait for clk_period;
		assert z = '1' report "w same 4 times, z should be 1";

		w  <=  "10";
		wait for clk_period;
		assert InIdle = '1' report "w different for 1 clocks, z should be 0";

			wait;
		end process stimuli;

end architecture tb;
