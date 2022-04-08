library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity hw8q1_tb is
end;

architecture tb of hw8q1_tb is

    signal d, clk : std_logic := '0';
    signal reset : std_logic := '1';
    signal d_event : std_logic;
    signal q: std_logic;

    constant clock_period: time := 10 ns;
    signal stop_the_clock: boolean;

begin
    clk <=  not clk after 10 ns;
    uut : entity work.hw8q1 port map 
        ( d     => d,
        clk   => clk,
        reset => reset,
        q     => q );

    d <=  '1' after 20 ns, '0' after 35 ns, '1' after 45 ns;

    stimulus: process is begin
        wait on d; -- wait for an event on d
        d_event <= '1';
        wait for 1 ps;
        d_event <= '0';
    end process;

  reset <= '0' after 8 ns;

  assert not d'event report "d event going true";
  assert d'event report "d event going false";

end tb;
  