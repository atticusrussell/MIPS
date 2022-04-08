library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

--selected signal solution
entity Hw5Q1 is
    Port ( w : in STD_LOGIC_VECTOR (2 downto 0);
           f : out STD_LOGIC);
end Hw5Q1;

architecture Behavioral of Hw5Q1 is
begin
    with w select
        f<= '0' when "001",
            '0' when "110",
            '1' when others;
end Behavioral;
