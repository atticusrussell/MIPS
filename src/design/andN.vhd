----------------------------------------------------------------------------------
-- Company: Rochester Institute of Technology
-- Engineer: Atticus Russell ajr8934@rit.edu
-- Design Name: andN
-- Project Name: Lab1
-- Description: N-bit AND unit
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity andN is
    generic(N : integer := 32); --bit width - default 32
    port( 
        a   : in std_logic_vector   (N-1 downto 0);
        b   : in std_logic_vector   (N-1 downto 0);
        y   : out std_logic_vector  (N-1 downto 0) -- need to change to std logic vector
        );
end andN;

architecture Behavioral of andN is begin
    y <= a AND b;
end Behavioral;
