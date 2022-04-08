library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity hw2q2fftb is

end hw2q2fftb;

architecture tb of hw2q2fftb is
    signal dTB, clk, clr    : std_logic := '0';
    signal q :  std_logic;
    constant clk_per    : time := 20ns;
    
    type test_rec is record
        dVEC, clr, q : std_logic;
    end record test_rec;
    type test_rec_array is array  ( integer range <> ) of test_rec;
    constant test   : test_rec_array := (
        ('0','1','0'),
        ('1','0','1'),
        ('1','1','0'),
        ('1','0','1'),
        ('0','0','0'));
begin
    dut : entity work.dff
        port map (d => dTB, clk => clk, clr => clr, q=> q);
    clk <= not clk after clk_per/2;
    
    stimuli : process
    begin
        wait until clk = '0';
        for i in test 'range loop
            dTB <= test(i).dVEC;
            clr <= test(i).clr;
            wait for clk_per;
            assert (test(i).q = q ) report "error in result. q is " &
                std_logic 'image(q) & " and should be = " & std_logic 'image(test(i).q);
        end loop;
        wait;
    end process;
end tb;
