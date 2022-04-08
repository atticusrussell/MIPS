library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Hw2q7latchsoln is Port ( 
            a, b, c     : in    std_logic;
            y           : out   std_logic);
end entity Hw2q7latchsoln;

architecture Behavioral of Hw2q7latchsoln is begin
comb_logic  :   process (a,b,c)
begin
    if(a = '1') or (b = '1') then
        y <= '0';
    elsif   (c = '0') then
        y <= '1';
    else
        y <= '0';
    end if;
end process comb_logic;
end Behavioral;
