library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity hw8q4 is
    port (
        a, b, c, d : in std_logic;
        sel : in std_logic_vector(1 downto 0);
        z : out std_logic);
end hw8q4;

architecture Behavioral of hw8q4 is begin
    z_proc: process (sel, a, b, c, d) is begin
        case sel is
            when "00" => z <=  a;
            when "01" => z <=  b;
            when "10" => z <=  c;
            when others => z <=  d;
        end case;
    end process;
end Behavioral;
