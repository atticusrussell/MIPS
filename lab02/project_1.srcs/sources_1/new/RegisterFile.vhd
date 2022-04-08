-------------------------------------------------
--  File:          RegisterFile.vhd
--
--  Entity:        RegisterFile
--  Architecture:  distributed ram  
--  Author:        Atticus Russell
--  Created:       1/25/2022
--  Assignment:  RIT CMPE 260 DSD 2 Exercise 2
--  Description:    Pulled from Distributed RAM template and modified to fit assignment
-------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;



entity RegisterFile is
    generic(
        BIT_DEPTH : integer := 8; -- original 8
        LOG_PORT_DEPTH : integer := 3 -- original 3
	);
    port (clk_n   : in std_logic;
          WE    : in std_logic; --write enable
          -- following are log_port_depth bits - just defaults to 3
          Addr1 : in std_logic_vector (LOG_PORT_DEPTH-1 downto 0); -- selects which of the 8 reg should go rd1
          Addr2 : in std_logic_vector (LOG_PORT_DEPTH-1 downto 0); -- selects which of the 8 reg should go rd2
          Addr3 : in std_logic_vector (LOG_PORT_DEPTH-1 downto 0); -- selects which of the 8 reg to write to
          
          --following are *bit width* -- defaults to 8
          wd    : in std_logic_vector (BIT_DEPTH-1 downto 0); -- data to write to addr 3
          
          rd1   : out std_logic_vector (BIT_DEPTH-1 downto 0);-- data read from addr1
          rd2   : out std_logic_vector (BIT_DEPTH-1 downto 0));-- data read from addr2
end RegisterFile;

architecture syn of RegisterFile is
                            -- 8 registers       -each register 1 byte (8 bits), 64 bits total
    type ram_type is array (2**LOG_PORT_DEPTH downto 0) of std_logic_vector (BIT_DEPTH-1 downto 0);
    signal RAM : ram_type;
begin
    process (clk_n)
    begin
        -- the clock for the register file is falling edge triggered
        --clk_n'event is an edge btw
        if (clk_n'event and clk_n = '0') then
            --if write enabled
            if (WE = '1') then
                --accesses RAM at index specified by addr3 to be written to and writes data in wd
                RAM(to_integer(unsigned(Addr3))) <= wd;
                
            end if;
        end if;
    end process;
    rd1 <= "00000000" when Addr1 = "000" else RAM(to_integer(unsigned(Addr1)));
    rd2 <= "00000000" when Addr2 = "000" else RAM(to_integer(unsigned(Addr2)));
end syn;

					
				