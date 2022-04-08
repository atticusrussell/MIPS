----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/01/2022 12:06:41 AM
-- Design Name: 
-- Module Name: hw10q3Variables - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity hw10q3Variables is
    Port ( clk, rst : in STD_LOGIC;
        count_out1, count_out2 : out STD_LOGIC_VECTOR (2 downto 0));
end hw10q3Variables;

architecture rtl of hw10q3Variables is
    signal count_sig : unsigned(2 downto 0);
begin
    --okay in testbench:  will simulate, may synthesize.  good luck debugging if it doesn't
    count_var_proc : process (clk)
        variable count_var : unsigned (2 downto 0) := "000";
    begin
        if rising_edge(clk) then 
            --increment takes place immediately
            count_var := count_var + 1;
            --can check updated variable
            if count_var = "111" then
                count_var := "000";
            end if;
        end if;
        -- can assign to signal but must do so in process (in scope of variable)
        count_out1 <= std_logic_vector(count_var);
    end process count_var_proc; 

    --OK in testbench AND design, will simulate AND synthesize.
    -- reset generally used to initialize
    signal_var_proc: process (clk) begin
        if rising_edge(clk) then
            if rst = '1' then
                count_sig <= "000";
            elsif count_sig = "111" then
                count_sig <= "000";
            else
                count_sig <= count_sig + 1;
            end if;
        end if;
    end process signal_var_proc;
    -- assignments to signal can be outside process
    -- always updating, wire connection
    count_out2 <= std_logic_vector(count_sig);
end rtl;
