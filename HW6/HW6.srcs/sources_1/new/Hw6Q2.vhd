
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Hw6Q2 is
    Port ( w : in STD_LOGIC_VECTOR (7 downto 0);
           y : out STD_LOGIC_VECTOR (2 downto 0));
end Hw6Q2;

architecture Behavioral of Hw6Q2 is begin
y_proc :process(w) 
begin
    case w is
        when "00000001" => y <= "000";
        when "00000010" => y <= "001";
        when "00000100" => y <= "010";
        when "00001000" => y <= "011";
        when "00010000" => y <= "100";
        when "00100000" => y <= "101";
        when "01000000" => y <= "110";
        when others => y <= "111";
    end case;
end process y_proc;
end Behavioral;
