library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity hw3_q3_soln_D_FF_synch_en is
 Port (
 d, clk, en : in std_logic;
 q      :   out std_logic );
end entity hw3_q3_soln_D_FF_synch_en;

architecture Behavioral of hw3_q3_soln_D_FF_synch_en is begin
dFF : process (clk)
begin
    if(rising_edge(clk)) then
        if en = '1' then
            q <= d;
        end if;
    end if;
end process dFF;

end Behavioral;
