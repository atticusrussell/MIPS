library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity hw3q5multdriver is
    Port (      
        a,b,c     : in    std_logic;
        y,z       : out   std_logic
        );
end  entity hw3q5multdriver;

architecture Behavioral of hw3q5multdriver is begin 
y_comb_logic    : process(a,b,c)
begin
    if (a = '1') or (b = '1') then 
        y <= '0';
    elsif (c='0') then
        y <= '1';
    else
        y <= '0';
    end if;
end process y_comb_logic;

z_comb_logic    : process(a,b,c)
begin
    if (a = '1') or (b = '1') then 
        z <= '0';
    elsif (c='0') then
        z <= '1';
    else
        z <= '0';
    end if;
end process z_comb_logic;
end Behavioral;