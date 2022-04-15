----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/14/2022 9:18 PM
-- Design Name: 
-- Module Name: MIPS_main_Fib_demo_B_TB - Behavioral
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

entity MIPS_main_Fib_demo_B_TB is
    generic(
		N : integer := 32
	);
end entity MIPS_main_Fib_demo_B_TB;

architecture bench of MIPS_main_Fib_demo_B_TB is

    signal clk_top: STD_LOGIC := '0';
    signal rst_top: STD_LOGIC := '0';
    signal ALUResult_top: STD_LOGIC_VECTOR (31 downto 0);
    signal Result_top: STD_LOGIC_VECTOR (31 downto 0);

    --other constants
	constant C_CLK_PERIOD : time := 20 ns;

	--[x] make the testbench self-checking for the instructions Written in instructionMemory to test each operation

	-- [ ] make the testbench verify the fibonacci results from DataMemory

	/* type test_vector is record
		Result : STD_LOGIC_VECTOR (31 downto 0);
	end record;

	type test_array is array (natural range<>) of test_vector;

	constant test_vector_array : test_array := (
		( Result => 32x"4"), 		-- 100-120 ns	ORI
		( Result => 32x"3"), 		-- 180-200 ns	ORI
		( Result => 32x"7"), 		-- 260-280 ns	ADD
		( Result => 32x"0"), 		-- 340-360 ns	SW
		( Result => 32x"7"), 		-- 420-440 ns	LW
		( Result => 32x"3"), 		-- 500-520 ns	AND
		( Result => 32x"1"), 		-- 580-600 ns	SUB
		( Result => 32x"38"), 		-- 660-680 ns	SLLV
		( Result => 32x"ffffffcc"), -- 740-760 ns	SUB
		( Result => 32x"ffffffe6"), -- 820-840 ns	SRAV
		( Result => 32x"7ffffff3"), -- 900-920 ns	SRLV
		( Result => 32x"80000015"), -- 980-1000 ns	XOR
		( Result => 32x"c"), 		-- 1060-1080 ns	MULTU
		( Result => 32x"7"), 		-- 1140-1160 ns	OR
		( Result => 32x"f"), 		-- 1220-1240 ns	XORI
		( Result => 32x"c"), 		-- 1300-1320 ns	ANDI
		( Result => 32x"18") 		-- 1380-1400 ns ADDI
	); */
		
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
		-- Initially Reset the processor
		rst_top <= '1';
        wait for C_CLK_PERIOD;
		rst_top <= '0';

		/* 
		-- also wait for 0.75x clock period so that am checking result 3/4 of the way through the period so that any sort of delay has had time to finish
		wait for 0.75* C_CLK_PERIOD;
        
		-- Put test bench stimulus code here
		for i in test_vector_array'range loop

			--wait for 4x clock period because of the 3 No-ops + to get to the current spot in next result period
			wait for 4*C_CLK_PERIOD;

			--check that the result matches the expected result
			assert Result_top = test_vector_array(i).Result
				report "Result is " & to_hstring(signed(Result_top)) &
                " but should be " & to_hstring(signed(test_vector_array(i).Result))
				severity error;
			
		end loop;
 
		-- HACK crude default way that provided tesbenches end. Throw code that aborts process
        assert false
          report "Testbench Concluded."
		  severity failure;

		*/
		
	
		wait;
  	end process;
end;
  