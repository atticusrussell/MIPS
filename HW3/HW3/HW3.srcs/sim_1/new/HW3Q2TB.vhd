----------------------------------------------------------------------------------
-- Create Date: 02/04/2022 
-- Module Name: HW3Q2TB - Behavioral
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity HW3Q2TB is
end HW3Q2TB;

architecture tb of HW3Q2TB is
    constant    N : integer := 16;
    signal      d   :    std_logic_vector(n-1 downto 0) := (others => '0');
    signal      clk   : std_logic := '0';
    signal      q :  std_logic_vector(n-1 downto 0);
    constant    clk_per    : time := 20ns;
    
    
    type test_rec is record
        d, q : std_logic_vector(15 downto 0);
    end record test_rec;
    type test_rec_array is array  ( integer range <> ) of test_rec;
    -- give q and d values, can be any values
    constant test : test_rec_array := (
        (x"6543",x"6543"),  ---give q and d the same values
        (x"3AB7",x"9BE2"),  ---error make d and q different
        (x"2AB3",x"2AB3"));  ---give q and d the same values
        
begin
    --instantiate the test design (ff device) using the constant N
    dut : entity work.hw3prob1
        generic map (N=>N)
        port map (d => d, clk => clk, q=> q);
        
    clk <= not clk after clk_per/2;
    
    stimuli : process
    begin
        wait until clk = '0'; --falling edge of clk
        for i in test 'range loop
            d <= test(i).d;
            wait for clk_per;
            assert (test(i).q = q ) report "error in result. q is " &
                to_hstring(q) & " and should be = " & to_hstring(test(i).q);
        end loop;
        wait;
    end process;
end tb;
