--------------------------------------------------------------------------------
-- Title       : Memory Stage Testbench
-- Project     : Exercise 5
-- Course      : CMPE 260
--------------------------------------------------------------------------------
-- File        : memory_stage_tb.vhd
-- Author      : ajr8934
-- School      : RIT Computer Engineering
-- Created     : Wed Mar 23 17:27:09 2022
-- Platform    : Basys 3 (but not really ever tested on HW)
-- Standard    : <VHDL-2008>
-------------------------------------------------------------------------------
-- Description: Testbench for Memory Stage of simulated MIPS microprocessor
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;
use ieee.std_logic_textio.all;

-----------------------------------------------------------

entity memory_stage_tb is
    generic(
        N : integer := 32
    );
end entity memory_stage_tb;

-----------------------------------------------------------

architecture testbench of memory_stage_tb is

	-- Testbench DUT generics
    --constant N : integer := 32;

    -- Testbench DUT ports
    --passthrough inputs 
    signal RegWrite     : std_logic := '0';
    signal MemtoReg     : std_logic := '0';
    signal WriteReg     : std_logic_vector(4 downto 0) := "01111";
    --real inputs
	signal clk          : std_logic;
    signal MemWrite     : std_logic; --translates to w_en in data_memory
    signal ALUResult    : std_logic_vector(N-1 downto 0); -- 10 LSb basically Addr 
    signal WriteData    : std_logic_vector(N-1 downto 0); --basically d_in
    --passthrough outputs
	signal RegWriteOut  : std_logic;
	signal MemtoRegOut  : std_logic;
    signal WriteRegOut  : std_logic_vector(4 downto 0); 
    -----------------------------------------------------------
    signal MemOut       : std_logic_vector(N-1 downto 0); --basically MemOut
    signal ALUResultOut : std_logic_vector(N-1 downto 0); -- passthrough 

	-- Other constants
    constant C_CLK_PERIOD : time := 40 ns; -- 40 NS

begin
	-----------------------------------------------------------
	-- Clocks and Reset
	-----------------------------------------------------------
	CLK_GEN : process
	begin
		clk <= '1';
		wait for C_CLK_PERIOD / 2;
		clk <= '0';
		wait for C_CLK_PERIOD / 2;
	end process CLK_GEN;


	-----------------------------------------------------------
	-- Testbench Stimulus
    -----------------------------------------------------------
    stimulus: process is begin
        
        --load first test (provided from verilog)
        wait until falling_edge(clk) ;
        MemWrite <=  '1'; --enable write
        ALUResult <= 32x"1B"; -- address to write to 
        WriteData <= 32x"AAAA5555"; -- d_in

        --load 2nd test (provided from verilog)
        wait until falling_edge(clk) ;
        ALUResult <= 32x"1C"; -- address to write to 
        WriteData <= 32x"5555AAAA"; -- d_in

        --load my own tests
        --load third test value
        wait until falling_edge(clk);
        ALUResult <= 32x"1D";
        WriteData <= 32x"00DEFACE";

        --load fourth test value
        wait until falling_edge(clk);
        ALUResult <= 32x"1E";
        WriteData <= 32x"CAFE1234";

        --load fifth test value - fib
        wait until falling_edge(clk);
        ALUResult <= 32x"FF"; 
        WriteData <= 32x"0112358D";


        --verify provided test cases:
        --first test case
        wait until falling_edge(clk);
        MemWrite <=  '0';
        ALUResult <= 32x"1B";

        wait until rising_edge(clk);
        wait for C_CLK_PERIOD/4; -- should probably do something with clk'delay
        assert MemOut = 32x"AAAA5555"
            report "ALUResult is " & to_hstring(ALUResult) & ", memory output is " & to_hstring(MemOut) & " but should be AAAA5555." severity error;

        --second test case

        wait until falling_edge(clk);
        ALUResult <= 32x"1C";

        wait until rising_edge(clk);
        wait for C_CLK_PERIOD/4; -- should probably do something with clk'delay
        assert MemOut = 32x"5555AAAA"
            report "ALUResult is " & to_hstring(ALUResult) & ", memory output is " & to_hstring(MemOut) & " but should be 5555AAAA." severity error;


        --lets flip the passthroughs to demonstrate what they do
        RegWrite <= '1';
        MemtoReg <= '1';
        WriteReg <= 5x"9";


        
        -- my own test cases :



        --third test case
        wait until falling_edge(clk);
        ALUResult <= 32x"1D";

        wait until rising_edge(clk);
        wait for C_CLK_PERIOD/4;
        assert MemOut = 32x"00DEFACE"
            report "ALUResult is " & to_hstring(ALUResult) & ", memory output is " & to_hstring(MemOut) & " but should be 00DEFACE." severity error;

        --fourth test case
        wait until falling_edge(clk);
        ALUResult <= 32x"1E";

        wait until rising_edge(clk);
        wait for C_CLK_PERIOD/4;
        assert MemOut = 32x"CAFE1234"
            report "ALUResult is " & to_hstring(ALUResult) & ", memory output is " & to_hstring(MemOut) & " but should be CAFE1234." severity error;

        --fifth test case
        wait until falling_edge(clk);
        ALUResult <= 32x"FF";

        wait until rising_edge(clk);
        wait for C_CLK_PERIOD/4;
        assert MemOut = 32x"0112358D"
            report "ALUResult is " & to_hstring(ALUResult) & ", memory output is " & to_hstring(MemOut) & " but should be 0112358D." severity error;

        
        --load sixth test value (tests overwrite)
        wait until falling_edge(clk);
        ALUResult <= 32x"1B";
        MemWrite <= '1';
        WriteData <= 32x"12344321";
        
    
        -- processing delay sixth test case (tests overwrite)
        wait until falling_edge(clk);
        
        
         --sixth test case (tests overwrite)
        wait until rising_edge(clk);
        wait for C_CLK_PERIOD /4;
        assert MemOut = 32x"12344321"
            report "ALUResult is " & to_hstring(ALUResult) & ", memory output is " & to_hstring(MemOut) & " but should be (hex) 12344321. (likely OVERWRITE ISSUE)" severity error;
        MemWrite <= '0';
        
        wait for C_CLK_PERIOD * 1.5; -- delay to see final result

        
        -- end testbench
        --crude default way that provided tesbenches end. Throw code that aborts process
            --lowkey annoying - change if have time when done
        assert false
          report "Testbench Concluded."
          severity failure;
    
        wait;
    end process;

	-----------------------------------------------------------
	-- Entity Under Test
	-----------------------------------------------------------
	DUT : entity work.memory_stage
		-- generic map (
		-- 	N => N
		-- )
		port map (
			RegWrite     => RegWrite,
			MemtoReg     => MemtoReg,
			WriteReg     => WriteReg,
			clk          => clk,
			MemWrite     => MemWrite,
			ALUResult    => ALUResult,
			WriteData    => WriteData,
			RegWriteOut  => RegWriteOut,
			MemtoRegOut  => MemtoRegOut,
			WriteRegOut  => WriteRegOut,
			MemOut       => MemOut,
			ALUResultOut => ALUResultOut
		);

end architecture testbench;
