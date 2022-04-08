--------------------------------------------------------------------------------
-- Title       : Writeback Stage Testbench
-- Project     : Default Project Name
--------------------------------------------------------------------------------
-- File        : Writeback_Stage_tb.vhd
-- Author      : ajr8934
-- Company     : User Company Name
-- Created     : Thu Mar 24 11:50:47 2022
-- Last update : Thu Mar 24 14:22:01 2022
-- Platform    : Default Part Number
-- Standard    : <VHDL-2008 | VHDL-2002 | VHDL-1993 | VHDL-1987>
--------------------------------------------------------------------------------
-- Copyright (c) 2022 User Company Name
-------------------------------------------------------------------------------
-- Description: 	Testbench for writeback stage of simulated MIPS processor
--------------------------------------------------------------------------------
-- Revisions:  Revisions and documentation are controlled by
-- the revision control system (RCS).  The RCS should be consulted
-- on revision history.
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
--use std.textio.all;
--use ieee.std_logic_textio.all;

-----------------------------------------------------------

entity Writeback_Stage_tb is

end entity Writeback_Stage_tb;

-----------------------------------------------------------

architecture testbench of Writeback_Stage_tb is

	-- Testbench DUT generics


	-- Testbench DUT ports
	signal RegWrite    : STD_LOGIC := '0'; 
	signal MemtoReg    : STD_LOGIC := '0';
	signal ALUResult   : STD_LOGIC_VECTOR (31 downto 0)  :=  32x"00ABCDEF";
	signal ReadData    : STD_LOGIC_VECTOR (31 downto 0)  :=  32x"00123456";
	signal WriteReg    : STD_LOGIC_VECTOR (4 downto 0) := "00000";
	signal RegWriteOut : STD_LOGIC;
	signal WriteRegOut : STD_LOGIC_VECTOR (4 downto 0);
	signal Result      : STD_LOGIC_VECTOR (31 downto 0);
	
	--other TB signals
	signal clk : std_logic := '0';

	-- Other constants
	constant C_CLK_PERIOD : time := 40 ns; -- NS
	

begin
	-----------------------------------------------------------
	-- Clocks and Reset
	-----------------------------------------------------------
	CLK_GEN : process
	begin
		clk <= '1';
		wait for C_CLK_PERIOD / 2.0;
		clk <= '0';
		wait for C_CLK_PERIOD / 2.0;
	end process CLK_GEN;


	-----------------------------------------------------------
	-- Testbench Stimulus
	-----------------------------------------------------------
	stimulus : process is begin

		wait for C_CLK_PERIOD;
		assert (Result'delayed = 32x"00ABCDEF") report "Result is "  & to_hstring(Result) & " but should be 00ABCDEF." severity ERROR;


		ALUResult  <= 32x"FFFFFFFF";
		wait for 1 ns;
		assert (Result = 32x"FFFFFFFF") report "Result is "  & to_hstring(Result) & " but should be FFFFFFFF." severity ERROR;


		wait until rising_edge(clk);
		MemtoReg  <= '1';
		wait for 1 ns;
		assert (Result = ReadData) report "Result is "  & to_hstring(Result) & " but should be " & to_hstring(ReadData) & "." severity ERROR;


		wait until rising_edge(clk);
		ReadData  <= 32x"00000000";
		wait for 1 ns;
		assert (Result = 32x"00000000") report "Result is "  & to_hstring(Result) & " but should be 00000000." severity ERROR;


		wait until rising_edge(clk);
		MemtoReg  <= '0';
		wait for 1 ns;
		assert (Result = ALUResult) report "Result is "  & to_hstring(Result) & " but should be " & to_hstring(ALUResult) & "." severity ERROR;


		wait until rising_edge(clk);
		WriteReg  <= "11111";
		wait for 1 ns;
		assert (WriteRegOut = "11111") report "WriteRegOut is "  & to_hstring(WriteRegOut) & " but should be " & to_hstring(WriteReg) & "." severity ERROR;


		wait until rising_edge(clk);
		RegWrite  <= '1';
		wait for 1 ns;
		assert (RegWriteOut = '1') report " is "  & std_logic'image(RegWriteOut) & " but should be 1." severity ERROR;


		wait until rising_edge(clk);
        WriteReg  <= "01010";
        wait for 1 ns;
		assert (WriteRegOut = "01010") report "WriteRegOut is "  & to_hstring(WriteRegOut) & " but should be 01010." severity ERROR;

		wait until rising_edge(clk);
        RegWrite  <= '0';
        wait for 1 ns;
		assert (RegWriteOut = '0') report " is "  & std_logic'image(RegWriteOut) & " but should be 0." severity ERROR;
		
		wait for C_CLK_PERIOD; --some time for last action to display 

        -- end testbench
        --crude default way that provided tesbenches end. Throw code that aborts process
            --lowkey annoying - change if have time when done
        assert false
          report "Testbench Concluded."
          severity failure;
    
        wait;


	end process stimulus;
	-----------------------------------------------------------
	-- Entity Under Test
	-----------------------------------------------------------
	DUT : entity work.Writeback_Stage
		port map (
			RegWrite    => RegWrite,
			MemtoReg    => MemtoReg,
			ALUResult   => ALUResult,
			ReadData    => ReadData,
			WriteReg    => WriteReg,
			RegWriteOut => RegWriteOut,
			WriteRegOut => WriteRegOut,
			Result      => Result
		);

end architecture testbench;
