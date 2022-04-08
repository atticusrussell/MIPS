library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity hw8q3TB is
end;

architecture tb of hw8q3TB is
    signal reset : std_logic := '1';
    signal d, clk, enable : std_logic := '0';
    signal dstable10 : boolean := false;
    signal q: std_logic;

begin
    clk <=  not clk after 10 ns;
    uut : entity work.hw8q3 port map 
        ( d     => d,
        clk   => clk,
        reset => reset,
        enable => enable,
        q     => q );
    
    reset <=  '0' after 8 ns; 
    enable <=  '1' after 10 ns, '0' after 40 ns, '1' after 80 ns;

    stimulus: process is begin
        report "testing started on d" severity note;
        d <=  '1' after 20 ns, '0' after 35 ns, '1' after 65 ns;
        wait for 100 ns;
        report "testing continues on d at 100 ns. the next assignments are at 120, 135, and 165 ns"; 
        d <=  '0' after 20 ns, '1' after 35 ns, '0' after 65 ns;
        wait for 200 ns;
        report "testing continues at 300 ns" ;
        d <=  '1' after 20 ns, '0' after 35 ns, '1' after 65 ns;
        wait;
    end process;

    assert not (d'event) or d'stable(10 ns)
        report "d stable for less than 10 ns, " & " not d'event = " & boolean'image(not(d'event)) & "and d'stable(10 ns) = " & boolean'image(d'stable(10 ns)) severity error; 
    dstable10 <=  d'delayed'stable(10 ns);
end tb;
  