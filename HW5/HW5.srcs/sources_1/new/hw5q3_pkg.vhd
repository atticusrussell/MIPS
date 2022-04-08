library ieee;
use ieee.std_logic_1164.all;

package hw5Q3_pkg is
    constant a_width : positive := 3;
    --add a constant d_width and set it to 8
    constant d_width: positive :=8;
    
    type mem_type is array (natural range<>) of std_logic_vector;
    constant clk_per : time := 20 ns;
end package hw5Q3_pkg;