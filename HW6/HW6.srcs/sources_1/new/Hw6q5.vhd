library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Hw6q5 is
    Port ( 
        shift_amt : in STD_LOGIC_VECTOR (2 downto 0);
        y : out STD_LOGIC_VECTOR (15 downto 0));
end Hw6q5;

architecture Behavioral of Hw6q5 is
    type shifty_array is array (7 downto 0) of std_logic_vector (15 downto 0 );
    signal y_array : shifty_array := (x"89AB",  x"789A", x"6789", x"5678", x"4567",x"3456",x"2345",x"1234");
begin
    y<= y_array(to_integer(unsigned(shift_amt)));
end Behavioral;