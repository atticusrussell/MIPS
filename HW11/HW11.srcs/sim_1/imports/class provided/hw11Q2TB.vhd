library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity hw11Q2TB is
end hw11Q2TB;

architecture tb of hw11Q2TB is
    signal clk, rst, a, b : std_logic := '0';
    signal q : std_logic;
    constant clk_period : time := 10 ns;
begin
	uut: entity work.HW11q3 --hw11Q1Harris4e32fsmSoln
        port map (clk => clk, rst => rst, a => a, b => b, q => q);

    clk <= not clk after clk_period/2;

    stimulus: process
        variable seed1, seed2 : integer := 999;
        variable expected_state : integer := 0; -- s0 = 0, s1 = 1, s2 = 2
        variable expected_q : std_logic := '0';
        variable q_cover_cnt : integer := 0;
        -- the function is impure because it has side effects;
        -- the side effects are seed1 and seed2 changed by uniform procedure
        impure function rand_slv(len : integer) return std_logic_vector is
            variable rand : real;
            variable slv : std_logic_vector(len-1 downto 0);
        begin
            for i in slv'range loop
                uniform(seed1, seed2, rand);
                if rand > 0.5 then
                    slv(i) := '1';
                else
                    slv(i) := '0';
                end if;
            end loop;
            return slv;
        end function;
    begin
        rst <= '1';
        wait for clk_period;
        rst <= '0';
        wait until falling_edge(clk);

        test_loop: loop
            -- create random input, still on falling edge, even when loop repeats
            (a, b) <= rand_slv(2);
            wait until rising_edge(clk);  -- a and b will be updated, fsm will update
            
            -- simulate state machine
            -- use variables so updates are immediate and can be compared with fsm
            case expected_state is
                when 0 => -- s0
					-- ADD: conditions in s0
					if a = '1' then
						expected_state := 1;
						expected_q := '0';
						-- q_cover_cnt := q_cover_cnt;
					else
						expected_state := 0;
                        expected_q := '0';
						-- q_cover_cnt := q_cover_cnt;
					end if;
                when 1 => -- s1
                    if b = '1' then
                        expected_state := 2;
                        expected_q := '1';
                        q_cover_cnt := q_cover_cnt + 1; -- add one every time q = '1'
                    else
                        expected_state := 0;
                        expected_q := '0';
                    end if;
                when others => -- s2
					-- ADD: conditions in s2
					expected_state := 0;
                    expected_q := '0';
					-- q_cover_cnt := q_cover_cnt + 1; -- add one every time q = '1'
            end case;

            wait until falling_edge(clk);
            assert q = expected_q
				-- ADD: report a, b, q, expected_q
				report "Error in result: Expected q is " & std_logic'image(expected_q) & " but q is " & std_logic'image(q) & " and a is " & std_logic'image(a) & " and b is " & std_logic'image(b);
			
            exit test_loop when (q_cover_cnt > 5);
        end loop;
        wait;
    end process;
end tb;
