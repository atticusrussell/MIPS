----------------------------------------------------------------------------------
-- Create Date: 02/04/2022 
-- Module Name: hw3q4tb
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity hw3q4tb is
end hw3q4tb;

architecture tb of hw3q4tb is
    signal addr      :     std_logic_vector (2 downto 0) := (others => '0');
    signal clk, we   :     std_logic := '0';
    signal din       :     std_logic_vector (5 downto 0) := (others => '0');
    signal dout      :    std_logic_vector(5 downto 0) := (others => '0');
    constant  clk_per  : time := 20ns;
begin
    dut : entity work.hw3Ex3Mem
        port map (addr => addr, din=>din, clk => clk, we=> we, dout =>dout);
       
    clk <= not clk after clk_per/2;
    
    stimuli : process
    begin
        we <= '0';
        
        addr <= "000";
        wait for 10 ns;
        assert ("000001" = dout) report "error in result. dout is " &
                to_hstring(dout) & " and should be = " & to_hstring("000001");
        wait for 10 ns;
        
        addr <= "011";
        wait for 10 ns;
        assert ("001111" = dout) report "error in result. dout is " &
                to_hstring(dout) & " and should be = " & to_hstring("001111");
        wait for 10 ns;
        
        addr <= "111";
        wait for 10 ns;
        assert ("001111" = dout) report "error in result. dout is " &
                to_hstring(dout) & " and should be = " & to_hstring("001111");
        wait for 10 ns;
        
        wait until clk = '0'; --falling edge of clk
        we <= '1';
        addr <= "000";
        din <= "111111";
        wait for clk_per;
        
        addr <= "100";
        din <= "111000";
        wait for clk_per;
        
        addr <= "110";
        din <= "111110";
        wait for clk_per;
        
        we <= '0';
        
        addr <= "000";
        wait for 10 ns;
        assert ("111111" = dout) report "error in result. dout is " &
                to_hstring(dout) & " and should be = " & to_hstring("111111");
        wait for 10 ns;
        
        addr <= "100";
        wait for 10 ns;
        assert ("111000" = dout) report "error in result. dout is " &
                to_hstring(dout) & " and should be = " & to_hstring("111000");
        wait for 10 ns;
        
        addr <= "110";
        wait for 10 ns;
        assert ("111110" = dout) report "error in result. dout is " &
                to_hstring(dout) & " and should be = " & to_hstring("111110");
        wait for 10 ns;
    
        wait;
    end process;
end tb;
