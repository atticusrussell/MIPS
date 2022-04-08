library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity hw8q3 is
    port (d, clk, reset, enable : in std_logic;
        q : out std_logic);
end hw8q3;

architecture Behavioral of hw8q3 is begin
    process (clk) begin
        if clk'event and clk = '1' then
            if reset = '1' then
                q <=  '0';
            else
                q <= d;
            end if;
        end if;
    end process;
end Behavioral;
