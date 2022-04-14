----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/31/2022 10:33:37 PM
-- Design Name: 
-- Module Name: hw10q2SRLatch - Behavioral
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
use IEEE.STD_LOGIC_1164.ALL;

entity hw10q2SRLatch is
    Port ( s, r : in STD_LOGIC;
        q : out STD_LOGIC);
end hw10q2SRLatch;

architecture Behavioral of hw10q2SRLatch is
    signal q_next: std_logic;
begin
    process (s, r) is begin
        if (s = '0' and r = '0') then
            q_next <=  q;
        elsif (s = '0' and r = '1') then
            q_next <= '0';
		elsif (s = '1' and r = '0') then
            q_next <= '1';
		end if;
    end process;
    q <= q_next;
end Behavioral;
