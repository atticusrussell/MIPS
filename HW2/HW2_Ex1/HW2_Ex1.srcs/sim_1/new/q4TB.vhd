library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity hw2q4fftb is

end hw2q4fftb;

architecture tb of hw2q4fftb is
    signal d, clk, en    : std_logic := '0';
    signal q :  std_logic;
    constant clk_per    : time := 20ns;
    
    type test_rec is record
        d, en, q : std_logic;
    end record test_rec;
    type test_rec_array is array  ( integer range <> ) of test_rec;
    constant test   : test_rec_array := (
        ('0'q4TB.vhd,'1','0'),
        ('1','1','1'),
        ('0','0','1'),
        ('0','0','1'),
        ('1','0','0'));
begin
    dut : entity work.hw3_q3_soln_D_FF_synch_en
        port map (d => d, clk => clk, en => en, q=> q);
    clk <= not clk after clk_per/2;
    
    stimuli : process
    begin
        wait until clk = '0';
        for i in test 'range loop
            d <= test(i).d;
            en <= test(i).en;
            wait for clk_per;
            assert (test(i).q = q ) report "error in result. q is " &
                std_logic 'image(q) & " and should be = " & std_logic 'image(test(i).q);
        end loop;
        wait;
    end process;
end tb;
