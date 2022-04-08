library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.hw5Q3_pkg.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity hw5q3mem is
    port(
        addr : in std_logic_vector(a_width-1 downto 0);
        d_in : in std_logic_vector(d_width-1 downto 0);
        clk, we : in std_logic;
        d_out : out std_logic_vector(d_width-1 downto 0)
    );
end entity hw5q3mem;

architecture behavioral of hw5q3mem is
    signal mem : mem_type(0 to (a_width**2)-1)(d_width-1 downto 0) := (x"FE", x"0F",
        others => x"01");
    begin
        process (clk) is begin
            if (rising_edge(clk)) then
                if (we = '1') then
                    mem(to_integer(unsigned(addr))) <= d_in;
                end if;
            end if;
        end process;
    d_out <= mem(to_integer(unsigned(addr)));
end behavioral;
