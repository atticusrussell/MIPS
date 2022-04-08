library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity HW7Q4Mux is
    Port ( a0, a1, a2, a3 : in STD_LOGIC_VECTOR (7 downto 0);
           shift_amt : in STD_LOGIC_VECTOR (1 downto 0);
           y : out STD_LOGIC_VECTOR (7 downto 0));
end HW7Q4Mux;

architecture Behavioral of HW7Q4Mux is
    --create array of vectors to hold each of n shifters
    type shifty_array is array (3 downto 0) of STD_LOGIC_VECTOR(7 downto 0);
    signal y_array : shifty_array;
    begin
        y_array(0)  <= "00" & a0(7 downto 2);  -- shift a0 2 bits right
        y_array(1)  <= "000" & a1(7 downto 3); -- shift a1 3 bits right
        y_array(2)  <= a2(6 downto 0) & '0';   -- shift a2 1 bit left
        y_array(3)  <= a3(5 downto 0) & "00";  -- shift a3 2 bits left 
        y  <=  y_array(to_integer(unsigned(shift_amt)));
end Behavioral;