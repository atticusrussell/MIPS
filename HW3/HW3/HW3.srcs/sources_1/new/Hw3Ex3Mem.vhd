-------------------------------------------------------------------
-- Create Date: 02/04/2022 
-- Engineer Name: Atticus Russell
-- Class: DSD 1
-- Module Name: hw3prob3 - Behavioral
-- making "memory"
-------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;


entity hw3ex3mem is
    Port (      
        addr       : in    std_logic_vector (2 downto 0);
        clk, we     : in    std_logic;
        din       : in    std_logic_vector (5 downto 0);
        dout       : out   std_logic_vector(5 downto 0)
        );
end  entity hw3ex3mem;

architecture Behavioral of hw3ex3mem is
    type mem_type is array (0 to 7) of std_logic_vector(5 downto 0);
    signal mem : mem_type := ("000001","000011","000111","001111","011111","111111",
        "011111","001111");
begin 
MemModel    : process(clk)
begin
    if(rising_edge(clk)) then 
        if we = '1' then
            mem(to_integer(unsigned(addr))) <= din;
        end if;
    end if;
end process MemModel;
dout <= mem(to_integer(unsigned(addr)));
end Behavioral;