library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity hw6q4tb is
end hw6q4tb;

architecture tb of hw6q4tb is
    signal bin: std_logic_vector(3 downto 0) := (others =>'0');
    signal leds: std_logic_vector(1 to 7);

type test_rec is record
    bin : std_logic_vector;
    leds : std_logic_vector;
end record test_rec;

type test_rec_array is array (integer range <>) of test_rec;


constant test : test_rec_array :=(
        ("0000", 7UX"7E"),
        ("0001", 7UX"30"),
        ("0010", 7UX"6D"),
        ("0011", 7UX"79"),
        ("0100", 7UX"33"),
        ("0101", 7UX"5B"),
        ("0110", 7UX"5F"),
        ("0111", 7UX"70"),
        ("1000", 7UX"7F"),
        ("1001", 7UX"7B"),
        ("1010", 7UX"77"),
        ("1011", 7UX"7F"),
        ("1100", 7UX"4E"),
        ("1101", 7UX"3D"),
        ("1110", 7UX"4F"),
        ("1111", 7UX"47"));
    begin
    dut : entity work.hw6q4
        port map(bin=>bin,leds=>leds);
        stimuli: process
        begin
            for i in test'range loop
                bin <= test(i).bin;
                wait for 10 ns;
                assert (test(i).leds=leds) report "error in result. led is " & to_hstring(leds) &
                    " and should be " & to_hstring(test(i).leds) & " when the binary is " &
                    to_hstring(test(i).bin);
                    wait for 10 ns;
                
            end loop;
            wait;
        end process;
end tb;
