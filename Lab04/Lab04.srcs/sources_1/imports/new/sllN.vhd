----------------------------------------------------------------------------------
-- Company: Rochester Institute of Technology
-- Engineer: Atticus Russell ajr8934@rit.edu
-- 
-- Create Date: 01/17/2022 08:20:24 PM
-- Design Name: sllN
-- Module Name: sllN - behavioral
-- Project Name: Lab1
-- Target Devices: Basys3
--
-- Description: N-bit logical left shift (SLL) unit
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity sllN is
    GENERIC (N : INTEGER := 32;  --bit width --default32
             M : INTEGER := 2); --shift bits -- default 2
    Port ( 
            A         : IN std_logic_vector(N-1 downto 0);
            SHIFT_AMT : IN std_logic_vector(M-1 downto 0);
            Y         : OUT std_logic_vector(N-1 downto 0)
        );
end sllN;

architecture behavioral of sllN is
    -- create array of vectors to hold each of n shifters
    type shifty_array is array(N-1 downto 0) of std_logic_vector(N-1 downto 0);
    signal aSLL : shifty_array;
    
begin
    generateSLL : for i in 0 to N-1 generate
        aSLL(i)(N-1 downto i) <= A(N-1-i downto 0);
        left_fill   : if i > 0 generate
            aSLL(i)(i-1 downto 0) <= (others => '0');
         end generate left_fill;
     end generate generateSLL;
-- The value of shift_amt (in binary ) determines number of bits A is shifted .
-- Since shift_amt (in decimal ) must not exceed n -1 so only M bits are used . The default or N=4, 
--      will require 2 shift bits (M=2) , because 2^2 = 4 , the maximum shift.
-- In all cases , 2^M = N.
Y <= aSLL(to_integer(unsigned(SHIFT_AMT)));
end behavioral;
