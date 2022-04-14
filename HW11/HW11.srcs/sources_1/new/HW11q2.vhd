----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/10/2022 04:45:38 PM
-- Design Name: 
-- Module Name: HW11q2 - Behavioral
-- Project Name: DSD 2 HW11
-- Target Devices: I told it was Xilinx that it was Basys 3
-- Tool Versions: 
-- Description: From Harris and Harris Ch. 4 Problem 32
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

entity HW11q2 is
	port (
		clk, rst, a, b : in std_logic;
		q : out std_logic
	);
end entity HW11q2;
architecture behav of HW11q3 is
	type statetype is(s0, s1, s2);
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

	nextstate_proc: process (state, a, b) begin
        case state is
            when s0 => 
                if a = '0' then
                    nextstate <=  s0;
                else
                    nextstate <=  s1;
				end if;
			when s1 =>
				if b = '1' then
					nextstate <= s2;
				else
					nextstate <= s0;
				end if;
            when s2 =>
                	nextstate <= s0;
        end case;
	end process nextstate_proc;

	q_proc: process (state) begin
        case state is
            when s0 =>
				q <= '0';
            when s1 =>
				q <= '0';
            when s2 =>
				q <= '1';
		end case;
	end process q_proc;
	
end architecture behav;
