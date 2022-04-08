library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Hw6Q1 is
    Port ( w : in STD_LOGIC_VECTOR (3 downto 0);
           y : out STD_LOGIC_VECTOR (1 downto 0));
end Hw6Q1;

architecture Behavioral of Hw6Q1 is begin
        y_proc: process (w)
        begin
            if w = "0001" then
                y<= "00";
            elsif w= "0010" then
                y<="01";
            elsif w = "0100" then
                y <= "10";
            else
                y<= "11";
            end if; 
        end process y_proc;        
end Behavioral;
