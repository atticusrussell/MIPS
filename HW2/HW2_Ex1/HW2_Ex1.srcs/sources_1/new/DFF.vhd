library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity DFF is
  Port (
  d, clk, clr : in std_logic;
  q         : out std_logic
  );
end DFF;

architecture Behavioral of DFF is begin
dFF : process(clk,clr)
begin
    if clr = '1' then 
        q <= '0';
    elsif (rising_edge(clk)) then
        q <= d;
    end if;
end process dFF;

end Behavioral;
