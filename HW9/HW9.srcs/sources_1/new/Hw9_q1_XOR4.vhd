----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/24/2022 07:51:20 PM
-- Design Name: 
-- Module Name: Hw9_q1_XOR4 - Behavioral
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

entity Hw9_q1_XOR4 is
    Port ( a : in STD_LOGIC_VECTOR (3 downto 0);
           y : out STD_LOGIC);
end Hw9_q1_XOR4;

architecture Behavioral of Hw9_q1_XOR4 is
begin
    y <= a(0) xor a(1) xor a(2) xor a(3);
end Behavioral;
