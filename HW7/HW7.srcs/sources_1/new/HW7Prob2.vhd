library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity HW7Prob2 is
    Port ( clk, rst : in STD_LOGIC;
           w : in STD_LOGIC_VECTOR (1 downto 0);
           z, InIdle : out STD_LOGIC);
end HW7Prob2;

architecture Behavioral of HW7Prob2 is
    type state_type is (idle, s1, s2, s3, s4);
    signal state, next_state : state_type;
begin
    state_proc : process (clk) is begin
        if (rising_edge(clk)) then
            if (rst = '1') then
                state <= idle;
            else
                state <= next_state;
            end if;
        end if;
    end process state_proc;
    next_state_process : process (state, w) is begin
        case (state) is
            when idle =>
                if (w = "00") or (w = "11") then
                    next_state <= s1;
                else
                    next_state <= idle;
                end if;
            when s1 =>
                if (w = "00") or (w = "11") then
                    next_state <= s2;
                else
                    next_state <= idle;
                end if;
            when s2 =>
                if (w = "00") or (w = "11") then
                    next_state <= s3;
                else
                    next_state <= idle;
                end if;
            when s3 =>
                if (w = "00") or (w = "11") then
                    next_state <= s4;
                else
                    next_state <= idle;
                end if;
            when s4 =>
                if (w = "00") or (w = "11") then
                    next_state <= s4;
                else
                    next_state <= idle;
                end if;
        end case;
    end process next_state_process;
    InIdle_proc : process (clk) is begin
        if rising_edge(clk) then
            case (next_state) is
                when idle =>   InIdle <= '1';
                when others => InIdle <= '0';
            end case;
        end if;
    end process InIdle_proc;
    z_proc : process (clk) is begin
        if rising_edge(clk) then
            case (next_state) is
                when s4 =>   z <= '1';
                when others => z <= '0';
            end case;
        end if;
    end process z_proc;
end Behavioral;
