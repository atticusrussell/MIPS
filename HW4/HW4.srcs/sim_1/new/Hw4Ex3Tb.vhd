library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Hw4Ex3Tb is
end Hw4Ex3Tb;

architecture tb of Hw4Ex3Tb is
    signal sw :     std_logic_vector(1 downto 0) := (others =>'0');
    signal bulb:    std_logic;
    signal sw_out : std_logic_vector(1 downto 0); 
begin
    dut :   entity work.Hw4Ex3
        port map(sw => sw, bulb => bulb, sw_out=>sw_out);
        
    stimuli:process
    begin
        sw <= "00"; --both off
        wait for 10 ns; -- always wait after assignment so logic can complete
        assert bulb = '0' report "error, bulb should be off when both switches are off.";
        assert sw_out = sw report "error, bulb should equal sw, feed thru signal.";
        
        sw <= "01"; --one on
        wait for 10 ns; 
        assert bulb = '1' report "error, bulb should be on when one switch is on.";
        assert sw_out = sw report "error, bulb should equal sw, feed thru signal.";
        
        sw <= "10"; --one on
        wait for 10 ns; 
        assert bulb = '1' report "error, bulb should be on when one switch is on.";
        assert sw_out = sw report "error, bulb should equal sw, feed thru signal.";
        
        sw <= "11"; --both on
        wait for 10 ns; 
        assert bulb = '0' report "error, bulb should be off when both switches are off.";
        assert sw_out = sw report "error, bulb should equal sw, feed thru signal.";
        
        wait;
    end process;
end tb;
