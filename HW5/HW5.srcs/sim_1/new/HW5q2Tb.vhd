library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;

entity HW5q2TB is
--  Port ( );
end HW5q2TB;

architecture tb of HW5q2TB is
    signal w : std_logic_vector(2 downto 0) := (others => '0');
    signal f : std_logic;
    constant f_ans : std_logic_vector(0 to 7) := "00101101";
begin
    dut : entity work.HW5q2
        port map  (w => w, f=> f);
    
    stimuli : process
    begin
        -- this test bench style uses a loop that is nice when checking
            -- functions that relate easily with a truth table.
       -- i will always be an integer. To convert i to a 3-bit std_logic_vector
            -- use std_logic_vector(to_unsigned(i,3)) where the 3 tells the function
            -- you want 3 buts. The conversion to unsigned goes first to avoid
            -- negative bits
        
        for i in 0 to 7 loop
            w <= std_logic_vector(to_unsigned(i, 3));
            wait for 10 ns;  --don't forget the wait before checking the outputs
            assert f = f_ans(i) report "error, f should be " & std_logic'image(f_ans(i)) & 
            " not f = " & std_logic'image(f);
            wait for 10 ns;
        end loop;
    wait;
end process;

end tb;