----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/11/2022 
-- Design Name: 
-- Module Name: HW11q3 - Behavioral
-- Project Name: DSD 2 HW11
-- Target Devices: I told Xilinx that it was Basys 3
-- Tool Versions: 
-- Description: From Harris and Harris Ch. 4 Problem 37
-- 
-- Dependencies: none
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
-----------------------------------------------------------------------------------

library ieee;
	use ieee.std_logic_1164.all;
	use ieee.numeric_std.all;

entity HW11q3 is
	port (
		clk, rst : in std_logic;
		q : out std_logic_vector(2 downto 0)
	);
end entity HW11q3;
architecture behav of HW11q3 is
	type statetype is(s0, s1, s2, s3, s4, s5, s6, s7);
	signal state, nextstate	: statetype;
begin
	clk_rst_proc : process(clk) begin
        if rising_edge(clk) then
            if rst = '1' then
                state <= s0;
            else
                state <= nextstate;
    		end if;
    	end if;
	end process clk_rst_proc;

	nextstate_proc: process (state) begin
        case state is
            when s0 => 
				nextstate <= s1;
			when s1 =>
				nextstate <= s2;
			when s2 =>
				nextstate <= s3;
			when s3 =>
				nextstate <= s4;
			when s4 =>
				nextstate <= s5;
			when s5 =>
				nextstate <= s6;
			when s6 =>
				nextstate <= s7;
            when s7 =>
				nextstate <= s0;
        end case;
	end process nextstate_proc;

	q_proc: process (state) begin
        case state is
            when s0 =>
				q <= "000";
            when s1 =>
				q <= "001";
            when s2 =>
				q <= "011";
			when s3 =>
				q <= "010";
            when s4 =>
				q <= "110";
            when s5 =>
				q <= "111";
			when s6 =>
				q <= "101";
            when s7 =>
				q <= "100";
		end case;
	end process q_proc;
	
end architecture behav;
