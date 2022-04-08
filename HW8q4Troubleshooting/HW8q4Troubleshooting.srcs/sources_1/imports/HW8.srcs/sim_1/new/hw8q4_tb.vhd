library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;
use IEEE.std_logic_unsigned.all;

entity hw8q4_tb is
end;

architecture bench of hw8q4_tb is
    signal a, b, c, d : std_logic := '0';
    signal sel : std_logic_vector(1 downto 0) :=  (others =>  '0');
    signal z : std_logic;
begin

    dut: entity work.hw8q4 port map ( 
        a   => a,
        b   => b,
        c   => c,
        d   => d,
        sel => sel,
        z   => z);

    --a <=  '1' after 100 ns;
    sel <= sel + 1 after 200 ns;
    stimulus: process
        begin

        -- Put initialisation code here


        -- Put test bench stimulus code here
            wait for 100 ns;
            a <=  '1';
            wait for 200 ns;
            b <= '1';
            wait for 200 ns;
            c <= '1';
            wait for 200 ns;
            d <= '1';
            wait;  
    end process;

    -- sel_proc : process 
    -- begin
    --     sel <= sel + 1 after 200 ns;
    -- end process;
    assert not a'event 
        report "a did a thing";
end bench;
