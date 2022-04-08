library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Hw4Ex2Tb is
end Hw4Ex2Tb;

architecture tb of Hw4Ex2Tb is
    signal d_in, clk, rst   :   std_logic := '0';
    signal q_out    :   std_logic;
    constant    clk_per : time := 20 ns;
begin
    dut :   entity work.Hw4Ex2
        port map(d_in => d_in, clk => clk, rst=>rst, q_out => q_out);
        
    clk <= not clk after clk_per/2;
    
    stimuli:process
    begin
        rst <= '1';
        wait until clk = '0'; --falling edge
        assert q_out = '0' report "error1, q_out is "& std_logic'image(q_out) & " but expected to be 0";
        
        rst <= '0';
        d_in <='0';
        wait for 2*clk_per;
        assert q_out = '0' report "error2, q_out is "& std_logic'image(q_out) & " but expected to be 1";
        
        d_in <='1';
        wait for 3*clk_per;
        assert q_out = '1' report "error3, q_out is "& std_logic'image(q_out) & " but expected to be 1";
        
        wait for 2*clk_per;
        assert q_out = '0' report "error4, q_out is "& std_logic'image(q_out) & " but expected to be 0";
        
        d_in <='0';
        wait for 2*clk_per;
        assert q_out = '0' report "error5, q_out is "& std_logic'image(q_out) & " but expected to be 0";
        
        d_in <='1';
        wait for 2*clk_per;
        assert q_out = '0' report "error6, q_out is "& std_logic'image(q_out) & " but expected to be 0";
        
        d_in <='0';
        wait for 2*clk_per;
        assert q_out = '0' report "error7, q_out is "& std_logic'image(q_out) & " but expected to be 0";
        
        wait;
    end process;
end tb;
