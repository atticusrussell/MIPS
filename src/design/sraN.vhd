----------------------------------------------------------------------------------
-- Company: Rochester Institute of Technology
-- Engineer: Atticus Russell ajr8934@rit.edu
-- Design Name: sraN
-- Project Name: Lab1
-- Description: N-bit arithmetic shift Right unit
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity sraN is
    GENERIC (N : INTEGER := 32;  --bit width
             M : INTEGER := 2); --shift bits
    Port ( 
            A         : IN std_logic_vector(N-1 downto 0);
            SHIFT_AMT : IN std_logic_vector(M-1 downto 0);
            Y         : OUT std_logic_vector(N-1 downto 0)
        );
end sraN;

architecture behavioral of sraN is
    -- create array of vectors to hold each of n shifters
    type shifty_array is array(N-1 downto 0) of std_logic_vector(N-1 downto 0);
    signal aSRA : shifty_array;
    
begin
    generateSRA : for i in 0 to N-1 generate
        aSRA(i)(N-1-i downto 0) <= A(N-1 downto i);
        left_fill   : if i > 0 generate
            aSRA(i)(N-1 downto N-i) <= (others => A(N-1));
         end generate left_fill;
     end generate generateSRA;
-- The value of shift_amt (in binary ) determines number of bits A is shifted .
-- Since shift_amt (in decimal ) must not exceed n -1 so only M bits are used . The default or N=4, 
--      will require 2 shift bits (M=2) , because 2^2 = 4 , the maximum shift.
-- In all cases , 2^M = N.
Y <= aSRA(to_integer(unsigned(SHIFT_AMT))) when (to_integer(unsigned(SHIFT_AMT)) < 32) else (others => '0');
end behavioral;
