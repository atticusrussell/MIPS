-------------------------------------------------------------------
-- Create Date: 02/01/2022 01:14:53 PM
-- Engineer Name: Atticus Russell
-- Class: DSD 1
-- Module Name: hw3prob1 - Behavioral
-- making "n-bit register"
-------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity hw3prob1 is
    --add a generic
    generic( N : integer := 8  );
    --add the port signals using the generic
Port (      
    -- load    : in    std_logic;
    clk     : in    std_logic;
    d       : in    std_logic_vector (n-1 downto 0);
    q       : out   std_logic_vector(n-1 downto 0)
    );
end  entity hw3prob1;

architecture Behavioral of hw3prob1 is begin 
dFFreq  :   process (clk)
begin
    if(rising_edge(clk)) then 
        q <= d;
    end if;
end process dFFreq;
end Behavioral;