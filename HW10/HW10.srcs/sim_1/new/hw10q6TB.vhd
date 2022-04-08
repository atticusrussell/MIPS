--provided self-checking Testbench code for HW 10

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.math_real.all;
use work.flagpackage.all; 

entity hw10q6TB is
end hw10q6TB;

architecture bench of hw10q6TB is
    signal clk, rst, ta, tb: std_logic := '0';
    signal la, lb: std_logic_vector(1 downto 0);
    constant clk_period: time := 10 ns;

    signal ExpectedLa, ExpectedLb : std_logic_vector(1 downto 0);
    signal la_red_cnt, la_grn_cnt: integer := 0;
    signal lb_red_cnt, lb_grn_cnt: integer := 0;
    shared variable fsm_adv : flags;

    constant green: std_logic_vector(1 downto 0) := "00";
    constant yellow: std_logic_vector(1 downto 0) := "01";
    constant red: std_logic_vector(1 downto 0) := "10";
    constant invalid_clr: std_logic_vector(1 downto 0) := "11";

begin
    uut : entity work.hw10q6 port map (clk => clk, rst =>  rst, ta => ta, tb => tb, la => la, lb => lb);

    clk <=  not clk after clk_period / 2;

    stimulus: process 
        variable rand : real;
        variable seed1, seed2 : integer := 999;
    begin
        --reset latch so hold can be tested in loop
        rst <= '1';
        wait for clk_period;
        wait until clk = '0';
        rst <= '0';

        --loop randomly testing all cases 
        test_loop : loop
            --randomly pick inputs
            uniform(seed1, seed2, rand);
            
            if rand < 0.25 then         --both advance
                ta <= '0';
                tb <= '0';
                fsm_adv.en_la(true);
                fsm_adv.en_lb(true);

            elsif rand < 0.5 then       --only la advance
                ta <= '0';
                tb <= '1';
                fsm_adv.en_la(true);
                fsm_adv.en_lb(false);

            elsif rand < 0.75 then      --only lb advance
                ta <= '1';
                tb <= '0';
                fsm_adv.en_la(false);
                fsm_adv.en_lb(true);
            else                        --neither advance
                ta <= '1';
                tb <= '1';
                fsm_adv.en_la(false);
                fsm_adv.en_lb(false);
            end if;
            wait for clk_period;
            assert la = ExpectedLa and lb = ExpectedLb
                report "Error: not correct state";
            exit test_loop when (la_grn_cnt > 1) and (la_red_cnt > 1) and (lb_grn_cnt > 1) and (lb_red_cnt > 1);
            wait for 10 ns;
        end loop;
		wait;
    end process;

    state_machine_sim: process begin
        wait until clk = '1';
        if rst = '1' then                       --s0
            ExpectedLa <= green;
            ExpectedLb <= red;
        else
            case (ExpectedLa & ExpectedLb) is
                when green & red =>             
                    if fsm_adv.GetLa then         --s0 to s1
                        ExpectedLa <=  yellow;
                        ExpectedLb <=  red;
                        la_grn_cnt <= la_grn_cnt + 1; --la leaves green, count it
                    end if;
                when yellow & red =>             --s1 to s2      
                    ExpectedLa <=  red;
                    ExpectedLb <=  green;
                    lb_red_cnt <= lb_red_cnt + 1; --lb leaves red, count it
                when red & green =>             
                    if fsm_adv.GetLb then       --s2 to s3
                        ExpectedLa <=  red;
                        ExpectedLb <=  yellow;
                        lb_grn_cnt <= lb_grn_cnt + 1; --lb leaves green, count it
                    end if;
                when red & yellow =>             --s3 to s0   
                    ExpectedLa <=  green;
                    ExpectedLb <=  red;
                    la_red_cnt <= la_red_cnt + 1;   --la leaves red, count it
                when others =>                      -- s3 to s0
                    ExpectedLa <= invalid_clr;  
                    ExpectedLb <= invalid_clr;
            end case;
        end if;
    end process state_machine_sim;
end bench;
