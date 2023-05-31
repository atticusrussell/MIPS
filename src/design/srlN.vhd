----------------------------------------------------------------------------------
-- Company: Rochester Institute of Technology
-- Engineer: Atticus Russell ajr8934@rit.edu
-- 
-- Create Date: 01/26/2022 
-- Design Name: srlN
-- Module Name: srlN - behavioral
-- Project Name: Lab1 prelab
-- Target Devices: Basys3
--
-- Description: N-bit logical right shift (SrL) unit
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity srlN is
    GENERIC (N : INTEGER := 32;  --bit width
             M : INTEGER := 5); --shift bits
    Port ( 
            A         : IN std_logic_vector(N-1 downto 0);
            SHIFT_AMT : IN std_logic_vector(M-1 downto 0);
            Y         : OUT std_logic_vector(N-1 downto 0)
        );
end srlN;

architecture behavioral of srlN is
    -- create array of vectors to hold each of n shifters
    type shifty_array is array(N-1 downto 0) of std_logic_vector(N-1 downto 0);
    signal aSRL : shifty_array;
    
begin
    generateSRL : for i in 0 to N-1 generate
        aSRL(i)(N-1-i downto 0) <= A(N-1 downto i);
        left_fill   : if i > 0 generate
            aSRL(i)(N-1 downto N-i) <= (others => '0');
         end generate left_fill;
     end generate generateSRL;
-- The value of shift_amt (in binary ) determines number of bits A is shifted .
-- Since shift_amt (in decimal ) must not exceed n -1 so only M bits are used . The default or N=4, 
--      will require 2 shift bits (M=2) , because 2^2 = 4 , the maximum shift.
-- In all cases , 2^M = N.
Y <= aSRL(to_integer(unsigned(SHIFT_AMT))) when (to_integer(unsigned(SHIFT_AMT)) < 32) else (others => '0');
end behavioral;
