library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity hw2_q5_jk_FF is
 Port (
 j, k, clk, rst : in std_logic;
 q      :   out std_logic );
end entity hw2_q5_jk_FF;

architecture Behavioral of hw2_q5_jk_FF is 
    signal qint : std_logic;
begin
JKFF : process (clk, rst) is begin
    if (rst = '1') then
        qint <= '0';
    elsif(rising_edge(clk)) then
        if j = '0' and k = '0' then
            qint <= qint;
        elsif j= '0' and k = '1' then
            qint <= '0';
        elsif j= '1' and k = '1' then
            qint <= '1';
        else -- if both j and k are 1
            qint <= not qint;
        end if;
    end if;
end process JKFF;
q <= qint;
end Behavioral;