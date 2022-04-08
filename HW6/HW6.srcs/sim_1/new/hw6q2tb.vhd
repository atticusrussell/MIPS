library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity hw6q2tb is
end hw6q2tb;

architecture tb of hw6q2tb is
    signal w: std_logic_vector(7 downto 0) := (others =>'0');
    signal y: std_logic_vector(2 downto 0);
begin
dut : entity work.hw6q2
        port map(w=>w,y=>y);
        
        stimuli: process
            variable test_vector : unsigned(7 downto 0) := "00000001";
            variable test_result : unsigned(2 downto 0) := "000";
        begin
            for i in 0 to 7 loop
            w <= std_logic_vector(test_vector);
            wait for 10 ns;
            test_vector := shift_left(test_vector,1);
            assert y=std_logic_vector(test_result) 
                report "error, expected " & to_hstring(test_result) &
                    " actual value is " & to_hstring(y);
            test_result := test_result + 1;
            wait for 10 ns;
            
            end loop;
            wait;
        end process;

end tb;
