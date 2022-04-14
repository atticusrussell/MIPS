----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/03/2022 10:11:13 PM
-- Design Name: 
-- Module Name: MIPS_main_demo_A_TB - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity MIPS_main_demo_A_TB is
    generic(
		N : integer := 32
	);
end entity MIPS_main_demo_A_TB;

architecture bench of MIPS_main_demo_A_TB is
	
    signal clk_top: STD_LOGIC := '0';
    signal rst_top: STD_LOGIC := '0';
    signal ALUResult_top: STD_LOGIC_VECTOR (31 downto 0);
    signal Result_top: STD_LOGIC_VECTOR (31 downto 0);

    --other constants
	constant C_CLK_PERIOD : time := 20 ns;

begin
    -----------------------------------------------------------
	-- Entity Under Test
	-----------------------------------------------------------
	MIPS_main_1 : entity work.MIPS_main
		-- generic map (
		-- 	N => N
		-- )
		port map (
			clk_top       => clk_top,
			rst_top       => rst_top,
			ALUResult_top => ALUResult_top,
            Result_top    => Result_top
        
		);	
    ----------------------------------------------------------

    -----------------------------------------------------------
	-- Clocks and Reset
	-----------------------------------------------------------
	CLK_GEN : process
	begin
        clk_top <= '1';
		wait for C_CLK_PERIOD / 2;
        clk_top <= '0';
		wait for C_CLK_PERIOD / 2;
	end process CLK_GEN;

    


	stimulus: process is begin
	-- Put initialisation code here
	




	-- Initially Reset the processor
		rst_top <= '1';
        wait for C_CLK_PERIOD;
        rst_top <= '0';
        
    


    -- Put test bench stimulus code here

		wait;
  	end process;

	
end;
  