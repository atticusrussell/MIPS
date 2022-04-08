library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Hw5Q2 is
    Port ( w : in STD_LOGIC_VECTOR (2 downto 0);
           f : out STD_LOGIC);
end Hw5Q2;

architecture Behavioral of Hw5Q2 is
begin  
    process(w) is begin
        case w is
            when "010" => f <= '1';
            when "100" => f <= '1';
            when "101" => f <= '1';
            when "111" => f <= '1';
            when others => f <= '0';
        end case;
    end process;
end Behavioral;