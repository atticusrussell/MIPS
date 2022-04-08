----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/24/2022 11:43:20 PM
-- Design Name: 
-- Module Name: hw9q2sevensegTB - bench
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

entity hw9q2sevensegTB is
end hw9q2sevensegTB;

architecture bench of hw9q2sevensegTB is
    signal data : std_logic_vector(3 downto 0);
    signal segments: std_logic_vector(6 downto 0);
    file vector_file : text open read_mode is "testq2.txt";
begin

    hw9q2sevenseg_inst: entity work.hw9q2sevenseg
        port map (
            data     => data,
            segments => segments
        );
    stimulus: process
        variable vector_line : line;
        variable vector_valid : boolean;
        variable v_data_in : std_logic_vector(3 downto 0); --read requires data variable begin
        variable v_segments_out : std_logic_vector(6 downto 0);

    begin
        while not endfile(vector_file) loop
            --ADDED: read a line from the vector file
            readline(vector_file, vector_line);
            --reads v_data_in
            read(vector_line, v_data_in, good => vector_valid);
            --exit loop if vector_valid false which happens when the line starts with #
            next when not vector_valid;
            data <= v_data_in;
            wait for 10 ns; 
            --ADDED: read v_segments_out, the expected output
            read(vector_line, v_segments_out, good => vector_valid);
            --note: error intentional in input txt file for data is 1100 (12 or C) [line 15]
            assert segments = v_segments_out report "error in operation at " & time'image(now) & " data = " & to_hstring(data) & " and segments = " & to_hstring(segments);
            wait for 10 ns;
        end loop;
        report "testing complete";
        --to exit simulation with a critical error
        assert false report "testbench concluded" severity failure;
        wait;
	end process;
end bench;

