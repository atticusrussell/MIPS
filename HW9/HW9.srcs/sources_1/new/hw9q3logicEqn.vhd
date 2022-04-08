----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/25/2022 12:56:39 AM
-- Design Name: 
-- Module Name: hw9q3logicEqn - Behavioral
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

entity hw9q3logicEqn is
    Port ( a, b, c : in STD_LOGIC;
           y : out STD_LOGIC);
end hw9q3logicEqn;

architecture Behavioral of hw9q3logicEqn is
    signal h,i,j : std_logic;
begin
    -- #y = a~b + ~b~c + ~abc.
    h <= (a and not b);
    i <=  (not b and not c);
    j <=  (not a and b and c);

    y <=  h or i or j;
    --y <= (a and not b) or (not b and not c) or (not a and b and c);
end Behavioral;
