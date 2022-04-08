library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.hw5Q3_pkg.all;

entity hw5q3tb is
end hw5q3tb;

architecture tb of hw5q3tb is
    signal addr : std_logic_vector(a_width-1 downto 0) := (others => '0');
    signal d_in : std_logic_vector(d_width-1 downto 0) := (others => '0');
    signal clk, we : std_logic:= '0';
    signal d_out : std_logic_vector(d_width-1 downto 0) := (others => '0');
   
begin
    dut : entity work.hw5q3mem
        port map(
            addr  => addr,
            d_in  => d_in,
            clk   => clk,
            we    => we,
            d_out => d_out
        );
        clk <= not clk after clk_per/2;
    stimuli: process
    begin
        --disable write
        we <='0';
        --reads and checks location 0
        addr <= "000";
        wait for 10 ns;
        assert (x"FE" = d_out) report "error in result. d_out is " &
            to_hstring(d_out) & " and should be = FE";
        wait for 10 ns;
        
        --read and check location 1
        addr <= "001";
        wait for 10 ns;
        assert (x"0F" = d_out) report "error in result. d_out is " &
            to_hstring(d_out) & " and should be = 0F";
        wait for 10 ns;
        
        --read and check location 6
        addr <= "110";
        wait for 10 ns;
        assert (x"01" = d_out) report "error in result. d_out is " &
            to_hstring(d_out) & " and should be = 01";
        wait for 10 ns;
        
        wait until clk = '0';
        --enable write
        we <= '1';
        --writes location 0
        addr <= "000";
        d_in <= x"FF";
        wait for clk_per;
        
        --write location 4
        addr <= "100";
        d_in <= x"69";
        wait for clk_per;
        
        --write location 6
        addr <= "110";
        d_in <= x"42";
        wait for clk_per;
        
        --disable write
        we <= '0';
        
        --read and check location 0
        addr <= "000";
        wait for 10 ns;
        assert (x"FF" = d_out) report "error in result. d_out is " &
            to_hstring(d_out) & " and should be = FF";
        wait for 10 ns;
        
        --read and check location 4
        addr <= "100";
        wait for 10 ns;
        assert (x"69" = d_out) report "error in result. d_out is " &
            to_hstring(d_out) & " and should be = 69";
        wait for 10 ns;
        
         --read and check location 6
        addr <= "110";
        wait for 10 ns;
        assert (x"42" = d_out) report "error in result. d_out is " &
            to_hstring(d_out) & " and should be = 42";
        wait for 10 ns;
        
        end process;
    
end architecture tb;
