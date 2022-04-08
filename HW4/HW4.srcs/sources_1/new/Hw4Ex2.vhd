----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/11/2022 05:22:05 PM
-- Design Name: 
-- Module Name: Hw4Ex2 - Behavioral
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

entity Hw4Ex2 is
  port ( 
  d_in, clk, rst    : in    std_logic;
  q_out:    out std_logic);
end Hw4Ex2;

architecture Behavioral of Hw4Ex2 is
    signal qint : std_logic_vector(3 downto 0);
begin
shift_proc  : process (clk, rst) is begin
    if (rst = '1') then
        qint <= (others => '0');
    elsif rising_edge(clk) then
        qint <= qint(2 downto 0) & d_in;
    end if;
end process shift_proc;
q_out   <= qint(0) and qint(1) and qint(2) and not qint(3);
end Behavioral;
