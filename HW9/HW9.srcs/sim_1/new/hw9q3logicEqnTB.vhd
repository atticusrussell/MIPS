----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/25/2022 01:05:30 AM
-- Design Name: 
-- Module Name: hw9q3logicEqnTB - bench
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
use IEEE.std_logic_textio.all;
library std;
use std.textio.all;

entity hw9q3logicEqnTB is
end hw9q3logicEqnTB;

architecture bench of hw9q3logicEqnTB is
    signal a, b, c, y: std_logic;
    file vector_file : text open read_mode is "testq3.txt";
begin

    hw9q3logiceqn_inst: entity work.hw9q3logicEqn
        port map (a => a, b => b, c => c, y => y
        );
    stimulus: process
        variable vector_line : line;
        variable vector_valid : boolean;
        variable v_a_in, v_b_in, v_c_in, v_y_out : std_logic; --read requires a variable 
    begin
        while not endfile(vector_file) loop
            --ADDED: read a line from the vector file
            readline(vector_file, vector_line);
            --reads v_a_in
            read(vector_line, v_a_in, good => vector_valid);
            --exit loop if vector_valid false which happens when the line starts with #
            next when not vector_valid;
            a <= v_a_in;
            --reads v_b_in
            read(vector_line, v_b_in, good => vector_valid);
            b <= v_b_in;
            --reads v_c_in
            read(vector_line, v_c_in, good => vector_valid);
            c <= v_c_in;

            wait for 10 ns; 
            --ADDED: read v_y_out, the expected output
            read(vector_line, v_y_out, good => vector_valid);
            --note: error intentional in input txt file for a b c of 001. y is 1 but should be 0.
            assert y = v_y_out report 
            "error in operation at " & time'image(now) 
                & " a = " & std_logic'image(a) 
                & ", b = " & std_logic'image(b)
                & " c = " & std_logic'image(c)  
                & ", and y = " & std_logic'image(y) 
                & ". y expected to be " & std_logic'image (v_y_out)
                & " and a, b, c expected to be : " & std_logic'image(v_a_in) 
                & ", " & std_logic'image(v_b_in) 
                & ", " & std_logic'image(v_c_in) ;
            wait for 10 ns;
        end loop;
        report "testing complete";
        --to exit simulation with a critical error
        assert false report "testbench concluded" severity failure;
        wait;
    end process;
end bench;
