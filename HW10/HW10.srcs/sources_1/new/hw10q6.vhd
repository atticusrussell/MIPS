library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity hw10q6 is
    Port (
        clk, rst, ta, tb: in std_logic;
        la, lb: out std_logic_vector(1 downto 0)
    );
end hw10q6;

architecture synth of hw10q6 is
    type statetype is(s0, s1, s2, s3);
    signal state, nextstate : statetype;
    constant green : std_logic_vector(1 downto 0) := "00";
    constant yellow : std_logic_vector(1 downto 0) := "01";
    constant red : std_logic_vector(1 downto 0) := "10";

begin
    clk_rst_proc : process(clk) begin
        if rising_edge(clk) then
            if rst = '1' then
                state <= s0;
            else
                state <= nextstate;
    		end if;
    	end if;
    end process clk_rst_proc;

    nextstate_proc: process (state, ta, tb) begin
        case state is
            when s0 => 
                if ta = '0' then
                    nextstate <=  s1;
                else
                    nextstate <=  s0;
                end if;
            when s1 =>
                nextstate <= s2;
            when s2 =>
                if tb = '0' then
                    nextstate <= s3;
                else
                    nextstate <= s2;
				end if;
            when s3 =>
                nextstate <= s0;
        end case;
    end process nextstate_proc;

    la_proc: process (state) is
    begin
        case state is
            when s0 =>
                la <= green;
            when s1 =>
                la <=  yellow;
            when s2 =>
                la <= red;
            when s3 =>
                la <= red;
		end case;
    end process la_proc;

    lb_proc: process (state) is
    begin
        case state is
            when s0 =>
				lb <= red;
            when s1 =>
                lb <= red;
            when s2 =>               
                lb <= green;
            when s3 =>
                lb <= yellow;
		end case;
    end process lb_proc;
end synth;
