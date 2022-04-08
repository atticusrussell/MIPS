----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/01/2022 12:09:23 AM
-- Design Name: 
-- Module Name: hw10q3VariablesTB - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

entity hw10q3VariablesTB is
end hw10q3VariablesTB;

architecture bench of hw10q3VariablesTB is
    signal clk, rst: std_logic := '1';
    signal count_out1, count_out2 : std_logic_vector(2 downto 0);
    constant clk_period: time := 10 ns;
begin
    uut : entity work.hw10q3Variables port map ( clk => clk, rst =>  rst, count_out1 => count_out1, count_out2 =>  count_out2);
    clk <= not clk after clk_period/2;
    rst <= '0' after 30 ns;
end bench;
