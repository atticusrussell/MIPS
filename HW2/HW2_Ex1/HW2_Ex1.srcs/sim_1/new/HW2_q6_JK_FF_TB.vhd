library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity HW2_q6_JK_FF_TB is
end HW2_q6_JK_FF_TB;

architecture tb of HW2_q6_JK_FF_TB is
    signal j, k, clk, rst    : std_logic := '0';
    signal q :  std_logic;
    constant clk_per    : time := 20ns;
    
    type test_rec is record
        j, k, rst, q : std_logic;
    end record test_rec;
    type test_rec_array is array  ( integer range <> ) of test_rec;
    constant test   : test_rec_array := (
        ('0', '0', '1', '0'),
        ('0', '0', '1', '1'),
        ('0', '0', '0', '0'),
        ('1', '0', '0', '1'),
        ('0', '1', '0', '0'),
        ('1', '1', '0', '1'));
begin
    dut : entity work.hw2_q5_jk_FF
        port map (j => j, k=> k, clk => clk, rst => rst, q=> q);
    clk <= not clk after clk_per/2;
    
    stimuli : process
    begin
        wait until clk = '0';
        for i in test 'range loop
            j <= test(i).j;
            k <= test(i).k;
            rst <= test(i).rst;
            wait for clk_per;
            assert (test(i).q = q ) report "error in result. q is " &
                std_logic 'image(q) & " and should be = " & std_logic 'image(test(i).q);
        end loop;
        wait;
    end process;
end tb;