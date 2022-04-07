----------------------------------------------------------------------------------
-- Engineer: Atticus Russell
-- 
-- Create Date: 01/21/2022 09:41:21 AM
-- Design Name: 
-- Module Name: xor6 - Behavioral
-- Project Name: DSD 2 HW 1
-- Target Devices: 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity hw_generate is
    generic(width : integer := 6);
    port( 
        a   : in std_logic_vector (width-1 downto 0);
        y   : out std_logic
        );
end hw_generate;

architecture Behavioral of hw_generate is
    signal x : std_logic_vector (width - 1 downto 0);
begin
    x(0) <= a(0);
    gen : for i in 1 to width - 1 generate
        x(i) <= a(i) XOR x(i-1);
    end generate;
    y <= x(width - 1);
end Behavioral;
