library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;
use IEEE.math_real.all;

entity hw10q2SRLatch_tb is
end;

architecture bench of hw10q2SRLatch_tb is
  component hw10q2SRLatch
      Port ( s, r : in STD_LOGIC;
        	q : out STD_LOGIC);
  end component;
  signal s, r: STD_LOGIC;
  signal q: STD_LOGIC;
  signal reset_covered, set_covered, hold_after_reset_covered, hold_after_set_covered : integer := 0;
begin
    uut: entity work.hw10q2SRLatch port map (s => s, r => r, q => q );
    stimulus: process
        variable rand: real;
        variable seed1, seed2 : integer := 999;
        variable expected_q : std_logic;
    begin
        --reset latch so hold can be tested in loop
        s <= '0'; r <= '1';
        wait for 10 ns;

        --loop randomly testing all cases 
        test_loop : loop
            uniform(seed1, seed2, rand);
            
            if rand < 0.33 then --test reset
                s <= '0'; r <= '1';
                reset_covered <=  reset_covered + 1;
                expected_q := '0';
                
            elsif rand < 0.66 then --test set
                --completed the assignments for set
                s <= '1'; r <= '0';
                set_covered <=  set_covered + 1;
                expected_q := '1';
                
            else --test hold, remember S and R hold old value until wait
                s <= '0'; r <= '0';
                if (s = '0') and (r = '1') then -- latch was reset
                    hold_after_reset_covered <=  hold_after_reset_covered + 1;
                    expected_q := '0';
                elsif (s = '1') and (r = '0') then -- latch was set
                    hold_after_set_covered <=  hold_after_set_covered + 1;
                    expected_q := '1';
                else --  latch was HOLD
                    expected_q := expected_q;
				end if;
            end if;
            wait for 10 ns;
            --TODO add report the values of s, r , q and expected q
            assert (q = expected_q) report "Error in result: S is " & std_logic'image(s) & " and R is " & std_logic'image(r) & " and Q is " & std_logic'image(q) & " but should be " & std_logic'image(expected_q); 
            
            exit test_loop when (reset_covered > 1) and (set_covered > 1) and (hold_after_set_covered > 1) and (hold_after_reset_covered > 1);
            wait for 10 ns;
        end loop;
		wait;
  	end process;
end;
