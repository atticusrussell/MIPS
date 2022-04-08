----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/24/2022 08:07:59 PM
-- Design Name: 
-- Module Name: hw9q1xorTB - Behavioral
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

entity hw9q1xorTB is
end hw9q1xorTB;

architecture bench of hw9q1xorTB is
    signal a: std_logic_vector(3 downto 0);
    signal y: std_logic;
    file vector_file : text open read_mode is "test.txt";
begin

    hw9_q1_xor4_inst: entity work.Hw9_q1_XOR4
		port map (
			a => a,
			y => y
        );
    stimulus: process
        variable vector_line : line;
        variable vector_valid : boolean;
        variable v_a_in : std_logic_vector(3 downto 0); --read requires a variable begin
        variable v_y_out : std_logic;

    begin
        while not endfile(vector_file) loop
            --ADDED: read a line from the vector file
            readline(vector_file, vector_line);
            --reads v_a_in
            read(vector_line, v_a_in, good => vector_valid);
            --exit loop if vector_valid false which happens when the line starts with #
            next when not vector_valid;
            a <= v_a_in;
            wait for 10 ns; 
            --ADDED: read v_y_out, the expected output
            read(vector_line, v_y_out, good => vector_valid);
            --note: error intentional in input txt file for a is 0010 (2) [line 5)
            assert y = v_y_out report "error in operation at " & time'image(now) & " a= " & to_hstring(a) & " and y = " & std_logic'image(y);
            wait for 10 ns;
        end loop;
        report "testing complete";
        --to exit simulation with a critical error
        assert false report "testbench concluded" severity failure;
        wait;
	end process;
end bench;
