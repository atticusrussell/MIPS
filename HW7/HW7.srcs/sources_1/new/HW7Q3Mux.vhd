library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity HW7Q3Mux is
    Port ( a0, a1, a2, a3 : in STD_LOGIC_VECTOR (7 downto 0);
           shift_amt : in STD_LOGIC_VECTOR (1 downto 0);
           y : out STD_LOGIC_VECTOR (7 downto 0));
end HW7Q3Mux;

architecture Behavioral of HW7Q3Mux is
    --create array of vectors to hold each of n shifters
    type shifty_array is array (3 downto 0) of STD_LOGIC_VECTOR(7 downto 0);
    signal y_array : shifty_array;
    begin
        y_array(0)  <= a0;
        y_array(1)  <= a1;
        y_array(2)  <= a2;
        y_array(3)  <= a3;
        y  <=  y_array(to_integer(unsigned(shift_amt)));
end Behavioral;
