
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use Ieee.numeric_std.all;



entity hw6q1tb is
end hw6q1tb;

architecture tb of hw6q1tb is
    signal w: std_logic_vector(3 downto 0) := (others =>'0');
    signal y: std_logic_vector(1 downto 0);
begin
    dut : entity work.hw6q1
        port map(w=>w,y=>y);
        
        stimuli: process
            variable test_vector : unsigned(3 downto 0) := "0001";
            variable test_result : unsigned(1 downto 0) := "00";
        begin
            for i in 0 to 3 loop
            w <= std_logic_vector(test_vector);
            wait for 10 ns;
            test_vector := shift_left(test_vector,1);
            assert y=std_logic_vector(test_result) report "error, expected " & to_hstring(test_result) &
            " actual value is " & to_hstring(y);
            test_result := test_result + 1;
            wait for 10 ns;
            
            end loop;
            wait;
        end process;
end tb;
