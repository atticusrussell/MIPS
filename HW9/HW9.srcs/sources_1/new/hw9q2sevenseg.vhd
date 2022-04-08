----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/24/2022 11:41:55 PM
-- Design Name: 
-- Module Name: hw9q2sevenseg - Behavioral
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

entity hw9q2sevenseg is
    Port ( data : in STD_LOGIC_VECTOR (3 downto 0);
           segments : out STD_LOGIC_VECTOR (6 downto 0));
end hw9q2sevenseg;


architecture Behavioral of hw9q2sevenseg is
    --code from Harris and Harris HDL Example 4.24
begin
    process (all) begin
        case data is 
                                    --abcdefg
            when X"0" => segments <= "1111110";
            when X"1" => segments <= "0110000";
            when X"2" => segments <= "1101101";
            when X"3" => segments <= "1111001";
            when X"4" => segments <= "0110011";
            when X"5" => segments <= "1011011";
            when X"6" => segments <= "1011111";
            when X"7" => segments <= "1110000";
            when X"8" => segments <= "1111111";
            when X"9" => segments <= "1110011"; --provided but could also be 1111011
            --complete the decoder so it handles A-F
            when X"A" => segments <= "1111101"; 
            when X"B" => segments <= "0011111"; 
            when X"C" => segments <= "1001110"; 
            when X"D" => segments <= "0111101"; 
            when X"E" => segments <= "1001111"; 
            when X"F" => segments <= "1000111"; 

            when others => segments <= "0000000";
        end case;
    end process;
end Behavioral;
